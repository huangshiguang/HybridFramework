//
//  AddressBookContainerAPI.m
//  CredooHybridFramework
//
//  Created by 黄世光 on 2016/11/18.
//  Copyright © 2016年 Credoo. All rights reserved.
//

#import "AddressBookContainerAPI.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0f)
@interface AddressBookContainerAPI()
@property(nonatomic,copy)NSMutableDictionary *phoneWithNameDic;
@end
@implementation AddressBookContainerAPI
-(instancetype)init{
    if (self = [super init]) {
        self.apiName = @"/api/getContacts";
    }
    return self;
}
-(NSMutableDictionary *)phoneWithNameDic{
    if (!_phoneWithNameDic) {
        _phoneWithNameDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _phoneWithNameDic;
}
- (void)cnLoadPerson{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status != CNAuthorizationStatusAuthorized) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            NSLog(@"没有获取通讯录权限");
        });
    }else{
        [self cnCopyAddressBook];
    }
}
- (void)cnCopyAddressBook{
    //1.创建联系人仓库
    CNContactStore *store = [[CNContactStore alloc] init];
    // 2.创建联系人的请求对象
    // keys决定这次要获取哪些信息,比如姓名/电话
    NSArray *fetchKeys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    // 3.3.请求联系人
    NSError *error = nil;
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // stop是决定是否要停止
        // 1.获取姓名
        NSString *firstname = contact.givenName;
        NSString *lastname = contact.familyName;
        NSString *name = [NSString stringWithFormat:@"%@ %@", firstname, lastname];
        NSMutableArray * phoneArr = [NSMutableArray array];
        // 2.获取电话号码
        NSArray *phones = contact.phoneNumbers;
        // 3.遍历电话号码
        for (CNLabeledValue *labelValue in phones) {
            CNPhoneNumber *phoneNumber = labelValue.value;
//            NSLog(@"%@ %@", phoneNumber.stringValue, labelValue.label);
            NSString * phoneStr = [self pathComponents:phoneNumber.stringValue];
            NSMutableDictionary *phoneDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [phoneDic setValue:phoneStr forKey:labelValue.label];
            [phoneArr addObject:phoneDic];
        }
        //每次点击上次的key没有变，如果有新的只是value变了
        [self.phoneWithNameDic setObject:phoneArr forKey:name];

    }];
}
- (void)loadPerson
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            NSLog(@"没有获取通讯录权限");
        });
    }
}
- (void)copyAddressBook:(ABAddressBookRef)addressBook
{
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for ( int i = 0; i < numberOfPeople; i++){
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFStringRef anFullName = ABRecordCopyCompositeName(person);
        NSString *name = [NSString stringWithFormat:@"%@",anFullName];
        NSMutableArray * phoneArr = [NSMutableArray array];
        for (int k = 0; k<ABMultiValueGetCount(phone); k++){
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            NSString * phoneStr = [self pathComponents:personPhone];
            NSMutableDictionary *phoneDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [phoneDic setValue:phoneStr forKey:personPhoneLabel];
            [phoneArr addObject:phoneDic];
        }
        //每次点击上次的key没有变，如果有新的只是value变了
        [self.phoneWithNameDic setObject:phoneArr forKey:name];
    }
}
#pragma mark -剔除获取的手机号中的@"-"
- (NSString *)pathComponents:(NSString*)pathre{
    NSMutableString *str=[[NSMutableString alloc] initWithString:pathre];
    NSArray *arr2=[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"-"]];
    for(NSString *str in arr2){
        if([str isEqualToString:@""]){
            continue;
        }
    }
    NSMutableArray *newArr=[NSMutableArray arrayWithArray:arr2];
    [newArr removeObject:@""];
    NSString *str1=[newArr componentsJoinedByString:@""];
    // NSLog(@"1111%@",str1);
    
    return str1;
    
}

-(void)performWithRequest:(NSURLRequest *)request values:(NSDictionary *)values completed:(void (^)(NSData *))completed{
    if (IOS9) {
        [self cnLoadPerson];
    }else{
        [self loadPerson];
    }
    completed([super responseDataWithCode:kApiSuccessCode message:@"" data:self.phoneWithNameDic]);
}
@end

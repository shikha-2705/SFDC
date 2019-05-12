@isTest
public class DynamicListControllerTest {
    Public static Final String OBJECT_TYPE_ACCOUNT = 'Account';
    Public static Final String OBJECT_TYPE_CONTACT = 'Contact';
    Public static Final String OBJECT_TYPE_LEAD = 'Lead';
    Public static Final String OBJECT_TYPE_OPPORTUNITY = 'Opportunity';
   @isTest
    public static void createListForUIInputTest(){
     Test.startTest(); 
     DynamicListController.createListForUIInput();  
     Test.stopTest();   
    } 
    
@isTest
    public static void listValuesTest(){
        List<DynamicListController.ListViewWrapper> listWrapper = new List<DynamicListController.ListViewWrapper>();
        Test.startTest();
        listWrapper =  DynamicListController.listValues(OBJECT_TYPE_ACCOUNT);
        Test.stopTest();
    }
    @isTest
    public static void getObjTypeDataTest(){      
        Lead lead = new Lead();
        lead.LastName = 'Test Lead';
        lead.Company = 'Test Company';
        lead.email = 'abc@gmail.com';
        lead.CleanStatus = 'Pending';
        lead.LeadSource = '';
        lead.Phone = '1234';
        insert lead;
    
      List<DynamicListController.ObjectTypeWrapper> objTypeWrapper = new List<DynamicListController.ObjectTypeWrapper>(); 
      Test.startTest();
        objTypeWrapper =  DynamicListController.getObjTypeData(OBJECT_TYPE_ACCOUNT);
        objTypeWrapper =  DynamicListController.getObjTypeData(OBJECT_TYPE_CONTACT);
        objTypeWrapper =  DynamicListController.getObjTypeData('lead');
        objTypeWrapper =  DynamicListController.getObjTypeData(OBJECT_TYPE_OPPORTUNITY);
        Test.stopTest();  
    }
    
}

public class DynamicListController {
    @AuraEnabled
    public static List<String> createListForUIInput(){
        List<String> soList = new List<String>();
        soList = new List<String>();
        soList.add('Account');
        soList.add('Contact');
        soList.add('Lead');
        soList.add('Opportunity');        
        return soList;
    }
    
    @AuraEnabled
    public static List<ListViewWrapper> listValues(string objectInfo){        
        List<ListViewWrapper> oListViewWrapper = new List<ListViewWrapper>();
        List<ListView> listViewRecords = [SELECT id, Name, DeveloperName FROM ListView WHERE sObjectType = : objectInfo ORDER By Name ASC];
        for(ListView lview : listViewRecords)
        {  ListViewWrapper oWrapper = new ListViewWrapper();
         oWrapper.label = lview.Name;
         oWrapper.developerName = lview.DeveloperName;
         oListViewWrapper.add(oWrapper);        
        } 
        return oListViewWrapper; 
    } 
    
    @AuraEnabled
    public static List<ObjectTypeWrapper> getObjTypeData(String objType) {       
        if(objType == null) {
            return null;
        }
        List<ObjectTypeWrapper> objWrapper = new List<ObjectTypeWrapper>();
        if(objType == 'Account'){
         List<Account> accountRecords = [Select Id, Name, Phone, CleanStatus  from Account LIMIT 100];   
         for(Account acc : accountRecords) {
            ObjectTypeWrapper objWrap = new ObjectTypeWrapper(acc.Id, acc.Name,'Account','', acc.Phone, acc.CleanStatus, '', '','');
            objWrapper.add(objWrap);
         }
        }
        else if(objType == 'Contact'){
            List<Contact> contactRecords = [Select Id, Name, Email, Phone, CleanStatus  from Contact LIMIT 100];
            for(Contact c : contactRecords) {
                ObjectTypeWrapper objWrap = new ObjectTypeWrapper(c.Id, c.Name,'Contact', c.Email, c.Phone, c.CleanStatus, '', '','');
                objWrapper.add(objWrap);
            } 
        }
        else if(objType == 'Lead'){
            List<Lead> leadRecords = [Select Id, Name, Email, Phone, CleanStatus  from Lead LIMIT 100]; 
            for(Lead l : leadRecords) {
                ObjectTypeWrapper objWrap = new ObjectTypeWrapper(l.Id, l.Name,'Lead', l.Email, l.Phone, l.CleanStatus, '', '','');
                objWrapper.add(objWrap);
            } 
        }
        else{
            List<Opportunity> opportunityRecords = [Select Id, Name, LeadSource, StageName, Type from Opportunity LIMIT 100];  
            for(Opportunity opp : opportunityRecords) {
                ObjectTypeWrapper objWrap = new ObjectTypeWrapper(opp.Id, opp.Name,'Opportunity','', '', '', opp.LeadSource, opp.StageName, opp.Type);
                objWrapper.add(objWrap);
            } 
        }            
        return objWrapper;
    }
    
    
    public class ListViewWrapper{
        @AuraEnabled public string label{get;set;} 
        @AuraEnabled public string developerName{get;set;} 
    }
    
    
        public class ObjectTypeWrapper {
            @AuraEnabled public String objId;
            @AuraEnabled public String name;
            @AuraEnabled public String objType;
            @AuraEnabled public String email;
            @AuraEnabled public String phone;
            @AuraEnabled public String CleanStatus;
            @AuraEnabled public String LeadSource;
            @AuraEnabled public String Type;
            @AuraEnabled public String StageName;
            
            
            public ObjectTypeWrapper(String objId, String name, String objType, String email, String phone, String CleanStatus, String LeadSource, String StageName, String Type) {
                this.objId = objId;
                this.name = name;                   
                this.objType = objType;
                this.email = email;
                this.phone = phone;
                this.CleanStatus = CleanStatus;
                this.LeadSource = LeadSource;
                this.Type = Type;
                this.StageName =  StageName;
                
            }
            
        }
            
       
}

({
    createListForInput : function (component){
        var action =  component.get('c.createListForUIInput');
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.otList", response.getReturnValue());
            }
        });        
       $A.enqueueAction(action);               
    },
    
    setListView : function(component, event, helper, objectInfo){
     var action = component.get("c.listValues");
        action.setParams({
            "objectInfo" : objectInfo
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var listViewResult = response.getReturnValue();
                if(listViewResult.length > 0){
                    component.set("v.listViewResult",listViewResult);
                    var lvResult = component.get("v.listViewResult");
                    // set first value as default value
                      //component.set("v.currentListViewName", lvResult[0].developerName);
                    // rendere list view on component
                    component.set("v.bShowListView", true);     
                }  
            } 
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);            
    },
           
    onPicklistChange: function(component, event, helper) {
        var lstViewName = event.getSource().get("v.value");
        component.set("v.currentListViewName", lstViewName);
        component.set("v.bShowListView", true); 
    },
 
    //------directly loads the records of selected Sobjecttype----
    setTableColunm:function(component, event, helper){
        var sObjType = component.get('v.sObjType');
        if(sObjType == 'Opportunity'){
            component.set('v.columns', [ 
                { label: 'Name', fieldName: 'linkName', type: 'url', sortable:'true', 
                 typeAttributes: {label: { fieldName: 'name' }, tooltip: {fieldName: 'name'}, target: '_self', sortable: true}},
                {label: 'LeadSource', fieldName: 'LeadSource', type: 'text', sortable:'true'},             
                {label: 'StageName', fieldName: 'StageName', type: 'Text',sortable:'true'},           
                {label: 'Type', fieldName: 'Type', type: 'Text',sortable:'true'}
            ]);           
        }
        else{
           component.set('v.columns', [
               { label: 'Name', fieldName: 'linkName', type: 'url', sortable:'true', 
            	typeAttributes: {label: { fieldName: 'name' }, tooltip: {fieldName: 'name'}, target: '_self', sortable: true}},
               { label: 'Email', fieldName: 'email', type: 'email', sortable: true},
               { label: 'Phone', fieldName: 'phone', type: 'phone', sortable: true},
               {label: 'CleanStatus', fieldName: 'CleanStatus', type: 'text', sortable:'true'}               
               ]);
        }
        helper.getData(component, event, helper);        
    },
    
    getData : function(component, event, helper) {
        var sObjType = component.get('v.sObjType');
        var action = component.get('c.getObjTypeData');
        action.setParams({
            objType : sObjType
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records = response.getReturnValue();
                if(records){
                    records.forEach(function(record){
                        record.linkName = '/'+record.objId;
                    });
                }
                component.set('v.data', records);
            }
            });
        $A.enqueueAction(action);
    }
   
})

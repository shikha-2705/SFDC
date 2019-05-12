({
    init : function(component, event, helper) {
        helper.createListForInput(component);
    },
 
    filterObjectType: function(component, event, helper){
        component.set("v.bShowListView", false);  
        var sObjType = component.get("v.sObjType");
        component.set('v.objectInfo', sObjType);
        var objectInfo = component.get('v.objectInfo');
        helper.setListView(component,event, helper, objectInfo);
        
        //--- This is just to render the records of Sobject directly without the listview.        
        //helper.setTableColunm(component, event, helper);
    }, 
    
    onPicklistChange: function(component, event, helper){
      component.set("v.bShowListView", false);
      helper.onPicklistChange(component,event, helper);  
    }
    
})

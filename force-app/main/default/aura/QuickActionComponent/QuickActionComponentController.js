({
    navigateToLC : function(component, event, helper) {
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__TabComponent'
            },
            state: {
                c__refRecordId: component.get("v.recordId")
            }
        };
        component.set("v.pageReference", pageReference);
        const navService = component.find('navService');
        const pageRef = component.get('v.pageReference');
        const handleUrl = (url) => {
            window.open(url);
        };
        const handleError = (error) => {
            console.log(error);
        };
        navService.generateUrl(pageRef).then(handleUrl, handleError);
        $A.get("e.force:closeQuickAction").fire();
    },

    clouseTab : function(component,event) {

        var workspaceAPI = component.find("workspace");
        window.setTimeout(    
            workspaceAPI.getFocusedTabInfo().then(function(response) {
                var focusedTabId = response.tabId;
                workspaceAPI.closeTab({tabId: focusedTabId});
            })
            .catch(function(error) {
                console.log(error);
            }), 3000);
    }
})
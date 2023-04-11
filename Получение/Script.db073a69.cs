var card = await GetCardAsync();
var EDOID = card.PmDocumentCommonInfo.EDOID;
var depId = card.DocumentCommonInfo.DepartmentID;
var contractID = (Guid)card.PmDocumentCommonInfo.CFOTypeID;
var result =  await GetCFOInMarketingAsync(contractID);

if(depId ==  new Guid("896c753a-73f3-40b8-bd88-c2b54dca5436")) 
{
	//Local Sponsorships
    Process.HelperRole.ID = new Guid("a1dbf495-7d79-4daa-b483-23575ecd3513");
    Process.HelperRole.Name = "Менеджер по сопровождению маркетинговых контрактов";
    
    
 	if(EDOID == 0) 
	{
	    Process.DocRole.ID = new Guid("a1dbf495-7d79-4daa-b483-23575ecd3513");
	    Process.DocRole.Name = "Менеджер по сопровождению маркетинговых контрактов";
	    Process.TextEDO = "Подтвердить получение оригинала в Диадок и прикрепить документ на согласование.";
	}
	
} else 
{
	if(result)
	{
		Process.HelperRole.ID = new Guid("363f12be-9f0d-4a38-bcf6-b9a38f84c36c");
    	Process.HelperRole.Name = "Специалист ДО";
    	
		
	 	if(EDOID == 0) 
		{
			Process.DocRole.ID = new Guid("363f12be-9f0d-4a38-bcf6-b9a38f84c36c");
			Process.DocRole.Name = "Специалист ДО";
	    	Process.TextEDO = "Подтвердить получение оригинала в Диадок и прикрепить документ на согласование.";
		} 
			
	}
}


if(EDOID == 0) 
{
    Process.TextEDO = "Подтвердить получение оригинала в Диадок и прикрепить документ на согласование.";
}

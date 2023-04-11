var card = await GetCardAsync();

if (card.PmDocumentCommonInfo.EDOID == null)
{
    this.ValidationResult.AddError(this, "Пожалуйста, заполните ЭДО!");
}
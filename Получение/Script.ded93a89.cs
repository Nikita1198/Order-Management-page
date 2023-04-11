#using Tessa.Extensions.Default.Shared;
#using Tessa.Cards;

var cardObj = await GetCardObjectAsync();

if (cardObj.Tasks.Count > 0)
{
    foreach(var task in cardObj.Tasks)
	{
		task.State = CardRowState.Deleted;
		await this.TryRemoveTaskHistoryAsync(task);
	}
}


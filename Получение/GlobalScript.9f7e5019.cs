#using System.Threading.Tasks;
#using System;
#using System.Globalization;
#using System.Data;
#using Tessa.Extensions.Default.Shared;
#using Tessa.Extensions.Default.Shared.Workflow.Wf;
#using Tessa.Roles;
#using Tessa.Platform.Data;
#using Unity;
#using LinqToDB.Data

#using Tessa.Cards;
#using Tessa.Extensions.Default.Server.Workflow.KrProcess;
#using Tessa.Extensions.Default.Shared.Workflow.KrProcess;
#using Tessa.Extensions.Default.Shared.Workflow.KrProcess.ClientCommandInterpreter;


CancellationToken cancellationToken = default;

public async Task TryRemoveTaskHistoryAsync(CardTask task)
{
    var executor = Context.DbScope.Executor;

    await executor.ExecuteNonQueryAsync(
        Context.DbScope.BuilderFactory
            .DeleteFrom("TaskHistory")
            .Where().C("TaskHistory", "RowID").Equals().P("RowID")
                .And().NotExists(b => b
                    .Select().V(null)
                    .From("TaskHistory", "pt").NoLock()
                    .Where().C("pt", "ParentRowID").Equals().C("TaskHistory", "RowID"))
            .Build(),
        CancellationToken.None,
        executor.Parameter("RowID", task.RowID));
}

// Проверка галочки "Взодит в Маркетинг" в ЦФО
public async Task<bool> GetCFOInMarketingAsync(Guid cfoID)
{
	var db = DbScope.Db;
	
	bool? result = await db.SetCommand(
			DbScope.BuilderFactory
				.Select()
				 .C("pbc","InMarketing")
                 .From("PbCFO", "pbc").NoLock()
                 .Where()
                 	.C("pbc","ID").Equals().P("CFOID")
                 .Build(),
                    db.Parameter("CFOID", cfoID))
                .LogCommand()
                .ExecuteAsync<bool?>(cancellationToken);
                
	if (result == null || result == false) {
		return false;
	} 
	
	return true;
}
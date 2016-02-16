-- For each database, count rows in tables,
-- ordering by rowcount desc per database

declare @sql nvarchar(1000) = 'use ?; 
	select	db_name() as DatabaseName,
		object_name([ddps].[object_id]) as ObjectName,
		[ddps].[row_count]
	from 
		[sys].[dm_db_partition_stats] as ddps
	join
		[sys].[objects] as o
	on	[ddps].object_id = [o].object_id
	where
		--[ddps].[row_count] > 0 and
		ddps.index_id = 1 and 
		[o].[type] = ''U''
	order by [ddps].[row_count] desc'

exec master.dbo.sp_msforeachdb @command1 = @sql;

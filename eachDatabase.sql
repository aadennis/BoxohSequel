--create database db1
--create database db2
--create database db3

declare
	@databaseSet table (name nvarchar(50), id int);
declare
	@databaseCount int,
	@currentDatabaseId int,
	@currentCount int;
begin
	insert into @databaseSet (name, id)
		select name, database_id 
		from master.sys.databases
		where database_id > 4;

	select @databaseCount = count(1)
	from @databaseSet

	set @currentCount = 0;
	while (@currentCount < @databaseCount)
	begin

		set @currentCount = @currentCount + 1;
	end;

	exec sp_addumpdevice 'disk', 'adsfadf';

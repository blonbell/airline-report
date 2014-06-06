declare @currentDate smalldatetime;
select @currentDate = '4/13/2014';


while @currentDate < '4/27/2014'

begin

-- do whatever is needed

select @currentDate = dateadd(day,1,@currentDate);
print @currentDate;

END
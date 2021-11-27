with test as (SELECT DISTINCT driverRef, count(*) OVER(partition by driverRef) as WINS, nationality
FROM form.results as r
join form.drivers d
ON r.driverId = d.driverId
WHERE position = 1),

cte as(

select *, RANK () OVER(PARTiTION BY nationality ORDER BY WINS DESC) as ranking from test) 

SELECT * FROM cte
WHERE ranking =1
ORDER BY WINS DESC











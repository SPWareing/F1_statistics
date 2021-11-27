with countries as (SELECT DISTINCT nationality, count(*) OVER(partition by nationality) as [Championships by Country]
FROM form.drivers as dr 
JOIN form.driver_standings as st 
ON dr.driverId = st.driverId
JOIN (SELECT max(raceId) as final, [year]
FROM form.races GROUP BY [year]) as ra
ON st.raceId = ra.final
WHERE position = 1),
--ORDER BY [Championships by Country] DESC;

ranked as (SELECT DISTINCT CONCAT(forename,' ',UPPER(surname)) as Driver, 
	count(*) as [Championships], nationality,  
	RANK() OVER(partition by nationality order by COUNT(*) DESC) as [Rank]
FROM form.drivers as dr 
JOIN form.driver_standings as st 
ON dr.driverId = st.driverId
JOIN (SELECT max(raceId) as final, [year]
FROM form.races GROUP BY [year]) as ra
ON st.raceId = ra.final
WHERE position = 1
GROUP BY CONCAT(forename,' ',UPPER(surname)), nationality)

SELECT c.nationality, c.[Championships by Country], Driver, [Championships]
from countries as c
JOIN ranked as r
ON c.nationality = r.nationality
WHERE [Rank] =1
ORDER BY [Championships by Country] DESC;
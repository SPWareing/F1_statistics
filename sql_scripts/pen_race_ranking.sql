SELECT ds.driverId, d.driverRef, year, points, ds.raceId, RANK() OVER(partition by year order by points DESC) AS pen_race_ranking
FROM form.driver_standings as DS
JOIN form.drivers AS d ON ds.driverId = d.driverId 
JOIN form.races AS r on r.raceid = ds.raceId
WHERE ds.raceId IN (SELECT MAX(r1.raceId)-1 FROM form.races as r1 GROUP BY year)
ORDER BY year DESC
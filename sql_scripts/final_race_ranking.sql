SELECT ds.driverId, d.driverRef, year, MAX(points) as final_points,  RANK() OVER(partition by year order by max(points) DESC) as final_standings
FROM form.driver_standings as DS
JOIN form.drivers AS d ON ds.driverId = d.driverId 
JOIN form.races AS r on r.raceid = ds.raceId

GROUP BY ds.driverId, d.driverRef, year
ORDER by year desc
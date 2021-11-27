SELECT dr.forename, dr.driverRef, count(driverRef) as [Races] 
FROM form.drivers as dr
JOIN form.results AS r ON r.driverId = dr.driverId
WHERE  dr.driverRef NOT IN (SELECT dr1.driverRef FROM form.drivers as dr1 JOIN form.results as r1 ON r1.driverId = dr1.driverId
WHERE position IN  (1,2,3))
--JOIN form.driver_standings AS ds ON dr.driverId = ds.driverId
--WHERE position NOT IN (1,2,3)
GROUP BY forename, driverRef
ORDER BY count(*) DESC;
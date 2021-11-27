SELECT driverRef,
	SUM(CASE WHEN position = 1 THEN 1 ELSE 0 END) as [Wins],
	SUM(CASE WHEN position = 2 THEN 1 ELSE 0 END ) as [2nd],
	SUM(CASE WHEN position = 3 THEN 1 ELSE 0 END ) as [3rd],
	SUM(CASE WHEN position IN (1,2,3) THEN 1 ELSE 0 END ) as [Podiums]
FROM form.results AS re
JOIN form.drivers AS dr ON re.driverId = dr.driverId
GROUP BY driverRef
ORDER BY [Podiums] DESC, [Wins] DESC, [2nd]DESC, [3rd] DESC;
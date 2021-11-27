WITH driver as (SELECT re.raceId, grid, driverRef, position, name, [year]
FROM form.results AS re
JOIN form.drivers AS dr ON re.driverId = dr.driverId
JOIN form.races AS ra ON ra.raceId = re.raceId
WHERE position = 1),
grids as (SELECT max(grid) as bkRow, re.raceid, [year]
FROM form.results AS re 
JOIN form.races AS ra ON re.raceid = ra.raceId
GROUP BY re.raceId, [year])

SELECT TOP 10 WITH TIES grid, driverRef, position, g.[year], bkRow, bkRow-1 As bkRow2
FROM driver AS d
JOIN grids AS g on d.raceId = g.raceId and g.year = d.year
ORDER BY grid DESC;
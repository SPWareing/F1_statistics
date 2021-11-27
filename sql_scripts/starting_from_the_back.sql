with grid_pos as (SELECT ra.raceId, ra.name as Track, year, Max(grid)as last, Max(grid) - 1 as back_row
FROM form.results r
JOIN form.races ra ON r.raceId = ra.raceId

GROUP BY ra.raceId,ra.name, year),
pod AS (SELECT ra.raceid, r.driverId, driverRef, grid, position, year
FROM form.results AS r
JOIN form.races AS ra ON r.raceId = ra.raceId
JOIN form.drivers AS dr ON dr.driverId = r.driverId
WHERE position IN (1,2,3))

SELECT g.Track, g.year, p.grid, p.driverRef, position, count(*) over(partition by g.Track) as Times, count(*) over(partition by p.driverRef)
FROM grid_pos AS g
JOIN pod AS p ON p.grid = g.last OR p.grid = g.back_row 
WHERE g.raceId = p.raceId
ORDER BY Times DESC;
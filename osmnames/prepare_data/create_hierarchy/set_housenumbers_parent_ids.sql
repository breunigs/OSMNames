UPDATE osm_housenumber AS hn
  SET parent_id = pp.id
  FROM (
    SELECT id, geometry
      FROM parent_polygons
      ORDER BY place_rank DESC, admin_level DESC
  ) AS pp
  WHERE hn.parent_id IS NULL
  AND pp.geometry && hn.geometry_center
  AND st_contains(pp.geometry, hn.geometry_center)
  AND auto_modulo(hn.id); --&

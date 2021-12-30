-- 1, Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT dp.nombre as departament, ps.apellido1, ps.apellido2, ps.nombre  FROM universidad.profesor as pf LEFT JOIN universidad.persona as ps ON pf.`id_profesor`=ps.id LEFT JOIN universidad.departamento as dp ON pf.id_departamento = dp.id;

-- 2.  Retorna un llistat amb els professors que no estan associats a un departament
SELECT * FROM universidad.persona as p LEFT JOIN universidad.profesor as pf ON p.id = pf.id_profesor where tipo = "profesor" and id_departamento IS NULL;
-- no n'hi ha

-- 3, Retorna un llistat amb els departaments que no tenen professors associats
SELECT * FROM universidad.departamento as d LEFT JOIN universidad.profesor as p ON d.id = p.id_departamento WHERE id_profesor IS NULL;

-- 4. Retorna un llistat amb els professors que no imparteixen cap assignatura
SELECT p.*, ps.apellido1, ps.apellido2, ps.nombre FROM universidad.profesor as p LEFT JOIN universidad.asignatura as a ON p.id_profesor = a.id_profesor LEFT JOIN universidad.persona as ps ON p.id_profesor = ps.id WHERE a.id IS NULL;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT * FROM universidad.asignatura as a LEFT JOIN universidad.profesor as p on a.id_profesor = p.id_profesor WHERE p.id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar
SELECT a.nombre as nombre_asignatura, p.*, d.nombre as departamento FROM universidad.asignatura as a RIGHT JOIN universidad.profesor as p on a.id_profesor = p.id_profesor LEFT JOIN universidad.departamento as d ON p.id_departamento = d.id WHERE a.nombre IS NULL;

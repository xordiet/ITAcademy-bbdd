-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom
SELECT apellido1, apellido2, nombre FROM universidad.persona WHERE tipo = "alumno" ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades
SELECT nombre, apellido1, apellido2 FROM universidad.persona WHERE tipo = "alumno" and telefono IS NULL;

-- 3- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM universidad.persona WHERE fecha_nacimiento BETWEEN '1999-01-01' and '1999-12-31';

-- 4. Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT * FROM universidad.persona WHERE tipo ="profesor" and telefono IS NULL and nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM universidad.asignatura WHERE cuatrimestre = 1 AND curso = 3 and id_grado=7;

-- 6. Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT ps.nombre, ps.apellido1, ps.apellido2, dp.nombre as departamento FROM universidad.profesor as pf LEFT JOIN universidad.persona as ps ON pf.id_profesor = ps.id LEFT JOIN universidad.departamento as dp ON pf.id_departamento = dp.id;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
SELECT asg.nombre, c.anyo_inicio, c.anyo_fin FROM universidad.alumno_se_matricula_asignatura as a LEFT JOIN universidad.persona as p ON a.id_alumno = p.id LEFT JOIN universidad.asignatura as asg ON a.id_asignatura = asg.id LEFT JOIN universidad.curso_escolar as c ON a.id_curso_escolar = c.id where p.nif="26902806M";

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT(d.nombre) FROM universidad.departamento as d LEFT JOIN universidad.profesor as p ON d.id = p.id_departamento LEFT JOIN universidad.asignatura as a on p.id_profesor = a.id_profesor LEFT JOIN universidad.grado as g ON a.id_grado = g.id WHERE g.nombre="Grado en Ingeniería Informática (Plan 2015)";

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT(a.id_alumno) as alumne, p.nombre, p.apellido1, p.apellido2 FROM universidad.alumno_se_matricula_asignatura as a LEFT JOIN universidad.persona as p ON a.id_alumno = p.id LEFT JOIN universidad.curso_escolar as c ON a.id_curso_escolar = c.id WHERE anyo_inicio = '2018';

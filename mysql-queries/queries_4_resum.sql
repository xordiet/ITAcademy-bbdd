-- 1. Retorna el nombre total d'alumnes que hi ha
SELECT COUNT(*) as nombre_alumnes FROM universidad.persona WHERE tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999
SELECT COUNT(*) as compta FROM universidad.persona WHERE tipo = 'alumno' and fecha_nacimiento BETWEEN '1999-01-01' and '1999-12-31';

-- 3. Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
SELECT nombre, COUNT(*) as nombre_professors FROM universidad.profesor as p LEFT JOIN universidad.departamento as d ON p.id_departamento = d.id GROUP BY id_departamento ORDER BY COUNT(*) DESC, nombre ASC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre, COUNT(id_profesor) as nombre_professors FROM universidad.departamento as d LEFT JOIN universidad.profesor as p ON d.id = p.id_departamento GROUP BY id ORDER BY COUNT(id_profesor) DESC, nombre ASC;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre, count(a.id) as nombre FROM universidad.grado as g LEFT JOIN universidad.asignatura as a ON g.id = a.id_grado GROUP BY g.id;

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre as nom, count(a.id) as numero FROM universidad.grado as g LEFT JOIN universidad.asignatura as a ON g.id = a.id_grado GROUP BY g.id HAVING COUNT(a.id)>40;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre, a.tipo, SUM(creditos) FROM universidad.grado as g LEFT JOIN universidad.asignatura as a ON g.id = a.id_grado GROUP BY g.id, a.tipo;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT c.anyo_inicio, COUNT(al.id_alumno) FROM universidad.alumno_se_matricula_asignatura as al LEFT JOIN universidad.asignatura as a on al.id_asignatura = a.id LEFT JOIN universidad.curso_escolar as c on al.id_curso_escolar = c.id GROUP BY c.anyo_inicio;

-- 9- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT p.id_profesor as id, ps.nombre, ps.apellido1, ps.apellido2, COUNT(a.id) as nombre_asignatures FROM universidad.profesor as p LEFT JOIN universidad.asignatura as a on p.id_profesor = a.id_profesor LEFT JOIN universidad.persona as ps on p.id_profesor = ps.id GROUP BY p.id_profesor order by nombre_asignatures DESC;

-- 10. Retorna totes les dades de l'alumne més jove
SELECT * FROM universidad.persona WHERE tipo="alumno" ORDER BY fecha_nacimiento DESC LIMIT 1;

-- 11. Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.
SELECT * FROM universidad.persona as ps LEFT JOIN universidad.profesor as pf on ps.id = pf.id_profesor LEFT JOIN universidad.asignatura as a on pf.id_profesor = a.id_profesor WHERE ps.tipo="profesor" and a.id IS NULL;

-- 1. Llista el nom de tots els productos que hi ha en la taula producto.
SELECT nombre FROM tienda.producto;

-- 2. Llista els noms i els preus de tots els productos de la taula producto.
SELECT nombre, precio FROM tienda.producto;

-- 3. Llista totes les columnes de la taula producto.
SHOW COLUMNS FROM tienda.producto;
DESCRIBE tienda.producto;

-- 4. Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). 1€ = 1,1342676$
SELECT nombre, precio, (precio*1.13) FROM tienda.producto;

-- 5. Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dolars.
SELECT nombre as 'nom de producte', precio as euros, (precio*1.13) as dolars FROM tienda.producto;

-- 6. Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre), precio FROM tienda.producto;

-- 7. Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre), precio FROM tienda.producto;

-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(substring(nombre,1,2)) FROM tienda.fabricante;

-- 9. Llista els noms i els preus de tots els productos de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio, 0) FROM tienda.producto;

-- 10. Llista els noms i els preus de tots els productos de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal
SELECT nombre, TRUNCATE(precio, 0) FROM tienda.producto;

-- 11. Llista el codi dels fabricants que tenen productos en la taula producto
SELECT codigo_fabricante FROM tienda.producto;

-- 12. Llista el codi dels fabricants que tenen productos en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT(codigo_fabricante) FROM tienda.producto;

-- 13. Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM tienda.fabricante ORDER by nombre ASC;

-- 14. Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM tienda.fabricante ORDER by nombre DESC;

-- 15. Llista els noms dels productos ordenats en primer lloc pel nom de manera ascendent i en segon lloc pel preu de manera descendent.
SELECT nombre, precio FROM tienda.producto ORDER BY nombre ASC, precio DESC;

-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM tienda.fabricante LIMIT 5;

-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM tienda.fabricante LIMIT 3,2;

-- 18. Llista el nom i el preu del producto més barat. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM tienda.producto ORDER BY precio ASC LIMIT 1;

-- 19. Llista el nom i el preu del producto més car. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM tienda.producto ORDER BY precio DESC LIMIT 1;

-- 20. Llista el nom de tots els productos del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM tienda.producto WHERE codigo_fabricante = 2;

-- 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo;

-- 22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordeni el resultat pel nom del fabricador, per ordre alfabètic.
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo, p.nombre, p.codigo_fabricante, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo;

-- 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY precio ASC LIMIT 1;

-- 25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo ORDER BY precio DESC LIMIT 1;

-- 26. Retorna una llista de tots els productes del fabricador Lenovo
SELECT p.* FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre="Lenovo";

-- 27. Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200€.
SELECT p.* FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre="Crucial" and precio>200;

-- 28. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN.
SELECT * FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre="Asus" OR f.nombre="Hewlett-Packard" or f.nombre="Seagate";

-- 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Utilitzant l'operador IN.
SELECT * FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");

-- 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';

-- 31. Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%w%';

-- 32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180€. Ordeni el resultat en primer lloc pel preu (en ordre descendent) i en segon lloc pel nom (en ordre ascendent)
SELECT p.nombre, p.precio, f.nombre as fabricante FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE p.precio>=180 ORDER BY precio DESC, nombre ASC;

-- 33. Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT f.* FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo GROUP BY f.codigo;

-- 34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT * FROM tienda.fabricante as f LEFT JOIN tienda.producto as p ON f.codigo = p.codigo_fabricante;

-- 35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT f.* FROM tienda.producto as p RIGHT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE p.codigo IS NULL;

-- 36. Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT * FROM tienda.producto as p RIGHT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo";

-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT * FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE p.precio = (SELECT max(precio) FROM tienda.producto where codigo_fabricante = 2);

-- 38. Llista el nom del producte més car del fabricador Lenovo.
SELECT p.nombre FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo" ORDER BY precio DESC LIMIT 1;

-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT p.nombre FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Hewlett-Packard" ORDER BY precio ASC LIMIT 1;

-- 40. Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricador Lenovo.
SELECT p.* FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE p.precio >= (SELECT max(precio) FROM tienda.producto where codigo_fabricante = 2);

-- 41. Llesta tots els productes del fabricador Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT p.* FROM tienda.producto as p LEFT JOIN tienda.fabricante as f ON p.codigo_fabricante = f.codigo WHERE f.nombre="Asus" AND p.precio > (SELECT AVG(precio) FROM tienda.producto where codigo_fabricante = 1);

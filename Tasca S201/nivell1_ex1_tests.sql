-- Llista el total de factures d'un client en un període determinat
-- Primer miro quins clients tenen més transaccions perquè la consulta prengui sentit
SELECT COUNT(*) as compta, client_id FROM S201_n1_ex1.vendes GROUP BY client_id ORDER BY compta DESC;
-- LListo totes les compres d'aquest client
SELECT * FROM S201_n1_ex1.vendes WHERE client_id = 10;
-- Filtro les compres d'unes dates determinades
SELECT * FROM S201_n1_ex1.vendes WHERE client_id = 10 and (data_venda BETWEEN '1982-01-01' AND '1999-12-31');
-- Faig un Join per substituir els id client/venedor pel nom corresponent
SELECT vendes.`vendes_id` as 'id_venda', vendes.data_venda as data_operacio, clients.nom as 'nom_client', treballadors.`nom` as 'nom_venedor', ulleres.preu as 'preu_venda' FROM S201_n1_ex1.vendes as vendes LEFT JOIN S201_n1_ex1.`clients` as clients ON vendes.`client_id` = clients.`id` LEFT JOIN `S201_n1_ex1`.`treballadors` as treballadors ON vendes.`venedor_id` = treballadors.`id` LEFT JOIN `S201_n1_ex1`.`ulleres` as ulleres ON vendes.ullera_id = ulleres.`id` WHERE client_id = 10 and (data_venda BETWEEN '1982-01-01' AND '1999-12-31') ;

-- Llista els diferents models d'ulleres que ha venut un empleat durant un any
-- Primer miro quin venedor ha venut més ulleres
SELECT COUNT(*) as compta, venedor_id FROM `S201_n1_ex1`.vendes GROUP BY venedor_id ORDER BY compta DESC;
-- Faig la consulta amb Joins
SELECT * FROM `S201_n1_ex1`.vendes as v LEFT JOIN `S201_n1_ex1`.`treballadors` as t ON v.`venedor_id` = t.`id` LEFT JOIN `S201_n1_ex1`.`ulleres` as u ON v.`ullera_id` = u.`id` LEFT JOIN `S201_n1_ex1`.`marques` as m on u.marca_id = m.id WHERE v.venedor_id=9 and (v.data_venda BETWEEN '2010-01-01' AND '2010-12-31');
-- Redueixo el nombre de camps a mostrar per que quedi més clar
SELECT m.marca, t.nom, v.data_venda FROM `S201_n1_ex1`.vendes as v LEFT JOIN `S201_n1_ex1`.`treballadors` as t ON v.`venedor_id` = t.`id` LEFT JOIN `S201_n1_ex1`.`ulleres` as u ON v.`ullera_id` = u.`id` LEFT JOIN `S201_n1_ex1`.`marques` as m on u.marca_id = m.id WHERE v.venedor_id=9 and (v.data_venda BETWEEN '2010-01-01' AND '2010-12-31');

-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica
-- Faig la consulta i els joins necessaris mostrant els camps que m'interessa
SELECT count(marca) as compta, marca_id, marca, proveidor_id, p.nom FROM S201_n1_ex1.vendes as v LEFT JOIN S201_n1_ex1.ulleres as u on v.ullera_id = u.id LEFT JOIN S201_n1_ex1.marques as m ON u.marca_id = m.id LEFT JOIN S201_n1_ex1.proveidors as p ON m.proveidor_id = p.id GROUP BY m.marca ORDER BY compta DESC; 
-- només mostro les marques que han venut més de 40 unittats (les d'èxit)
SELECT * FROM (SELECT count(marca) as compta, marca_id, marca, proveidor_id, p.nom FROM S201_n1_ex1.vendes as v LEFT JOIN S201_n1_ex1.ulleres as u on v.ullera_id = u.id LEFT JOIN S201_n1_ex1.marques as m ON u.marca_id = m.id LEFT JOIN S201_n1_ex1.proveidors as p ON m.proveidor_id = p.id GROUP BY m.marca ORDER BY compta DESC) as c WHERE c.compta > 40;
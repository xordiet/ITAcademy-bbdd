-- Llista quants productes de categoria 'Begudas' s'han venut en una determinada localitat
SELECT * FROM `S201_n1_ex2`.comandes_detall as d LEFT JOIN `S201_n1_ex2`.comandes as c ON c.id = d.comanda_id LEFT JOIN `S201_n1_ex2`.productes as p on p.id = d.producte_id WHERE botiga_id = 34 and p.tipus="beguda" ORDER BY d.id;

-- Llista quantes comandes ha efectuat un determinat empleat
SELECT * FROM `S201_n1_ex2`.comandes as c LEFT JOIN `S201_n1_ex2`.treballadors as t ON t.id = c. repartidor_id WHERE c.repartidor_id = 73;

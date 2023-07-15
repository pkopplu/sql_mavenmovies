/*
“Can you pull for me a list of each film we have in inventory? 
 | would like to see the film’s title, description, and the store_id value 
 associated with each item, and its inventory_id. Thanks!” 
 */
 SELECT 
    f.title, f.description, i.store_id, i.inventory_id
FROM
    film f
        INNER JOIN
    inventory i ON f.film_id = i.film_id;
/*
“One of our investors is interested in the films we carry and how many actors are listed for each film title.
  Can you pull a list of all titles, and figure out how many actors are associated with each title?” 
*/    
select count(distinct film_id) from film_actor; -- 997
select count( film_id) from film; -- 1000 3 films with no actors in film_actor table;
SELECT 
    f.title, COUNT(a.actor_id) AS number_actors
FROM
    film f
        LEFT JOIN
    film_actor a ON f.film_id = a.film_id
GROUP BY f.title
ORDER BY number_actors;
/*
“Customers often ask which films their favorite actors appear in.
  It would be great to have a list of all actors, with each title that they appear in.
  Could you please pull that for me?” 
*/
-- film_actor is the bridging table for film and actor tables
SELECT 
    a.first_name, a.last_name, f.title
FROM
    actor a
        INNER JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        INNER JOIN
    film f ON fa.film_id = f.film_id;
/*
“The Manager from Store 2 is working on expanding our film collection there.
  Could you pull a list of distinct titles  and their descriptions,
  currently available in inventory at store 2?” 
*/
SELECT DISTINCT
    f.title, f.description
FROM
    film f
        INNER JOIN
    inventory i ON f.film_id = i.film_id AND i.store_id = 2;
/*
“We will be hosting a meeting with all of our staff and advisors soon. 
 Could you pull one list of all staff and advisor names, and include a column
 noting whether they are a staff member or advisor? Thanks!” 
*/
select 'advisor' as type,first_name, last_name from advisor
union
select 'staff' as type,first_name, last_name from staff;
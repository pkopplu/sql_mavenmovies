/*
We want to make sure you folks have a good handle on who your customers are. Please provide a list of all customer names,
 which store they go to, whether or not they are currently active, and their full addresses( street address, city, and country)
*/
SELECT 
    c.first_name,
    c.last_name,
    c.store_id AS store,
    CASE
        WHEN c.active = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS status,
    a.address,
    c1.city,
    c2.country
FROM
    customer c
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city c1 ON c1.city_id = a.city_id
        INNER JOIN
    country c2 ON c1.country_id = c2.country_id;
    /*
    We would like to understand how much your customers are spending with you, and also to know who
    your most valuable customers are. Please pull together a list of customer names, their total lifetime
    rentals, and the sum of all payments you have collected from them. It would be great to see this 
    ordered on total lifetime value, with the most valuable customers at the top of the list
    */
    SELECT 
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS lifetime_rentals,
    SUM(p.amount) AS sum_payments
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
        INNER JOIN
    payment p ON p.rental_id = r.rental_id
GROUP BY c.first_name , c.last_name
ORDER BY sum_payments desc;
-- select * from customer;
-- select * from rental;
/*
My partner and I would like to get to know your board of advisors and any current investors.
 Could you please provide a list of advisor and investor names in one table? Could you please note whether 
 they are an investor or an advisor, and for the investors, it would be good to include which company they work with
 */
 select * from advisor;
 SELECT 
    first_name, last_name, 'investor' AS type, company_name
FROM
    investor 
UNION SELECT 
    first_name, last_name, 'advisor' AS type, NULL
FROM
    advisor;
/*
We re interested in how well you have covered the most awarded actors. Of all the actors with 
three types of awards, for what % of them do we carry a film? And how about for actors with two 
types of awards? Same questions. Finally, how about actors with just one award?
*/
with cte as(
SELECT 
    *,
    CASE
        WHEN awards like '%Emmy, Oscar, Tony%' THEN 'Three awards'
        WHEN awards IN ('Emmy' , 'Oscar', 'Tony') THEN 'One award'
        ELSE 'Two awards'
    END AS num_awards
FROM
    actor_award)
    Select num_awards, count(actor_id)*100.0/count(*) from cte group by num_awards;
/*
My partner and I want to come by each of the stores in person and meet the managers. Please
 send over the managers  names at each store, with the full address of each property 
 (street address, district, city, and ,country please)
 */
 select * from address;
 SELECT 
    s1.first_name,
    s1.last_name,
    a.address,
    a.district,
    c1.city,
    c2.country
FROM
    staff s1
        INNER JOIN
    store s2 ON s1.staff_id = s2.manager_staff_id
        INNER JOIN
    address a ON s2.address_id = a.address_id
        INNER JOIN
    city c1 ON c1.city_id = a.city_id
        INNER JOIN
    country c2 ON c1.country_id = c2.country_id;
/*
I would like to get a better understanding of all of the inventory that would come along with the business.
Please pull together a list of each inventory item you have stocked, including the store id number,
 the inventory id, the name of the film, the film s rating, its rental rate and replacement cost
*/
SELECT 
    i.store_id,
    i.inventory_id,
    f.title,
    f.rating,
    f.rental_rate,
    f.replacement_cost
FROM
    inventory i
        INNER JOIN
    film f ON i.film_id = f.film_id;
/*
From the same list of films you just pulled, please roll that data up and
 provide a summary level overview of your inventory. We would like to know how
 many inventory items you have with each rating at each store
*/
SELECT 
    i.store_id,
    f.rating,
    count(*) as number_items
FROM
    inventory i
        INNER JOIN
    film f ON i.film_id = f.film_id
    group by i.store_id, f.rating
    order by rating,store_id;
/*
Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to see
 how big of a hit it would be if a certain category of film became unpopular at a certain store.We would like to 
 see the number of films, as well as the average replacement cost, and total replacement cost, sliced by store and film category
*/
select * from category;
SELECT 
    i.store_id, c.name, avg(f.replacement_cost) as average_replacement_cost,
    sum(f.replacement_cost) as total_replacement_cost
FROM
    inventory i
        INNER JOIN
    film_category fc ON i.film_id = fc.film_id
        INNER JOIN
    category c ON fc.category_id = c.category_id
        INNER JOIN
    film f ON f.film_id = i.film_id
GROUP BY i.store_id , c.name
order by total_replacement_cost desc;
select * from film_category
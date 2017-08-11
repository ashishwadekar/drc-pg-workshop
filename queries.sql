--- get all menu items of a branch exclusive to the branch
-- query 1

SELECT menu_items.*
FROM restaurant_branch_menu_items AS r_b_m_i INNER JOIN menu_items ON r_b_m_i.menu_item_id = menu_items.id
WHERE r_b_m_i.restaurant_branch_id = 1
ORDER BY id ASC;

--- get all menu items of all branches of a restaurants
-- query 2

SELECT DISTINCT menu_items.*
FROM restaurants
  INNER JOIN restaurant_branches ON restaurant_branches.restaurant_id = restaurants.id
  INNER JOIN restaurant_branch_menu_items AS r_b_m_i ON restaurant_branches.id = r_b_m_i.restaurant_branch_id
  INNER JOIN menu_items ON r_b_m_i.menu_item_id = menu_items.id
WHERE restaurants.id = 1
ORDER BY id ASC;

--- given a branch, return menu items of the parent restaurant

SELECT menu_items.*
FROM restaurant_branches
  INNER JOIN restaurants ON restaurant_branches.id = 1 AND restaurant_branches.restaurant_id = restaurants.id
  INNER JOIN restaurant_menu_items AS r_m_i ON restaurants.id = r_m_i.restaurant_id
  INNER JOIN menu_items ON r_m_i.menu_item_id = menu_items.id;

--- or

SELECT menu_items.*
FROM restaurants
  INNER JOIN restaurant_menu_items AS r_m_i ON restaurants.id = r_m_i.restaurant_id
  INNER JOIN menu_items ON r_m_i.menu_item_id = menu_items.id
WHERE r_m_i.restaurant_id IN (SELECT restaurant_id
                              FROM restaurant_branches
                              WHERE restaurant_branches.id = 1);

--- menu of a branch
SELECT menu_items.*
FROM restaurant_branches
  INNER JOIN restaurants ON restaurant_branches.id = 1 AND restaurant_branches.restaurant_id = restaurants.id
  INNER JOIN restaurant_menu_items AS r_m_i ON restaurants.id = r_m_i.restaurant_id
  INNER JOIN menu_items ON r_m_i.menu_item_id = menu_items.id
UNION
SELECT menu_items.*
FROM restaurant_branch_menu_items AS r_b_m_i
  INNER JOIN menu_items ON r_b_m_i.menu_item_id = menu_items.id
WHERE r_b_m_i.restaurant_branch_id = 1;


--- get restaurants menu items of a branch
--- as a function
CREATE OR REPLACE FUNCTION restaurant_menu_items_for_branch(br_id BIGINT)
  RETURNS TABLE(id BIGINT, name CHARACTER VARYING, description CHARACTER VARYING, price DECIMAL(10, 2))
AS $function$
SELECT menu_items.*
FROM restaurant_branches
  INNER JOIN restaurants ON restaurant_branches.id = br_id AND restaurant_branches.restaurant_id = restaurants.id
  INNER JOIN restaurant_menu_items AS r_m_i ON restaurants.id = r_m_i.restaurant_id
  INNER JOIN menu_items ON r_m_i.menu_item_id = menu_items.id
$function$
LANGUAGE SQL;

SELECT *
FROM restaurant_menu_items_for_branch(1);

--- using the function instead
--- menu of a branch
SELECT *
FROM restaurant_menu_items_for_branch(1)
UNION
SELECT menu_items.*
FROM restaurant_branch_menu_items AS r_b_m_i
  INNER JOIN menu_items ON r_b_m_i.menu_item_id = menu_items.id
WHERE r_b_m_i.restaurant_branch_id = 1;

--- constraint that name should be unique in the restaurants

--- find all co-branches
CREATE OR REPLACE FUNCTION cobranches(br_id BIGINT)
  RETURNS TABLE(id BIGINT)
AS $function$
SELECT b2.id
FROM
  restaurant_branches b1
  JOIN restaurant_branches b2 ON b1.restaurant_id = b2.restaurant_id
WHERE b1.id = br_id;
$function$
LANGUAGE SQL;

SELECT *
FROM COBRANCHES(1);

-- TODO Make a ARel scope out it
--- check duplicate in all menus in cobranches
CREATE OR REPLACE FUNCTION dup_menu_item_in_restaurant(item_id BIGINT, br_id BIGINT)
  RETURNS BOOLEAN LANGUAGE SQL
AS $function$
SELECT exists(
    WITH item AS (SELECT name
                  FROM menu_items
                  WHERE id = item_id)
    SELECT menu_items.name
    FROM
          cobranches(br_id) AS branches
      INNER JOIN restaurant_branch_menu_items AS r_b_m_i ON r_b_m_i.restaurant_branch_id = branches.id
      INNER JOIN menu_items ON r_b_m_i.menu_item_id = menu_items.id
      LEFT JOIN item ON 1 = 1
    WHERE lower(menu_items.name) = lower(item.name)
    UNION
    SELECT menu_items.name
    FROM restaurant_menu_items_for_branch(br_id) AS menu_items LEFT JOIN item ON 1 = 1
    WHERE lower(menu_items.name) = lower(item.name)
);
$function$;

SELECT *
FROM dup_menu_item_in_restaurant(3, 6);

SELECT id
FROM menu_items
WHERE name = 'French fries with sausages  and vegetables';

--- the constraint
ALTER TABLE restaurant_branch_menu_items
  ADD CONSTRAINT unique_item_in_restaurant CHECK (NOT dup_menu_item_in_restaurant(menu_item_id, restaurant_branch_id));

--- a view for frequent lookups - all items
DROP VIEW IF EXISTS branch_menus;

CREATE VIEW branch_menus AS
  SELECT
    menu_items.*,
    restaurant_branches.id AS branch_id
  FROM restaurant_branches
    INNER JOIN restaurants ON restaurant_branches.restaurant_id = restaurants.id
    INNER JOIN restaurant_menu_items AS r_m_i ON restaurants.id = r_m_i.restaurant_id
    INNER JOIN menu_items ON r_m_i.menu_item_id = menu_items.id
  UNION
  SELECT
    menu_items.*,
    r_b_m_i.restaurant_branch_id AS branch_id
  FROM restaurant_branch_menu_items AS r_b_m_i
    INNER JOIN menu_items ON r_b_m_i.menu_item_id = menu_items.id;

SELECT *
FROM branch_menus
WHERE branch_id = 1
ORDER BY id ASC;



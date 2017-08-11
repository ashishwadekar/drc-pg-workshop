class AddFunctions < ActiveRecord::Migration[5.1]
  def up
    execute <<~SQL
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
    SQL

    execute <<~SQL
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
    SQL

    execute <<~SQL
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
    SQL
  end

  def down
    execute "DROP FUNCTION restaurant_menu_items_for_branch(br_id BIGINT) CASCADE"
    execute "DROP FUNCTION cobranches(br_id BIGINT) CASCADE"
    execute "DROP FUNCTION dup_menu_item_in_restaurant(item_id BIGINT, br_id BIGINT) CASCADE"
  end
end

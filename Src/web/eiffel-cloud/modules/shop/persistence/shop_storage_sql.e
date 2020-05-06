note
	description: "Interface for accessing shop data from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_STORAGE_SQL

inherit
	SHOP_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

create
	make

feature -- Store

	user_shopping_cart (a_user: CMS_USER): detachable SHOPPING_CART
		do
			reset_error
			sql_query (sql_select_user_shopping_cart, sql_parameters (1, <<["uid", a_user.id]>>))
			sql_start
			if not has_error and not sql_after then
				Result := fetch_shopping_cart
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_user_shopping_cart)
			if not has_error and Result /= Void then
				check same_user: a_user.same_as (Result.owner) end
				Result.owner := a_user
			end
		end

	shopping_cart_by_id (a_cart_id: like {SHOPPING_CART}.id): detachable SHOPPING_CART
		do
			reset_error
			sql_query (sql_select_shopping_cart_by_id, sql_parameters (1, <<["cid", a_cart_id]>>))
			sql_start
			if not has_error and not sql_after then
				Result := fetch_shopping_cart
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_shopping_cart_by_id)
		end

	shopping_cart_by_email (a_email: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		do
			reset_error
			sql_query (sql_select_shopping_cart_by_email, sql_parameters (1, <<["email", a_email]>>))
			sql_start
			if not has_error and not sql_after then
				Result := fetch_shopping_cart
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_shopping_cart_by_email)
		end

	save_shopping_cart (a_cart: SHOPPING_CART)
		local
			l_params: like sql_parameters
			l_uid: like {CMS_USER}.id
			l_security: READABLE_STRING_GENERAL
		do
			reset_error
			if a_cart.has_id then
				l_params := sql_parameters (5, <<["cid", a_cart.id]>>)
			else
				l_params := sql_parameters (5, Void)
			end
			l_security := a_cart.security
			if a_cart.is_guest then
				l_uid := 0
--				if l_security = Void then
					if attached api as l_api then
						l_security := l_api.new_random_identifier (16, Void)
					else
						l_security := {UUID_GENERATOR}.generate_uuid.out
					end
					a_cart.set_security (l_security)
--				end
			else
				l_uid := a_cart.owner.id
			end
			a_cart.set_modification_date (create {DATE_TIME}.make_now_utc)
			sql_append_parameters ({ARRAY [TUPLE [READABLE_STRING_GENERAL, detachable ANY]]} <<
								["uid", l_uid],
								["email", a_cart.email],
								["security", l_security],
								["changed", a_cart.modification_date],
								["items", a_cart.items_to_json_string],
								["data", a_cart.data]
							>>,
							l_params
						)
			if a_cart.has_id then
				sql_modify (sql_modify_user_shopping_cart, l_params)
				sql_finalize_modify (sql_modify_user_shopping_cart)
			else
				sql_insert (sql_insert_user_shopping_cart, l_params)
				sql_finalize_insert (sql_insert_user_shopping_cart)

				a_cart.update_id (last_inserted_shopping_cart_id)
			end
		end

	delete_shopping_cart (a_cart: SHOPPING_CART)
		do
			reset_error
			sql_delete (sql_delete_shopping_cart, sql_parameters (1, <<["cid", a_cart.id]>>))
			sql_finalize_delete (sql_delete_shopping_cart)
		end

	fetch_shopping_cart: detachable SHOPPING_CART
		local
			cid, uid: INTEGER_64
			l_email: READABLE_STRING_8
			u: CMS_PARTIAL_USER
		do
			cid := sql_read_integer_64 (1)
			uid := sql_read_integer_64 (2)
			l_email := sql_read_string (3)
			create u.make_with_id (uid)
			if uid = 0 then
				create Result.make_guest
				Result.update_id (cid)
			else
				create Result.make_with_id (cid, u)
			end
			if attached sql_read_string_32 (4) as l_sec then
				Result.set_security (l_sec)
			end
			if attached sql_read_date_time (5) as dt then
				Result.set_modification_date (dt)
			end
			if attached sql_read_string (6) as s and then not s.is_whitespace then
				Result.set_items_from_json_string (s)
			end
			Result.data := sql_read_string (7)
		end

	last_inserted_shopping_cart_id: INTEGER_64
			-- Last insert cart id.
		do
			error_handler.reset
			sql_query (sql_last_inserted_shopping_cart_id, Void)
			if not has_error and not sql_after then
				Result := sql_read_integer_64 (1)
			end
			sql_finalize_statement (sql_last_inserted_shopping_cart_id)
		end

feature -- Order		

	cart_to_order (a_cart: SHOPPING_CART; a_order_id: READABLE_STRING_GENERAL)
		local
			l_params: like sql_parameters
			j: READABLE_STRING_8
		do
			j := a_cart.to_json_string
			reset_error
			l_params := sql_parameters (5, {ARRAY [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]]} <<
					["name", a_order_id],
					["uid", a_cart.owner.id],
					["email", a_cart.email],
					["created", create {DATE_TIME}.make_now_utc],
					["data", j]
				>>)
			sql_insert (sql_insert_order, l_params)
			sql_finalize_insert (sql_insert_order)
			if not has_error then
				delete_shopping_cart (a_cart)
			end
		end

	cart_from_order (a_order_name: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		local
			uid: INTEGER_64
			l_email: READABLE_STRING_8
			j_data: READABLE_STRING_8
		do
			reset_error
			sql_query (sql_select_order_by_name, sql_parameters (1, <<["name", a_order_name]>>))
			sql_start
			if not has_error and not sql_after then
				uid := sql_read_integer_64 (3)
				l_email := sql_read_string (4)
				j_data := sql_read_string (6)
			end
			sql_finalize_query (sql_select_order_by_name)
			if j_data /= Void then
				create Result.make_from_json (j_data)
				if l_email /= Void then
					Result.set_email (l_email)
				end
			end
			check Result /= Void and then Result.owner.id = uid end
		end

feature {NONE} -- Queries

	sql_select_user_shopping_cart: STRING = "SELECT cid, uid, email, security, changed, items, data FROM shop_carts WHERE uid=:uid ORDER by cid LIMIT 1;"

	sql_select_shopping_cart_by_email: STRING = "SELECT cid, uid, email, security, changed, items, data FROM shop_carts WHERE email=:email ;"

	sql_select_shopping_cart_by_id: STRING = "SELECT cid, uid, email, security, changed, items, data FROM shop_carts WHERE cid=:cid ;"

	sql_insert_user_shopping_cart: STRING = "INSERT INTO shop_carts (uid, email, changed, security, items, data) VALUES (:uid, :email, :changed, :security, :items, :data);"

	sql_last_inserted_shopping_cart_id: STRING = "SELECT MAX(cid) FROM shop_carts;"

	sql_modify_user_shopping_cart: STRING = "UPDATE shop_carts SET uid=:uid, email=:email, security=:security, changed=:changed, items=:items, data=:data WHERE cid=:cid ;"

	sql_delete_shopping_cart: STRING = "DELETE FROM shop_carts WHERE cid=:cid;"

	sql_insert_order: STRING = "INSERT INTO shop_orders (name, uid, email, created, data) VALUES (:name, :uid, :email, :created, :data);"

	sql_select_order_by_name: STRING = "SELECT oid, name, uid, email, created, data FROM shop_orders WHERE name=:name ;"

feature {NONE} -- Implementation

	resolved_user (a_user: CMS_USER): CMS_USER
		do
			if
				attached {CMS_PARTIAL_USER} a_user as l_partial_user and then
				l_partial_user.has_id and then
				attached api as l_api and then attached l_api.user_api.user_by_id (l_partial_user.id) as u
			then
				Result := u
			else
				Result := a_user
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end


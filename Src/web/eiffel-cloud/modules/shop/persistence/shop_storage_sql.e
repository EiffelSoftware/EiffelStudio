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

	shopping_cart_by_name (a_cart_name: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		do
			reset_error
			sql_query (sql_select_shopping_cart_by_name, sql_parameters (1, <<["name", a_cart_name]>>))
			sql_start
			if not has_error and not sql_after then
				Result := fetch_shopping_cart
				check valid_record: Result /= Void end
			end
			sql_finalize_query (sql_select_shopping_cart_by_name)
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
			sql_append_parameters ({ARRAY [TUPLE [READABLE_STRING_GENERAL, detachable ANY]]}
							<<
								["uid", l_uid],
								["name", a_cart.identifier],
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
			l_name: READABLE_STRING_8
			u: CMS_PARTIAL_USER
		do
			cid := sql_read_integer_64 (1)
			uid := sql_read_integer_64 (2)
			l_name := sql_read_string (3)
			if l_name = Void then
				l_name := "undefined"
			end
			create u.make_with_id (uid)
			if uid = 0 then
				create Result.make_guest (l_name)
				Result.update_id (cid)
			else
				create Result.make_with_id (cid, u, l_name)
			end
			if attached sql_read_string (4) as l_email then
				Result.set_email (l_email)
			end
			if attached sql_read_string_32 (5) as l_sec then
				Result.set_security (l_sec)
			end
			if attached sql_read_date_time (6) as dt then
				Result.set_modification_date (dt)
			end
			if attached sql_read_string (7) as s and then not s.is_whitespace then
				Result.set_items_from_json_string (s)
			end
			Result.data := sql_read_string (8)
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

	cart_to_order (a_cart: SHOPPING_CART; a_ref: detachable READABLE_STRING_GENERAL; a_order_name: READABLE_STRING_8): SHOPPING_ORDER
		local
			l_params: like sql_parameters
			j: READABLE_STRING_8
		do
			j := a_cart.to_json_string

			create Result.make_from_cart (a_order_name, a_cart)
			if a_ref /= Void then
				Result.set_reference_id (a_ref)
			end

			reset_error
			l_params := sql_parameters (5, {ARRAY [TUPLE [name: READABLE_STRING_GENERAL; value: detachable ANY]]} <<
					["name", Result.name],
					["uid", a_cart.owner.id],
					["email", Result.email],
					["created", Result.creation_date],
					["data", j],
					["reference", Result.reference_id],
					["interval_type", Result.interval],
					["interval_count", Result.interval_count]
				>>)
			sql_insert (sql_insert_order, l_params)
			sql_finalize_insert (sql_insert_order)

			if not has_error then
				delete_shopping_cart (a_cart)
			end
		end

	order_by_name (a_order_name: READABLE_STRING_GENERAL): detachable SHOPPING_ORDER
		local
			cid, uid: INTEGER_64
			l_creation_date: DATE_TIME
			l_name: READABLE_STRING_8
			l_email: READABLE_STRING_8
			j_data: READABLE_STRING_8
			ref: READABLE_STRING_8
			l_int: READABLE_STRING_8
			l_int_nb: INTEGER_32
		do
			reset_error
			sql_query (sql_select_order_by_name, sql_parameters (1, <<["name", a_order_name]>>))
			sql_start
			if not has_error and not sql_after then
				cid := sql_read_integer_64 (1)
				l_name := sql_read_string_8 (2)
				uid := sql_read_integer_64 (3)
				l_email := sql_read_string (4)
				l_creation_date := sql_read_date_time (5)
				j_data := sql_read_string (6)
				ref := sql_read_string_8 (7)
				l_int := sql_read_string_8 (8)
				l_int_nb := sql_read_integer_32 (9)
				if l_int_nb = 0 then
					l_int_nb := 1
				end
			end
			sql_finalize_query (sql_select_order_by_name)
			if
				not has_error and then
				l_name /= Void
			then
				if l_creation_date = Void then
					check has_creation_date: False end
					create l_creation_date.make_now_utc
				end
				if
					uid > 0 and then
				 	attached resolved_user (create {CMS_PARTIAL_USER}.make_with_id (uid)) as l_user
				then
					create Result.make_with_user (l_name, l_user, l_creation_date)
				elseif l_email /= Void then
					create Result.make_with_email (l_name, l_email, l_creation_date)
				end
				if Result /= Void then
					if Result.email = Void and then l_email /= Void then
						Result.set_email (l_email)
					end
					if j_data /= Void then
						Result.set_associated_cart_with_json_data (j_data)
					else
						check has_data: False end
					end
					if ref /= Void then
						Result.set_reference_id (ref)
					end
					Result.set_interval (l_int, l_int_nb)
				end
			end
			check
				Result /= Void implies
			 	attached Result.associated_cart as l_cart and then
			 	l_cart.owner.id = uid
			 end
		end

feature {NONE} -- Queries

	sql_select_user_shopping_cart: STRING = "SELECT cid, uid, name, email, security, changed, items, data FROM shop_carts WHERE uid=:uid ORDER by cid LIMIT 1;"

	sql_select_shopping_cart_by_email: STRING = "SELECT cid, uid, name, email, security, changed, items, data FROM shop_carts WHERE email=:email ;"

	sql_select_shopping_cart_by_id: STRING = "SELECT cid, uid, name, email, security, changed, items, data FROM shop_carts WHERE cid=:cid ;"

	sql_select_shopping_cart_by_name: STRING = "SELECT cid, uid, name, email, security, changed, items, data FROM shop_carts WHERE name=:name ;"

	sql_insert_user_shopping_cart: STRING = "INSERT INTO shop_carts (uid, name, email, changed, security, items, data) VALUES (:uid, :name, :email, :changed, :security, :items, :data);"

	sql_last_inserted_shopping_cart_id: STRING = "SELECT MAX(cid) FROM shop_carts;"

	sql_modify_user_shopping_cart: STRING = "UPDATE shop_carts SET uid=:uid, name=:name, email=:email, security=:security, changed=:changed, items=:items, data=:data WHERE cid=:cid ;"

	sql_delete_shopping_cart: STRING = "DELETE FROM shop_carts WHERE cid=:cid;"

	sql_delete_shopping_cart_by_name: STRING = "DELETE FROM shop_carts WHERE name=:name;"


	sql_insert_order: STRING = "INSERT INTO shop_orders (name, uid, email, created, data, reference, interval_type, interval_count) VALUES (:name, :uid, :email, :created, :data, :reference, :interval_type, :interval_count);"

	sql_select_order_by_name: STRING = "SELECT oid, name, uid, email, created, data, reference, interval_type, interval_count FROM shop_orders WHERE name=:name ;"

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


note
	description: "Interface for accessing stripe data from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_STORAGE_SQL

inherit
	STRIPE_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

create
	make

feature -- Store

	customers_by_uid (a_user: CMS_USER): detachable LIST [READABLE_STRING_32]
		local
			s: READABLE_STRING_32
		do
			reset_error
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (0)
			sql_query (sql_select_customer_by_uid, sql_parameters (1, <<["uid", a_user.id]>>))
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					s := sql_read_string_32 (1)
					if s /= Void and then not s.is_whitespace then
						Result.force (s)
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_customer_by_uid)
		end

	customers_by_email (a_email: READABLE_STRING_GENERAL): detachable LIST [READABLE_STRING_32]
		local
			s: READABLE_STRING_32
		do
			reset_error
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (0)
			sql_query (sql_select_customer_by_email, sql_parameters (1, <<["email", a_email]>>))
			sql_start
			if not has_error then
				from
					sql_start
				until
					sql_after or has_error
				loop
					s := sql_read_string_32 (1)
					if s /= Void and then not s.is_whitespace then
						Result.force (s)
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_customer_by_email)
		end

	user_by_customer_id (a_customer_id: READABLE_STRING_GENERAL): detachable CMS_USER
		local
			uid: INTEGER_64
		do
			reset_error
			sql_query (sql_select_user_by_customer_id, sql_parameters (1, <<["customer", a_customer_id]>>))
			sql_start
			if not has_error and not sql_after then
				uid := sql_read_integer_64 (2)
			end
			sql_finalize_query (sql_select_user_by_customer_id)
			if uid > 0 then
				Result := resolved_user (create {CMS_PARTIAL_USER}.make_with_id (uid))
			end
		end

	save_customer_id (a_customer_id: READABLE_STRING_GENERAL; a_user_id: like {CMS_USER}.id; a_email: detachable READABLE_STRING_GENERAL)
		local
			l_params: like sql_parameters
			l_email: READABLE_STRING_GENERAL
			l_uid: INTEGER_64
			l_same_uid, l_same_email: BOOLEAN
		do
			reset_error
			sql_query (sql_select_user_by_customer_id, sql_parameters (1, <<["customer", a_customer_id]>>))
			if not has_error and not sql_after then
				l_uid := sql_read_integer_64 (2)
				l_email := sql_read_string (3)
				if l_email /= Void and then l_email.is_whitespace then
					l_email := Void
				end
			end
			sql_finalize_query (sql_select_user_by_customer_id)
			l_same_uid := l_uid = a_user_id
			if l_email = Void then
				l_same_email := a_email = Void
			elseif a_email /= Void then
				l_same_email := l_email.same_string (a_email)
			end

			if l_uid = 0 and l_email = Void then
					-- New association
				l_params := sql_parameters (3,  {ARRAY [TUPLE [READABLE_STRING_GENERAL, detachable ANY]]}
								 <<["customer", a_customer_id], ["uid", a_user_id], ["email", a_email]>>)
				sql_insert (sql_insert_customer, l_params)
				sql_finalize_insert (sql_insert_customer)
			elseif not (l_same_uid and l_same_email) then
					-- Update existing association !
				if l_uid = 0 then
					l_uid := a_user_id
				end
				if l_email = Void then
					l_email := a_email
				end
				l_params := sql_parameters (3,  {ARRAY [TUPLE [READABLE_STRING_GENERAL, detachable ANY]]}
								 <<["customer", a_customer_id], ["uid", l_uid], ["email", l_email]>>)
				sql_modify (sql_update_customer, l_params)
				sql_finalize_modify (sql_update_customer)
			end
		end

feature -- Payment

	record_invoice (a_invoice: STRIPE_INVOICE)
		local
			l_params: like sql_parameters
		do
			reset_error
			l_params := sql_parameters (5,  {ARRAY [TUPLE [READABLE_STRING_GENERAL, detachable ANY]]}
							 <<
							 	["pi", a_invoice.payment_intent_id],
							 	["sub", a_invoice.subscription_id],
							 	["status", a_invoice.status],
							 	["event_date", create {DATE_TIME}.make_now_utc],
							 	["data", a_invoice.to_json_string]
							 >>)
			sql_insert (sql_insert_payment, l_params)
			sql_finalize_insert (sql_insert_payment)
		end

	record_payment_intent (pi: STRIPE_PAYMENT_INTENT)
		local
			l_params: like sql_parameters
		do
			reset_error
			l_params := sql_parameters (5,  {ARRAY [TUPLE [READABLE_STRING_GENERAL, detachable ANY]]}
							 <<
							 	["pi", pi.id],
							 	["sub", Void],
							 	["status", pi.status],
							 	["event_date", create {DATE_TIME}.make_now_utc],
							 	["data", pi.to_json_string]
							 >>)
			sql_insert (sql_insert_payment, l_params)
			sql_finalize_insert (sql_insert_payment)
		end

	is_payment_processed (a_payment_id: READABLE_STRING_GENERAL): BOOLEAN
		local
			s: READABLE_STRING_8
		do
			reset_error
			sql_query (sql_select_payment_by_id, sql_parameters (1, <<["pi", a_payment_id]>>))
			if not has_error and not sql_after then
				s := sql_read_string_8 (4)
				if s /= Void then
					Result := s.is_case_insensitive_equal_general ("paid")
							or s.is_case_insensitive_equal_general ("succeeded")
				end
			end
			sql_finalize_query (sql_select_payment_by_id)
		end

feature {NONE} -- Queries

	sql_select_user_by_customer_id: STRING = "SELECT customer, uid, email FROM stripe_customers WHERE customer=:customer;"

	sql_select_customer_by_uid: STRING = "SELECT customer, uid, email FROM stripe_customers WHERE uid=:uid ;"

	sql_select_customer_by_email: STRING = "SELECT customer, uid, email FROM stripe_customers WHERE email=:email ;"

	sql_insert_customer: STRING = "INSERT INTO stripe_customers (customer, uid, email) VALUES (:customer, :uid, :email);"

	sql_update_customer: STRING = "UPDATE stripe_customers SET uid=:uid, email=:email WHERE customer=:customer;"


	sql_insert_payment: STRING = "INSERT INTO stripe_payments (pi, sub, status, event_date, data) VALUES (:pi, :sub, :status, :event_date, :data);"

	sql_select_payment_by_id: STRING = "SELECT id, pi, sub, status, event_date, data FROM stripe_payments WHERE pi=:pi ORDER BY event_date DESC, id DESC LIMIT 1;"

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


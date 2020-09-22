note
	description: "Summary description for {SHOPPING_ORDER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_ORDER

create
	make_from_cart,
	make_with_user,
	make_with_email

feature {NONE} -- Initialization

	make_from_cart (a_name: READABLE_STRING_8; a_cart: SHOPPING_CART)
		do
			make_with_user (a_name, a_cart.owner, create {DATE_TIME}.make_now_utc)
			if email = Void and then attached a_cart.email as l_cart_email then
				set_email (l_cart_email)
			end
			if a_cart.is_yearly then
				set_yearly (1)
			elseif a_cart.is_monthly then
				set_monthly (1)
			elseif a_cart.is_weekly then
				set_weekly (1)
			elseif a_cart.is_daily then
				set_daily (1)
			else
				set_ontime
			end
		end

	make_with_user (a_name: READABLE_STRING_8; a_user: CMS_USER; a_creation_date: DATE_TIME)
		do
			user := a_user
			creation_date := a_creation_date
			create name.make_from_string (a_name)
			if attached a_user.email as l_email then
				set_email (l_email)
			end
		end

	make_with_email (a_name: READABLE_STRING_8; a_email: READABLE_STRING_8; a_creation_date: DATE_TIME)
		do
			set_email (a_email)
			creation_date := a_creation_date
			create name.make_from_string (a_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_8

	user: detachable CMS_USER

	email: detachable IMMUTABLE_STRING_8

	creation_date: DATE_TIME

	reference_id: detachable IMMUTABLE_STRING_32

	associated_cart: detachable SHOPPING_CART

feature -- Interval

	interval: detachable READABLE_STRING_8
	interval_count: INTEGER

	set_interval (a_int: detachable READABLE_STRING_8; a_int_count: INTEGER)
		do
			if a_int = Void then
				set_ontime
			elseif a_int.is_case_insensitive_equal_general ("year") then
				set_yearly (a_int_count)
			elseif a_int.is_case_insensitive_equal_general ("mnnth") then
				set_monthly (a_int_count)
			elseif a_int.is_case_insensitive_equal_general ("week") then
				set_weekly (a_int_count)
			elseif a_int.is_case_insensitive_equal_general ("day") then
				set_daily (a_int_count)
			else
				set_ontime
			end
		end

	set_yearly (nb: INTEGER)
		do
			interval := "year"
			interval_count := nb
		end

	set_monthly (nb: INTEGER)
		do
			interval := "month"
			interval_count := nb
		end

	set_weekly (nb: INTEGER)
		do
			interval := "week"
			interval_count := nb
		end

	set_daily (nb: INTEGER)
		do
			interval := "day"
			interval_count := nb.min (1)
		end

	set_ontime
		do
			interval := Void
			interval_count := 0
		end

	is_yearly (nb: INTEGER): BOOLEAN
			-- Is every `nb` years?
			-- if nb = 0 then consider any interval_count.
		do
			Result := attached interval as i and then i.is_case_insensitive_equal ("year") and then (nb = 0 or else interval_count = nb)
		end

	is_monthly (nb: INTEGER): BOOLEAN
			-- Is every `nb` months?
			-- if nb = 0 then consider any interval_count.
		do
			Result := attached interval as i and then i.is_case_insensitive_equal ("month") and then (nb = 0 or else interval_count = nb)
		end

	is_weekly (nb: INTEGER): BOOLEAN
			-- Is every `nb` weeks?
			-- if nb = 0 then consider any interval_count.	
		do
			Result := attached interval as i and then i.is_case_insensitive_equal ("week") and then (nb = 0 or else interval_count = nb)
		end

	is_daily (nb: INTEGER): BOOLEAN
			-- Is every `nb` days?
			-- if nb = 0 then consider any interval_count.	
		do
			Result := attached interval as i and then i.is_case_insensitive_equal ("day") and then (nb = 0 or else interval_count = nb)
		end

	is_ontime: BOOLEAN
		do
			Result := interval = Void
		end

feature -- Element change

	set_reference_id (a_ref: READABLE_STRING_GENERAL)
		do
			create reference_id.make_from_string_general (a_ref)
		end

	set_email (a_email: READABLE_STRING_8)
		do
			create email.make_from_string (a_email)
		end

	set_associated_cart (a_cart: SHOPPING_CART)
		do
			associated_cart := a_cart
		end

	set_associated_cart_with_json_data (a_json_data: READABLE_STRING_8)
		do
			create associated_cart.make_from_json (a_json_data)
		end

end

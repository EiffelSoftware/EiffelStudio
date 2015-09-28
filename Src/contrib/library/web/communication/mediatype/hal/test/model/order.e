note
	description: "Summary description for {ORDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER
inherit
	SHARED_ORDER_REPOSITORY
create
	make
feature {NONE} -- Initialization
	make (a_name : STRING; a_currency : STRING; a_status : STRING; a_customer : CUSTOMER)
		do
			set_currency(a_currency)
			set_status (a_status)
			set_placed("now!!!")
			set_customer (a_customer)
			set_id (order_repo.next_id)
			create line_items.make (a_name)
		end

feature -- Access

	total : REAL
		do
			if attached line_items.items as l_items then
				across l_items as e loop
					Result := Result + e.item.price
				end
			end
		end


	id : INTEGER
--	name : STRING
	currency : STRING
	status : STRING
	placed : STRING
	customer : CUSTOMER
	line_items : LINE_ITEM

feature -- Element Change
	set_id ( an_id : INTEGER)
		do
			id := an_id
		end

--	set_name (a_name : STRING)
--		do
--			name := a_name
--		end

	set_currency (a_currency : STRING)
		do
			currency := a_currency
		end

	set_status (a_status : STRING)
		do
			status := a_status
		end

	set_placed (date: STRING)
		do
			placed := date
		end

	set_customer (a_customer : CUSTOMER)
		do
			customer := a_customer
		end

	add_item (an_item : ITEM)
		do
			line_items.add_item(an_item)
		end

end

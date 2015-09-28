note
	description: "Summary description for {ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM
create
	make
feature {NONE} -- Initialization
	make (an_id : STRING; a_quantity : NATURAL; a_price : REAL )
		do
			set_id (an_id)
			set_quantity (a_quantity)
			set_price (a_price)
		end

feature -- Access
	id : STRING
	quantity : NATURAL
	price : REAL

feature -- Element Change
	set_id (an_id : STRING)
		do
			id := an_id
		end

	set_quantity (a_quantity : NATURAL)
		do
			quantity := a_quantity
		end

	set_price (a_price : REAL)
		do
			price := a_price
		end

end

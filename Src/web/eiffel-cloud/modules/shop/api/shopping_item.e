note
	description: "Summary description for {SHOP_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_code: READABLE_STRING_GENERAL; a_provider_id: READABLE_STRING_GENERAL)
		do
			create code.make_from_string_general (a_code)
			create provider.make_from_string_general (a_provider_id)
			quantity := 1
		end

feature -- Access

	code: IMMUTABLE_STRING_32

	provider: IMMUTABLE_STRING_32

	quantity: NATURAL_32 assign set_quantity

	data: detachable STRING_8 assign set_data
			-- Extra data stored as JSON

feature -- Resolved data

	details: detachable SHOPPING_ITEM_DETAILS assign set_details

	is_onetime: BOOLEAN
		require
			details /= Void
		do
			Result := attached details as d and then d.is_onetime
		end

feature -- Status report

	same_item (other: SHOPPING_ITEM): BOOLEAN
		do
			Result := code.is_case_insensitive_equal_general (other.code) and then
				provider.is_case_insensitive_equal_general (other.provider)
		end

feature -- Element change

	set_details (d: like details)
		do
			details := d
		end

	set_quantity (n: like quantity)
		do
			quantity := n
		end

	increment_quantity (n: like quantity)
		do
			quantity := quantity + n
		end

	set_data (v: like data)
		do
			data := v
		end

invariant

end

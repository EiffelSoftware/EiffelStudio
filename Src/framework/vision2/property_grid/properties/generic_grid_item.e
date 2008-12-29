note
	description: "Generic grid item."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_GRID_ITEM [G]

inherit
	EV_GRID_LABEL_ITEM
		export
			{NONE} data, set_data
		end

create
	make_with_text

feature -- Access

	value: G

feature -- Update

	set_value (a_value: like value)
			-- Set `value' to `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

end

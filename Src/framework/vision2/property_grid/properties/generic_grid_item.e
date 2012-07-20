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

	value: detachable G

feature -- Update

	set_value (a_value: like value)
			-- Set `value' to `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

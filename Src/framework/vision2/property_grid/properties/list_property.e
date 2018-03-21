note
	description: "Property for an ordered list of strings."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_PROPERTY

inherit
	DIALOG_PROPERTY [LIST [READABLE_STRING_32]]
		redefine
			displayed_value,
			dialog
		end

create
	make,
	make_with_dialog

feature -- Access

	displayed_value: STRING_32
			-- Convert `data' into a text representation.
		do
			if attached value as l_value then
				create Result.make_empty
				from
					l_value.start
				until
					l_value.after
				loop
					Result.append (l_value.item.out+";")
					l_value.forth
				end
				if Result.count > 0 then
					Result.remove_tail (1)
				end
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Implementation

	dialog: detachable LIST_DIALOG note option: stable attribute end
			-- Dialog to change values

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

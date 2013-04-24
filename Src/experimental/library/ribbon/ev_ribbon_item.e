note
	description: "[
					Abstract representation of an item of a ribbon.
																							]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_ITEM

feature -- Query

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current
		deferred
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

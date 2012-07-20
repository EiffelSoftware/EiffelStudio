note
	description: "Represents a row in a property grid."
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY_ROW

inherit
	EV_GRID_ROW

feature -- Access

	property: detachable PROPERTY
			-- If the row represents a property, this is the property that is represented.

feature -- Update

	set_property (a_property: like property)
			-- Set `property' to `a_property'.
		require
			a_property_not_void: a_property /= Void
		do
			property := a_property
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

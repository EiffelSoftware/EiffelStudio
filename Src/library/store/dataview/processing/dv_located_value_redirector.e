indexing
	description: "Objects that contain a VALUE_REDIRECTOR positionned with %
			%an integer"
	date: "$Date$"
	revision: "$Revision$"

class
	DV_LOCATED_VALUE_REDIRECTOR

feature -- Access

	value_redirector: DV_VALUE_REDIRECTOR
			-- Value redirector.

	location: INTEGER
			-- Position in a list.

feature -- Settings

	set_value_redirector (v: DV_VALUE_REDIRECTOR) is
			-- Set `value_redirector' with `v'.
		do
			value_redirector := v
		ensure
			value_redirector_set: value_redirector = v
		end

	set_location (v: INTEGER) is
			-- Set `location' with `v'.
		do
			location := v
		ensure
			location_set: location = v
		end

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_LOCATED_VALUE_REDIRECTOR
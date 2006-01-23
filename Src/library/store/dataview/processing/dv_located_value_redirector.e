indexing
	description: "Objects that contain a VALUE_REDIRECTOR positionned with %
			%an integer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_LOCATED_VALUE_REDIRECTOR


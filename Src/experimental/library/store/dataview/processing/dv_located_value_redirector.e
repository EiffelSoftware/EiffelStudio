note
	description: "Objects that contain a VALUE_REDIRECTOR positionned with %
			%an integer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_LOCATED_VALUE_REDIRECTOR

create
	make

feature {NONE} -- Initialization

	make (a_director: like value_redirector; a_pos: like location)
			-- Initialize Current with `a_director' as `value_redirector' and `a_pos' as `location'.
		do
			value_redirector := a_director
			location := a_pos
		ensure
			value_redirector_set: value_redirector = a_director
			location_set: location = a_pos
		end

feature -- Access

	value_redirector: DV_VALUE_REDIRECTOR
			-- Value redirector.

	location: INTEGER
			-- Position in a list.

feature -- Settings

	set_value_redirector (v: DV_VALUE_REDIRECTOR)
			-- Set `value_redirector' with `v'.
		do
			value_redirector := v
		ensure
			value_redirector_set: value_redirector = v
		end

	set_location (v: INTEGER)
			-- Set `location' with `v'.
		do
			location := v
		ensure
			location_set: location = v
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- class DV_LOCATED_VALUE_REDIRECTOR


indexing
	description: 
		"[
			Input field for a single line of `text'.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+-------------+
			|  text       |
			+-------------+
		]"
	status: "See notice at end of class."
	keywords: "input, text, field, query"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_TEXT_FIELD

inherit
	EV_TEXT_COMPONENT
		redefine
			implementation,
			is_in_default_state
		end
		
	EV_FONTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	capacity: INTEGER is
			-- Number of characters field can hold.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.capacity
		end

feature -- Element change

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		require
			not_destroyed: not is_destroyed
			a_capacity_not_negative: a_capacity >= 0
		do
			implementation.set_capacity (a_capacity)
		end

feature -- Status report
		
	is_in_default_state: BOOLEAN is
			-- Is `Current' in a correct default state?
		do
			Result := Precursor {EV_TEXT_COMPONENT} and Precursor {EV_FONTABLE}
		end
		

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TEXT_FIELD_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TEXT_FIELD_IMP} implementation.make (Current)
		end
			
invariant
	capacity_not_negative: capacity >= 0

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




end -- class EV_TEXT_FIELD


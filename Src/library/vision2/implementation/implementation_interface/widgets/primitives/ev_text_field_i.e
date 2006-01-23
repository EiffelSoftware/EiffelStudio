indexing
	description: 
		"Eiffel Vision text field. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_FIELD_I
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end
	
	EV_FONTABLE_I	
		redefine
			interface
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_I

feature -- Status report

	capacity: INTEGER is
			-- Maximum number of characters field can hold.
		deferred
		end

feature -- Status setting

	set_capacity (a_capacity: INTEGER) is
			-- Assign `a_capacity' to `capacity'.
		require
			a_capacity_not_negative: a_capacity >= 0
		deferred
		end

	hide_border is
			-- Hide the border of `Current'.
		do
			-- Redefined in EV_TEXT_FIELD_IMP as it is not needed by all EV_TEXT_FIELD_I descendents.
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end --class EV_TEXT_FIELD_I


indexing 
	description:
		"[
			Input field for a single line of `text', displayed
			as a sequence of `*'.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+-------------+
			| ********    |
			+-------------+
		]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD

inherit
	EV_TEXT_FIELD
		redefine
			create_implementation,
			implementation
		end

create
	default_create,
	make_with_text

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PASSWORD_FIELD_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PASSWORD_FIELD_IMP} implementation.make (Current)
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




end -- class EV_PASSWORD_FIELD


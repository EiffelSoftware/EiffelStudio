note
	description:
		"Accessor facility for stacks"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STACK_ACCESSOR [G] inherit

	FIXTURE_ACCESSOR
		rename
			fixture as stack
		redefine
			stack
		end

feature -- Access

	stack: STACK [G]
			-- Stack accessor
		do
			Result ?= Precursor
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class STACK_ACCESSOR


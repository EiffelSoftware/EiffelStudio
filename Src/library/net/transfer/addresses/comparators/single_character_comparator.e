indexing
	description:
		"Comparators for single characters"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SINGLE_CHARACTER_COMPARATOR inherit

	COMPARATOR

create

	make

feature {NONE} -- Initialization

	make (c: CHARACTER) is
			-- Create comparator.
		do
			character := c
		ensure
			character_set: character = c
		end

feature -- Access

	character_set: STRING is
			-- Character represented by comparator
		do
			create Result.make (1)
			Result.extend (character)
		end

	contains (c: CHARACTER): BOOLEAN is
			-- Does comparator contain `c'?
		do
			Result := character = c
		end

feature {NONE} -- Implementation

	character: CHARACTER;

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




end -- class SINGLE_CHARACTER_COMPARATOR


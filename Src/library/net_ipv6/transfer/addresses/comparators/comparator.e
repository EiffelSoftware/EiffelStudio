indexing
	description:
		"Comparators for characters"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	COMPARATOR

feature -- Access

	character_set: STRING is
			-- Character set represented by comparator
		deferred
		end

	contains (c: CHARACTER): BOOLEAN is
			-- Does comparator contain `c'?
		deferred
		end
	
invariant

	no_empty_comparator: character_set /= Void and then 
			not character_set.is_empty

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




end -- class COMPARATOR


indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Integer constants

class
	INT_CONSTANT 

inherit

	TERMINAL

	CONSTANTS
		undefine
			copy, is_equal
		end

feature 

	token_type: INTEGER is
		do  
			Result := Integer_constant
		end

feature {NONE}

	construct_name: STRING is
		once
			Result := "INT_CONSTANT"
		end -- construct_name

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


end -- class INT_CONSTANT


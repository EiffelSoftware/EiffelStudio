indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Simple variables

class
	SIMPLE_VAR 

inherit

	IDENTIFIER
		redefine 
			action, construct_name
		end

	POLYNOM
		undefine
			copy, is_equal
		end

create
	make

feature {NONE}

	construct_name: STRING is
		once
			Result := "SIMPLE_VAR"
		end -- construct_name

	action is
		do
			info.set_child_value (info.int_value (token.string_value))
		end -- action

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


end -- class SIMPLE_VAR


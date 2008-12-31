note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Variables

class
	VAR 

inherit

	IDENTIFIER
		redefine
			construct_name, action
		end

	POLYNOM
		undefine
			copy, is_equal
		end

create
	make

feature {NONE}

	construct_name: STRING
		once
			Result := "VAR"
		end; -- construct_name

	action
		do
			info.cons_id_table (token.string_value)
		end -- action

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


end -- class VAR


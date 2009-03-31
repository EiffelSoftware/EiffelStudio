note
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

	construct_name: STRING
		once
			Result := "SIMPLE_VAR"
		end -- construct_name

	action
		local
			l_token: like token
		do
			l_token := token
			if l_token /= Void then
				info.set_child_value (info.int_value (l_token.string_value))
			end
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


end -- class SIMPLE_VAR


indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Identifiers

class
	IDENTIFIER 

inherit

	TERMINAL

	CONSTANTS
		undefine
			copy, is_equal
		end

create
	make

feature {NONE}

	default_identifier_name: STRING is 
		once
			Result := "IDENTIFIER"
		end -- default_identifier_name

	construct_name: STRING is
		do
			Result := default_identifier_name
		end -- construct_name

feature 

	token_type: INTEGER is
		do
			Result := Simple_identifier
		end -- token_type

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


end -- class IDENTIFIER


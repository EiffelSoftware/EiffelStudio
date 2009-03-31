note
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

	default_identifier_name: STRING
		once
			Result := "IDENTIFIER"
		end -- default_identifier_name

	construct_name: STRING
		do
			Result := default_identifier_name
		end -- construct_name

feature

	token_type: INTEGER
		do
			Result := Simple_identifier
		end -- token_type

feature {IDENTIFIER} -- Implementation

	clone_node (n: like Current): like Current
			-- <precursor>
		do
			create Result.make
			Result.copy_node (n)
		end

	new_tree: like Current
			-- <precursor>
		do
			create Result.make
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


end -- class IDENTIFIER


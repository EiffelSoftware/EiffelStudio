indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Records position of possible breakpoints within debuggable byte code,
-- with respect to the AST nodes.

class AST_POSITION

inherit

	COMPARABLE
		undefine
			is_equal
		end;
	ANY

create

	make

feature -- Debugger

	infix "<" (other: like Current): BOOLEAN is
			-- Is current element less than `other'?
		do
			Result := position < other.position;
		end;
	
	position: INTEGER;
			-- Position within byte array since start of byte code
	
	ast_node: AST_EIFFEL;
			-- The AST node which is associated with the break-point (that is
			-- the ast node which follows the break-point at `position'.

	make (pos: INTEGER; node: AST_EIFFEL) is
			-- Initialization
		do
			position := pos;
			ast_node := node;
		end;

	shift (amount: INTEGER) is
			-- Shift `position' by `amount'
		do
			position := position + amount;
		end;

	set_stop (b: BOOLEAN) is
		do
			is_set := b;
		end;

	is_set: BOOLEAN;;
		-- is a breakpoint set at this position

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

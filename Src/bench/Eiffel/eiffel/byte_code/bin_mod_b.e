indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BIN_MOD_B

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_simple,
			generate_simple, is_built_in
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_mod_b (Current)
		end

feature

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

	generate_operator is
			-- Generate the operator
		do
			buffer.put_string (" %% ");
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" %%= ");
		end;

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		local
			l_type: TYPE_I
		do
			l_type := context.real_type (type)
			Result := l_type.is_integer or l_type.is_natural
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

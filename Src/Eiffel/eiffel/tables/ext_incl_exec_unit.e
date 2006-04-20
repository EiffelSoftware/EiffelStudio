indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXT_INCL_EXEC_UNIT

inherit
	EXT_EXECUTION_UNIT
		redefine
			generate_declaration
		end

	SHARED_EXEC_TABLE
		undefine
			is_equal
		end

create
	make

feature -- Access

	include_list: ARRAY [INTEGER]
			-- List of header files used by Current external.

feature -- Setting

	set_include_list (headers: like include_list) is
			-- Assign `headers' to `include_list'.
		require
			headers_not_void: headers /= Void
		do
			include_list := headers
		ensure
			include_list_set: include_list = headers
		end

feature -- Generation

	generate_declaration (buffer: GENERATION_BUFFER) is
		local
			i, n: INTEGER
			include_set: LINKED_SET [INTEGER]
		do
				-- We don't have to generate the declaration
				-- extern toto(); but we need to include all
				-- the include files needed by the current feature
			from
				include_set := Execution_table.include_set
				i := include_list.lower
				n := include_list.upper
			until
				i > n
			loop
				include_set.extend (include_list.item (i))
				i := i + 1
			end
		end

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

note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- DialogEx_resource -> "DIALOGEX" DialogEx_options "BEGIN" Control_statement_ex_list "END"

class S_DIALOGEX_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING
		once
			Result := "DIALOGEX_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT]
		local
			options: DIALOGEX_OPTIONS
			begin1: BEGIN_BLOCK
			control_list: CONTROL_STATEMENT_EX_LIST
			end1: END_BLOCK
		once
			create Result.make
			Result.forth

			keyword ("DIALOGEX")
			commit

			create options.make
			put (options)

			create begin1.make
			put (begin1)

			create control_list.make
			put (control_list)

			create end1.make
			put (end1)
		end

note
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
end -- class S_DIALOGEX_RESOURCE


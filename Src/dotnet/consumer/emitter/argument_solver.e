indexing
	description: "Generate Eiffel arguments from .NET arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_SOLVER

inherit
	NAME_FORMATTER

	SHARED_ASSEMBLY_MAPPING

feature -- Access

	arguments (info: METHOD_BASE): ARRAY [CONSUMED_ARGUMENT] is
			-- Argument of `info'
		require
			non_void_method: info /= Void
		local
			i, count: INTEGER
			en, dn: STRING
			params: NATIVE_ARRAY [PARAMETER_INFO]
			p: PARAMETER_INFO
			t: SYSTEM_TYPE
		do
			create Result.make (1, info.get_parameters.count)
			params := info.get_parameters
			from
				i := 0
				count := params.count
			until
				i >= count
			loop
				p := params.item (i)
				if p.name = Void then
					en := formatted_argument_name ("", i + 1)
					dn := en.twin
				else
					dn := p.name
					en := formatted_argument_name (dn, i + 1)
					if dn.is_empty then
						dn := en.twin
					end
				end
				t := p.parameter_type
				Result.put (create {CONSUMED_ARGUMENT}.make (dn, en,
					referenced_type_from_type (t)), i + 1)
				i := i + 1
			end
		ensure
			non_void_arguments: Result /= Void
		end
		
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


end -- class ARGUMENT_SOLVER

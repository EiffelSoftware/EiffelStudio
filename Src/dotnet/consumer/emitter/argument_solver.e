note
	description: "Generate Eiffel arguments from .NET arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_SOLVER

inherit
	SYSTEM_OBJECT

	NAME_FORMATTER

	SHARED_ASSEMBLY_MAPPING

feature -- Access

	arguments (info: METHOD_BASE): ARRAY [CONSUMED_ARGUMENT]
			-- Argument of `info'
		require
			non_void_method: info /= Void
		local
			i, count: INTEGER
			en, dn: STRING
		do
			create Result.make_empty
			if attached info.get_parameters as params then
				from
					i := 0
					count := params.count
				until
					i >= count
				loop
					if attached params.item (i) as p then
						if attached p.name as l_arg_name then
							dn := l_arg_name
							en := formatted_argument_name (dn, i + 1)
							if dn.is_empty then
								dn := en.twin
							end
						else
							en := formatted_argument_name ("", i + 1)
							dn := en.twin
						end
						if attached p.parameter_type as t then
							Result.force (create {CONSUMED_ARGUMENT}.make (dn, en,
								referenced_type_from_type (t)), i + 1)
						end
					end
					i := i + 1
				end
			end
		ensure
			non_void_arguments: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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


end -- class ARGUMENT_SOLVER

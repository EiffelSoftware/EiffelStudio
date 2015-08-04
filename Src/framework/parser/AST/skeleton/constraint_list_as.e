note
	description: "[
					Do a second pass over the generic declaration of a class.
					If its not a formal record it in the supplier list of the current class.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINT_LIST_AS

inherit
	EIFFEL_LIST [CONSTRAINING_TYPE_AS]

create
	make, make_filled

feature -- Status Report

	has_frozen_mark: BOOLEAN
			-- Is one of the constraint marked frozen?
		do
			from
				start
			until
				Result or else after
			loop
				Result := item.type.has_frozen_mark
				forth
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Dump

	dump (a_dump_renaming: BOOLEAN): STRING_8
			-- Dumps a list of constraining types
			--
			-- `a_dump_renaming' states whether the renaming clause should be dumped as well.	
		do
			if is_empty then
				Result := "ANY"
			else
				Result := first.type.dump
				if a_dump_renaming and then attached first.renaming as l_renaming then
					Result.append (" ")
					Result.append (l_renaming.dump)
				end
				if count > 1 then
					Result.prepend ("{")
					from
						start
						forth
					until
						after
					loop
						Result.append (", ")
						Result.append (item.type.dump)
						if a_dump_renaming and then attached item.renaming as l_renaming then
							Result.append (" ")
							Result.append (l_renaming.dump)
						end
						forth
					end
					Result.append ("}")
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

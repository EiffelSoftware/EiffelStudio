indexing
	description: "Error when can not modify Ace file to add new assemblies."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD66
	
inherit
	LACE_WARNING

create
	make
	
feature {NONE} -- Initialization

	make (a_list: ARRAYED_LIST [ASSEMBLY_I]) is
			-- Initialize Current with `a_list'.
		do
			missing_assemblies := a_list
		ensure
			missing_assemblies_set: missing_assemblies = a_list
		end
		
feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Print out error message.
		do
			a_text_formatter.add ("Could not insert following assembly(ies) in Ace file: ")
			a_text_formatter.add_new_line
			if missing_assemblies /= Void then
				from
					missing_assemblies.start
				until
					missing_assemblies.after
				loop
					missing_assemblies.item.format (a_text_formatter)
					a_text_formatter.add_new_line
					missing_assemblies.forth
				end
			end
		end

feature {NONE} -- Access

	missing_assemblies: ARRAYED_LIST [ASSEMBLY_I];
			-- List of missing assemblies.

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

end -- class VD66

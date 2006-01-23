indexing
	description: "Objects that hold code generation settings, for GB_XML_STORE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERATION_SETTINGS

feature -- Access

	generate_names: BOOLEAN
		-- Should a default name be generated
		-- for any object that does not have a name?
		
	is_saving: BOOLEAN
		-- Is current generation representing a save
		-- operation?

feature -- Status setting

	enable_generate_names is
			-- Assign `True' to `generate_names'.
		do
			generate_names := True
		end
		
	disable_generate_names is
			-- Assign `False' to `generate_names'.
		do
			generate_names := False
		end
		
	enable_is_saving is
			-- Assign `True' to `is_saving'.
		do
			is_saving := True
		end
		
	disable_is_saving is
			-- Assign `False' to `is_saving'.
		do
			is_saving := False
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


end -- class GB_GENERATION_SETTINGS

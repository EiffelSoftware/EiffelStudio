indexing
	description: "Eiffel compiler that can be used from either EiffelStudio or from Visual Studio .NET"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_WINDOWS_KERNEL

inherit
	EB_KERNEL
		rename
			make as standard_make
		end
		
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize server.
		local
			local_string: STRING
			com_compiler: ECOM_ISE_REGISTRATION
			new_resources: TTY_RESOURCES
		do
			if argument_count > 0 then
				local_string :=argument (1)
				local_string.to_lower
			end
			if
				local_string /= Void and
				(local_string.is_equal ("-regserver") or local_string.is_equal ("/regserver") or
				local_string.is_equal ("-unregserver") or local_string.is_equal ("/unregserver") or
				local_string.is_equal ("-embedding") or local_string.is_equal ("/embedding"))
			then
				register_basic_graphical_types
				initialize_resources (system_general, Eiffel_preferences)
				create new_resources.initialize
				create com_compiler.make
			else
				standard_make
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

end -- class EB_WINDOWS_KERNEL

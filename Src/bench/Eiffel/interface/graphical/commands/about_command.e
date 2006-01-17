indexing

	description: "Command to display about."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ABOUT_COMMAND 

inherit

	ISE_COMMAND
	EB_CONSTANTS
	SYSTEM_CONSTANTS


create
	make

feature {NONE} -- Initialization

	make (a_about: like about_tool) is
			-- Set `a_helpable' to `helpable'
		require
			valid_arg: a_about /= Void
		do
			about_tool := a_about
		end

feature -- Access

	about_tool: ABOUT_W
			-- Associated helpable object

	name: STRING is
			-- Name of the command.
		do
			Result := clone(Interface_names.f_About)
			Result.append(" ")
			Result.append(version_number)
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := clone(Interface_names.m_About)
			Result.append(" ")
			Result.append(version_number)
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature -- Execution

	work (argument: ANY) is
			-- Popup the help window.
		do
			if about_tool.realized then
				about_tool.show
				about_tool.set_normal_state
				about_tool.raise
			else
				about_tool.realize
			end
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

end -- class ABOUT_COMMAND

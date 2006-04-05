indexing

	description:
		"Set execution format so that each breakable points %
			%of the current routine will be taken into account."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_OUT_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			Out_of_routine as execution_mode
		redefine
			make,
			tooltext
		end

create
	make

feature -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current'.
		do
			Precursor (a_manager)
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.Key_f11),
				False, False, True)
			accelerator.actions.extend (agent execute)
		end

feature {NONE} -- Attributes

	pixmap: EV_PIXMAP is
			-- Pixmap for the button.
		do
			Result := Pixmaps.Icon_step_out
		end

	name: STRING is "Exec_out"
			-- Name of the command.

	internal_tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_out
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_out
		end

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Exec_last
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

end -- class EB_EXEC_OUT_CMD



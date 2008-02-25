indexing
	description: "Command to redo the last refactoring."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RF_REDO_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			is_tooltext_important
		end

	SHARED_DEBUGGER_MANAGER

	SHARED_EIFFEL_PROJECT

	EB_SHARED_MANAGERS

	EB_CONSTANTS

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_manager: ERF_MANAGER) is
			-- Create associated to `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
		end

feature -- Status

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

feature -- Access

	description: STRING_GENERAL is
			-- What is printed in the customize dialog.
		do
			Result := interface_names.f_refactoring_redo
		end

	tooltip: STRING_GENERAL is
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL is
			-- Text for toolbar button
		do
			Result := interface_names.b_refactoring_redo
		end

	menu_name: STRING_GENERAL is
			-- Menu entry corresponding to `Current'.
		do
			Result := tooltext
		end

	pixmap: EV_PIXMAP is
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.general_redo_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_redo_icon_buffer
		end

	Name: STRING is "RF_redo"
			-- Name of `Current' to identify it.

feature -- Execution

	execute is
			-- Execute.
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
				interface_names.e_refactoring_redo_sure, Void, agent manager.redo_last, Void)
		end

feature {NONE} -- Implementation

	manager: ERF_MANAGER
			-- Refactoring manager

invariant
	manager_not_void: manager /= Void

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


indexing
	description	: "[
			Simple toggle toolbarable command.
			When using it, do not forget to define all the standardized fields
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_STANDARD_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_TOGGLE_COMMAND
		redefine
			mini_pixmap,
			tooltext
		end

	EB_RECYCLABLE

create
	make

feature -- Initialization

	make is
			-- Initialize `Current'.
		do
			create execute_actions
			name := "Default_command_name_Please_change_it"
		end

feature -- Access

	is_selected: BOOLEAN is
			-- Is Selected ?
		do
			Result := is_selected_function /= Void and then is_selected_function.item (Void)
		end

	is_selected_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Is selected function ?

	execute_actions: ACTION_SEQUENCE [TUPLE]
			-- Agents that are called when `Current' is executed.

	pixmap: EV_PIXMAP
			-- Icon for tool bar button representing `Current'.

	pixel_buffer: EV_PIXEL_BUFFER
			-- Icon for tool bar button representing `Current'.

	mini_pixmap: EV_PIXMAP
			-- Icon for mini tool bar button representing `Current'.

	tooltip: STRING_GENERAL
			-- Help text displayed when associated buttons are focused.

	tooltext: STRING_GENERAL
			-- Text displayed on toolbar button.

	description: STRING_GENERAL
			-- Help text displayed in the customize tool bar dialog.

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.

	name: STRING
			-- Internal string identifier of `Current'.

feature -- Status setting

	set_is_selected_function (f: like is_selected_function) is
			-- Set `is_selected_function'
		do
			is_selected_function := f
		end

	set_pixmap (new_p: EV_PIXMAP) is
			-- Define pixmap associated with `Current'.
		require
			new_p_non_void: new_p /= Void
		do
			pixmap := new_p
		end

	set_pixel_buffer (a_buffer: EV_PIXEL_BUFFER) is
			-- Define pixel buffer associated with `Current'.
		require
			a_buffer_not_void: a_buffer /= Void
		do
			pixel_buffer := a_buffer
		end

	set_tooltip (s: like tooltip) is
			-- Define a new tooltip for `Current', and possibly a new description.
		do
			tooltip := s
			if description = Void then
				description := s
			end
		end

	set_tooltext (s: like tooltext) is
			-- Define a new tooltext for `Current' that is displayed
		do
			tooltext := s
		end

	set_description (s: like description) is
			-- Define a new description for `Current', and possibly a new tooltip.
		do
			description := s
			if tooltip = Void then
				tooltip := s
			end
		end

	set_accelerator (acc: EV_ACCELERATOR) is
			-- Define an accelerator for `Current'.
		do
			accelerator := acc
			if accelerator.actions.is_empty then
				accelerator.actions.extend (agent execute)
			end
		end

	set_menu_name (s: like menu_name) is
			-- Define a new menu name for `Current'.
		do
			menu_name := s
		end

	set_name (s: like name) is
			-- Define a new name for `Current'.
		do
			name := s
		end

	add_action (a: PROCEDURE [ANY, TUPLE]) is
			-- Extend `execute_actions' with `a'.
		do
			execute_actions.extend (a)
		end

	set_mini_pixmap (p: EV_PIXMAP) is
			-- Define the pixmap displayed on mini buttons associated to `Current'.
		do
			mini_pixmap := p
		end

feature -- Basic operations

	execute is
			-- Call all agents associated with `Current'.
		do
			execute_actions.call (Void)
			set_select (is_selected)

		end

feature {NONE} -- Recyclable

	internal_recycle is
			-- Recycle
		do
			execute_actions.wipe_out
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

end

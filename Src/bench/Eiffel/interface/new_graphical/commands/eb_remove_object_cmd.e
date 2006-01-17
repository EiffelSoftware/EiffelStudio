indexing
	description: "Command in the object tool to remove an object from it."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_REMOVE_OBJECT_CMD

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end

create
	make

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize `Current' and associate it with `tool'.
		do
			tool := a_tool
		end

feature -- Access

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version at least).
			-- Items at position 3 and 4 contain text.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := Pixmaps.Icon_delete_very_small
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_Remove_object
		end

feature -- Measurement

feature -- Status report

	tool: EB_OBJECT_TOOL
			-- Object tool `Current' is associated with.

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Remove_object
		end

	description: STRING is
			-- Description of the command.
		do
			Result := Interface_names.l_Remove_object_desc
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Execution

	execute is
			-- Remove an object from `tool'.
		local
			wd: EV_WARNING_DIALOG
		do
			if tool.is_selected_removable then
				tool.remove_object (tool.selected_object_address)
			else
				create wd.make_with_text (Warning_messages.w_Select_object_to_remove)
				wd.show_modal_to_window (tool.debugger_manager.debugging_window.window)
			end
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (agent drop_object_stone)
			Result.drop_actions.set_veto_pebble_function (agent is_removable (?))
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	drop_object_stone (st: OBJECT_STONE) is
			-- Remove the object represented by `st' from the object tool managed objects.
		do
			tool.remove_object (st.object_address)
		end

	is_removable (s: ANY): BOOLEAN is
			-- Can the object represented by `st' be removed from the object tool managed objects?
		local
			st: OBJECT_STONE
		do
			st ?= s
			if st /= Void then
				Result := tool.is_removable (st.object_address)
			end
		end

invariant
	invariant_clause: -- Your invariant here

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

end -- class EB_REMOVE_OBJECT_CMD

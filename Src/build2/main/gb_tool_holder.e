indexing
	description: "Objects that surround a tool with a title%
		%and minimize and maximize buttons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	
class
	GB_TOOL_HOLDER

inherit
	EV_FRAME
	
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
	
create
	make_with_tool
	
feature {NONE} -- Initialization

	make_with_tool (a_tool: EV_WIDGET; display_name: STRING) is
			-- Create `Current', and initalize with
			-- tool `a_tool'. Use `display_name' for title of `a_tool'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			frame: EV_FRAME
			tool_bar: EV_TOOL_BAR
			temp_cell: EV_CELL
		do
			default_create
			tool := a_tool
			tool.set_minimum_size (0, 0)
			set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create vertical_box
			extend (vertical_box)
			create horizontal_box
			create frame
			frame.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_raised)
			vertical_box.extend (frame)
			frame.extend (horizontal_box)
			create label.make_with_text (display_name)
			label.align_text_left
			horizontal_box.extend (label)
			horizontal_box.disable_item_expand (label)
			create temp_cell
			temp_cell.set_minimum_width (spacing_to_holder_tool_bar)
			horizontal_box.extend (temp_cell)
			horizontal_box.disable_item_expand (temp_cell)
			create tool_bar_cell
			horizontal_box.extend (tool_bar_cell)
			create tool_bar
			create minimize_button
			minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)
			minimize_button.select_actions.extend (agent minimize)
			minimize_button.set_tooltip (minimize_tooltip)
			tool_bar.extend (minimize_button)
			create maximize_button
			maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)
			maximize_button.select_actions.extend (agent maximize)
			maximize_button.set_tooltip (maximize_tooltip)
			tool_bar.extend (maximize_button)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			vertical_box.disable_item_expand (frame)
			vertical_box.extend (a_tool)
		end
		
feature -- Basic operation

	add_command_tool_bar (a_tool_bar: EV_TOOL_BAR) is
			-- Display `a_tool_bar' within header of `Current'.
		require
			tool_bar_not_void: a_tool_bar /= Void
		do
			command_tool_bar := a_tool_bar
			if tool_bar_cell.is_empty then
				tool_bar_cell.wipe_out
			end
			tool_bar_cell.extend (a_tool_bar)
		ensure
			command_tool_bar_set: command_tool_bar = a_tool_bar
		end

feature -- Access

	command_tool_bar: EV_TOOL_BAR
		-- A toolbar with specific commands related to `tool',
		-- or Void if not set.

	tool: EV_WIDGET
		-- Tool in `Current'.
		
	minimized: BOOLEAN
		-- Is `Current' minimized?
		
	maximized: BOOLEAN
		-- Is `Current' maximized?
		
	disable_minimized is
			-- Assign `False' to `is_minimized'.
		do
			minimized := False
		ensure
			not_minimized: not minimized
		end
		
	disable_maximized is
			-- Assign `False' to `is_maximized'.
		do
			maximized := False
		ensure
			not_maximized: not maximized
		end
		
	reset_minimize_button is
			-- Restore original pixmap to `minimize_button'.
		do
			minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)			
		end
		
	reset_maximize_button is
			-- Restore original pixmap to `maximize_button'.
		do
			maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)
		end
		

feature {NONE} -- Implementation

	tool_bar_cell: EV_CELL
		-- A cell to hold `command_tool_bar'.

	minimize is
			-- Minimize `Current' if not minimized, restore otherwise.
		do
			tool_holder_parent.minimize_tool (Current)
			minimized := not minimized
			if minimized then
				minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_restore @ 1)
				minimize_button.set_tooltip (restore_tooltip)
			else
				minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)	
				minimize_button.set_tooltip (minimize_tooltip)
			end
		end
		

	maximize is
			-- Maximize `Current' if not maxamized, restore otherwise.
		do
			tool_holder_parent.maximize_tool (Current)
			maximized := not maximized
			if maximized then
				maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_restore @ 1)	
				maximize_button.set_tooltip (restore_tooltip)
			else
				maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)	
				maximize_button.set_tooltip (maximize_tooltip)
			end
		end
		
	tool_holder_parent: GB_TOOL_HOLDER_PARENT is
			-- Parent of `Current'.
		require
			parent_not_void: parent /= Void
		do
			Result ?= parent
			if Result = Void then
				Result ?= parent.parent	
			end
			if Result = Void then
				Result ?= parent.parent.parent
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {GB_TOOL_HOLDER} -- Implementation

	maximize_button, minimize_button: EV_TOOL_BAR_BUTTON;
		-- Buttons representing minimize and maximize commands.

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


end -- class GB_TOOL_HOLDER

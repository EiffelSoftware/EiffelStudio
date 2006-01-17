indexing

	description:	
		"Command to cut a slice off of an array."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EB_SLICE_COMMAND 

inherit

	EB_TEXT_TOOL_CMD
--		export
--			{ANY} button_three_action
		redefine
			tool
		end

create

	make

feature -- Properties

	callback: ANY is
		once
			create Result
		end

	tool: EB_OBJECT_TOOL
			-- Tool of the inspected object

feature -- Bounds

	sp_lower: INTEGER is
			-- Lower bound for special object inspection
		do
			Result := tool.sp_lower
		end

	sp_upper: INTEGER is
			-- Upper bound for special object inspection
		do
			Result := tool.sp_upper
		end

	sp_capacity: INTEGER is
			-- Capacity of the last special object displayed in
			-- the object window
		do
			Result := tool.sp_capacity
		end

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			tool.set_sp_bounds (l, u)
		end

feature {EB_SLICE_DIALOG} -- Implementation

	execute (argument: ANY) is
			-- If left mouse button was pressed -> truncate special objects
			-- If right mouse button was pressed -> bring up slice window. 
		local
			current_format: EB_FORMATTER
			old_do_format: BOOLEAN
--			mp: MOUSE_PTR
			slice_window: EB_SLICE_DIALOG
				-- Associated popup window
		do
--			create mp.set_watch_cursor
			if argument = Void then
				create slice_window.make_default (Current)
			else
				current_format := tool.last_format
				if tool.format_is_show_attibutes then
					old_do_format := current_format.do_format
					current_format.set_do_format (true)
					current_format.format
					current_format.set_do_format (old_do_format)
				end
			end
--			mp.restore
		end
	
feature {NONE} -- Attributes

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Slice 
--		end
 
--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Slice
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Slice
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

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

end -- class EB_SLICE_COMMAND

indexing

	description:	
		"Command to cut a slice off of an array."
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

creation

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

end -- class EB_SLICE_COMMAND

indexing

	description:	
		"Command to cut a slice off of an array.";
	date: "$Date$";
	revision: "$Revision$"

class SLICE_COMMAND 

inherit

	PIXMAP_COMMAND
		export
			{ANY} button_three_action
		redefine
			tool
		end;

create

	make

feature -- Initialization

	make (a_tool: OBJECT_W) is
			-- Initialize the command, add a button click action and create
			-- the slice window.
		do
			init (a_tool);
		end;

feature -- Properties

	slice_window: SLICE_W;
			-- Associated popup window

	tool: OBJECT_W;
			-- Tool of the inspected object

feature -- Bounds

	sp_lower: INTEGER is
			-- Lower bound for special object inspection
		do
			Result := tool.sp_lower
		end;

	sp_upper: INTEGER is
			-- Upper bound for special object inspection
		do
			Result := tool.sp_upper
		end;

	sp_capacity: INTEGER is
			-- Capacity of the last special object displayed in
			-- the object window
		do
			Result := tool.sp_capacity
		end;

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			tool.set_sp_bounds (l, u)
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- If left mouse button was pressed -> truncate special objects
			-- If right mouse button was pressed -> bring up slice window. 
		local
			current_format: FORMATTER;
			old_do_format: BOOLEAN;
			mp: MOUSE_PTR
		do
			create mp.set_watch_cursor;
			if argument = button_three_action then
					-- 3rd button pressed
				if slice_window = Void then
					create slice_window.make (popup_parent, Current);
				end;
				slice_window.call 
			elseif slice_window /= Void and then argument = slice_window then
				current_format := tool.last_format.associated_command;
				if current_format = tool.showattr_frmt_holder.associated_command then
					old_do_format := current_format.do_format;
					current_format.set_do_format (true);
					current_format.execute (tool.stone);
					current_format.set_do_format (old_do_format)
				end
			end;
			mp.restore
		end;
	
feature {NONE} -- Attributes

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Slice 
		end;
 
	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Slice
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Slice
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

end -- class SLICE_COMMAND

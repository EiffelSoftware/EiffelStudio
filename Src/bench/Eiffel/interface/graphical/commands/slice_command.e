class SLICE_COMMAND 

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;

creation

	make
	
feature 

	slice_window: SLICE_W;
			-- Associated popup window

	text_window: OBJECT_TEXT;

	make (c: COMPOSITE; a_text_window: OBJECT_TEXT) is
		do
			!!slice_window.make (c, Current);
			init (c, a_text_window);
			add_button_click_action (3, Current, Void)
		end;

feature -- Bounds

	sp_lower: INTEGER is
			-- Lower bound for special object inspection
		do
			Result := text_window.sp_lower
		end;

	sp_upper: INTEGER is
			-- Upper bound for special object inspection
		do
			Result := text_window.sp_upper
		end;

	sp_capacity: INTEGER is
			-- Capacity of the last special object displayed in
			-- the object window
		do
			Result := text_window.sp_capacity
		end;

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			text_window.set_sp_bounds (l, u)
		end;

feature {NONE}

	work (argument: ANY) is
			-- If left mouse button was pressed -> truncate special objects
			-- If right mouse button was pressed -> bring up slice window. 
		local
			current_format: FORMATTER;
			old_do_format: BOOLEAN
		do
			set_global_cursor (watch_cursor);
			if argument = Void then
					-- 3rd button pressed
				slice_window.call 
			elseif argument = slice_window then
				current_format := text_window.last_format;
				if current_format = text_window.tool.showattr_command then
					old_do_format := current_format.do_format;
					current_format.set_do_format (true);
					current_format.execute (text_window.root_stone);
					current_format.set_do_format (old_do_format)
				end
			end;
			restore_cursors
		end;
	
feature {NONE}

	symbol: PIXMAP is 
		once 
			Result := bm_Slice 
		end;
 
	command_name: STRING is do Result := l_Slice end;

end -- class SLICE_COMMAND

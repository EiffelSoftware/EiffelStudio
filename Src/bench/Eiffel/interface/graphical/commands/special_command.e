class SPECIAL_COMMAND 

inherit

	ICONED_COMMAND

creation

	make
	
feature 

	special_w: SPECIAL_W;

	make (c: COMPOSITE; t_w: TEXT_WINDOW) is
		do
--			init (c, t_w);
--			!!special_w.make (c);
			pict_create (new_name, c);
			set_symbol (symbol);
			!!get_in; !!get_out;
			add_enter_action (Current, get_in);
			add_leave_action (Current, get_out);
--			add_button_press_action (1, Current, t_w);
			text_window := t_w
		end;

feature {NONE}

	work (argument: ANY) is
		do
--			special_w.call
		end;
	
feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Default 
		end;
 
	command_name: STRING is do Result := "ISE Eiffel3" end;

end

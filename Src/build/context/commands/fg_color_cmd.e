
class FG_COLOR_CMD 

inherit

	CONTEXT_CMD
		;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			F_g_color_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := color_form_number
		end;

	old_fg_color: STRING;

	pixel_value: POINTER;

	context_work is
		
		do
			old_fg_color := context.fg_color_name;
			if (old_fg_color = Void) then 
				pixel_value := fg_color_cmd_c_efb_get_foreground (context.widget.implementation.screen_object);
			end;
		end;

	context_undo is
		
		local
			new_fg_color: STRING;
		do
			new_fg_color := context.fg_color_name;
			context.set_fg_color_name (old_fg_color);
			if old_fg_color = Void then
				fg_color_cmd_c_efb_set_foreground (context.widget.implementation.screen_object, pixel_value)
			end;
			old_fg_color := new_fg_color;
		end;

feature {NONE} -- External features

	fg_color_cmd_c_efb_get_foreground (a_w: POINTER): POINTER is
		external
			"C"
		alias
			"c_efb_get_foreground"
		end; -- fg_color_cmd_c_efb_get_foreground

	fg_color_cmd_c_efb_set_foreground (a_w, a_p: POINTER) is
		external
			"C"
		alias
			"c_efb_set_foreground"
		end; -- fg_color_cmd_c_efb_set_foreground

end

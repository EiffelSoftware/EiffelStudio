
class BG_COLOR_CMD 

inherit

	CONTEXT_CMD
		;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			B_g_color_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := color_form_number
		end;

	old_bg_color_name: STRING;

	pixel_value: POINTER;

	context_work is
		
		do
			old_bg_color_name := context.bg_color_name;
			if old_bg_color_name = Void then
				pixel_value := bg_color_cmd_c_efb_get_background (context.widget.implementation.screen_object);
			end;
		end;

	context_undo is
		
		local
			new_color: STRING;
		do
			new_color := context.bg_color_name;
			context.set_bg_color_name (old_bg_color_name);
			if old_bg_color_name = Void then
				bg_color_cmd_c_efb_set_background (context.widget.implementation.screen_object, pixel_value)
			end;
			old_bg_color_name := new_color;
		end;

feature {NONE} -- External features

	bg_color_cmd_c_efb_get_background (a_w: POINTER): POINTER is
		external
			"C"
		alias
			"c_efb_get_background"
		end; -- bg_color_cmd_c_efb_get_background

	bg_color_cmd_c_efb_set_background (a_w, a_p: POINTER) is
		external
			"C"
		alias
			"c_efb_set_background"
		end; -- bg_color_cmd_c_efb_set_background

end

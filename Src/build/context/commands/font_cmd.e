
class FONT_CMD 

inherit

	CONTEXT_CMD
		;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			F_ont_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := font_form_number
		end;

	old_font_name: STRING;

	font_list: POINTER;

	context_work is
		
		do
			old_font_name := context.font_name;
			if (old_font_name = Void) then 
				font_list := c_efb_get_font_list (context.widget.implementation.screen_object);
				!!old_font_name.make (0);
			end;
		end;

	context_undo is
		
		local
			new_font_name: STRING;
		do
			new_font_name := context.font_name;
			context.set_font_named (old_font_name);
			if old_font_name.empty then
				c_efb_set_font_list (context.widget.implementation.screen_object, font_list)
			end;
			old_font_name := new_font_name;
		end;

feature {NONE} -- External features

	c_efb_get_font_list (a_w: POINTER): POINTER is
		external
			"C"
		end; 

	c_efb_set_font_list (a_w, a_f: POINTER) is
		external
			"C"
		end;

end

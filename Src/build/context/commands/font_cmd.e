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

	old_font: FONT

	font_list: POINTER;

	context_work is
		do
			old_font_name := context.font_name
			if (old_font_name = Void) then
				old_font := context.font
				!!old_font_name.make (0)
			end
		end

	context_undo is
		local 
			new_font_name: STRING
		do
			new_font_name := context.font_name
			context.set_font_named (old_font_name)
			if old_font_name.empty then
				context.set_font_named (old_font.name)
			end
			old_font_name := new_font_name
		end

end

class FONT_CMD 

inherit

	CONTEXT_CMD
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.font_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_font_cmd_name
		end;

	old_font_name: STRING;

	old_font: FONT

	context_work is
		do
			old_font_name := context.font_name;
			if (old_font_name = Void) then
				old_font := context.font
			end
		end

	context_undo is
		local 
			new_font_name: STRING;
			fontable: FONTABLE;
		do
			new_font_name := context.font_name;
			if old_font_name = Void then
				fontable ?= context.widget;
				context.widget.unmanage;
				fontable.set_font (old_font)
				context.widget.manage;
			end;
			context.set_font_named (old_font_name);
			old_font_name := new_font_name;
		end

end

class FG_COLOR_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end

	EDITOR_FORMS
		export
			{NONE} all
		end

	COMMAND_NAMES
		rename
			F_g_color_cmd_name as c_name
		export
			{NONE} all
		end

feature {NONE}

	context: PRIMITIVE_C

	associated_form: INTEGER is
		do
			Result := color_form_number
		end;

	old_fg_color: STRING;

	old_color: COLOR

	pixel_value: POINTER;

	context_work is
		do
			old_fg_color := context.fg_color_name
			if (old_fg_color = Void) then
				old_color := context.widget.foreground_color
			end
		end

	context_undo is
		local
			new_fg_color: STRING
		do
			new_fg_color := context.fg_color_name
			context.set_fg_color_name (old_fg_color)
			if old_fg_color = Void then
				context.widget.set_foreground_color (old_color)
			end
			old_fg_color := new_fg_color
		end

end


class FG_COLOR_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end

feature {NONE}

	context: PRIMITIVE_C

	associated_form: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_fg_color_cmd_name
		end;

	old_fg_color_name: STRING;

	default_color: COLOR

	context_work is
		do
			old_fg_color_name := context.fg_color_name
			if (old_fg_color_name = Void) then
				default_color := context.default_foreground_color
			end
		end

	context_undo is
		local
			new_fg_color: STRING
		do
			new_fg_color := context.fg_color_name
			context.set_fg_color_name (old_fg_color_name)
			if old_fg_color_name = Void then
				context.set_default_foreground_color (default_color)
			end
			old_fg_color_name := new_fg_color
		end

end


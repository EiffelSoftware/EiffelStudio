class BG_COLOR_CMD 

inherit

	CONTEXT_CMD

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.bg_color_cmd_name
		end;

	old_bg_color_name: STRING

	pixel_value: POINTER

	old_color: COLOR

	context_work is
		do
			old_bg_color_name := context.bg_color_name
			if old_bg_color_name = Void then
				old_color := context.widget.background_color
			end
		end

	context_undo is
		local
			new_color: STRING
		do
			new_color := context.bg_color_name
			context.set_bg_color_name (old_bg_color_name)
			if old_bg_color_name = Void then
				context.widget.set_background_color (old_color)
			end
			old_bg_color_name := new_color
		end

end

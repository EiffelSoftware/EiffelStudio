class BG_PIXMAP_CMD 

inherit

	CONTEXT_CMD

	EDITOR_FORMS
		export
			{NONE} all
		end

	COMMAND_NAMES
		rename
			B_g_pixmap_cmd_name as c_name
		export
			{NONE} all
		end

feature {NONE}

	associated_form: INTEGER is
		do
			Result := color_form_number
		end;

	old_bg_pixmap_name: STRING;

	pixmap_value: POINTER;

	old_pixmap: PIXMAP

	context_work is
		do
			old_bg_pixmap_name := context.bg_pixmap_name
			if old_bg_pixmap_name = Void then
				old_pixmap := context.widget.background_pixmap
			end
		end

	context_undo is
		local
			new_pixmap: STRING
		do
			new_pixmap := context.bg_pixmap_name	
			context.set_bg_pixmap_name (old_bg_pixmap_name)
			if old_bg_pixmap_name = Void then
				context.widget.set_background_pixmap (old_pixmap)
			end
			old_bg_pixmap_name := new_pixmap
		end

end

class BG_PIXMAP_CMD 

inherit

	CONTEXT_CMD

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.color_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.bg_pixmap_cmd_name
		end;

	old_bg_pixmap_name: STRING;

	context_work is
		do
			old_bg_pixmap_name := context.bg_pixmap_name
		end

	context_undo is
		local
			new_pixmap: STRING
		do
			new_pixmap := context.bg_pixmap_name	
			context.set_bg_pixmap_name (old_bg_pixmap_name)
			old_bg_pixmap_name := new_pixmap
		end

end

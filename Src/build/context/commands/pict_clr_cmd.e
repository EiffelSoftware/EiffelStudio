class PICT_CLR_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.pict_color_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.pict_clr_cmd_name
		end;

	context: PICT_COLOR_C;

	old_pixmap_name: STRING;

	pixmap_value: POINTER;

	old_width, old_height: INTEGER;

	context_work is
		do
			old_pixmap_name := context.pixmap_name;
			old_width := context.width;
			old_height := context.height;
		end

	context_undo is
		local 
			new_name: STRING;
			new_w, new_h: INTEGER
		do
			new_name := context.pixmap_name
			new_w := context.width;
			new_h := context.height;
			context.set_pixmap_name (old_pixmap_name)
			context.set_size (old_width, old_height);
			old_width := new_w;
			old_height := new_h;
			old_pixmap_name := new_name
		end

end

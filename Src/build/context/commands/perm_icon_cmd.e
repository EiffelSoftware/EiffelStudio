class PERM_ICON_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.perm_wind_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.perm_icon_cmd_name
		end;

	context: PERM_WIND_C;

	old_pixmap_name: STRING;

	pixmap_value: POINTER;

	old_pixmap: PIXMAP

	context_work is
		do
			old_pixmap_name := context.icon_pixmap_name
			if old_pixmap_name = Void then
				old_pixmap := context.widget.icon_pixmap
			end
		end

	context_undo is
		local
			new_name: STRING
		do
			new_name := context.icon_pixmap_name
			if old_pixmap_name /= Void then
				context.set_icon_pixmap (old_pixmap_name)
			else
				context.set_icon_pixmap (old_pixmap_name)
			end
			old_pixmap_name := new_name
		end

	MiconPixmap: STRING is "iconPixmap";

end -- class PERM_ICON_CMD

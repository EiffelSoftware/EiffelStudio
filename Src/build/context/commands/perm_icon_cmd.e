
class PERM_ICON_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			P_erm_icon_cmd_name as c_name
		export
			{NONE} all
		end
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := perm_wind_form_number
		end;

	context: PERM_WIND_C;

	old_pixmap_name: STRING;

	pixmap_value: POINTER;

	context_work is
		local
			ext_name: ANY;
		do
			old_pixmap_name := context.icon_pixmap_name;
			if old_pixmap_name = Void then
				ext_name := MiconPixmap.to_c;
				pixmap_value := get_pixmap (context.widget.implementation.screen_object, $ext_name);
			end
		end;

	MiconPixmap: STRING is "iconPixmap";

	context_undo is
		local
			new_name: STRING;
			ext_name: ANY;
		do
			new_name := context.icon_pixmap_name; 
			if old_pixmap_name /= Void then
				context.set_icon_pixmap (old_pixmap_name);
			else
				ext_name := MiconPixmap.to_c;
				c_set_pixmap (context.widget.implementation.screen_object, pixmap_value, $ext_name);
			end;
			old_pixmap_name := new_name;
		end;

feature {NONE} -- Externals

	get_pixmap (w: POINTER; res: ANY): POINTER is
		external
			"C"
		end;

	c_set_pixmap (w, pix: POINTER; res: ANY) is
		external
			"C"
		end
	

end


class BG_PIXMAP_STONE 

inherit

	ATTRIB_STONE

creation
    make

feature {NONE}

	create_focus_label is
		do
			set_focus_string (Focus_labels.bg_pixmap_att_label)
		end;

	command: BG_P_STONE_CMD is
		once
			!!Result
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.bg_pixmap_stone_pixmap
		end;

feature 

	eiffel_type: STRING is
		do
			!!Result.make (0);
			Result.append ("pixmap");
		end;

	copy_attribute (new_context: CONTEXT) is
		local
			pixmap_name: STRING;
			cmd: ATTRIB_CMD;
		do
			pixmap_name := editor.edited_context.bg_pixmap_name;
			if not (pixmap_name = Void) and then not pixmap_name.empty then
				!!cmd.make (command);
				cmd.execute (new_context);
				modify_contexts (new_context);
			end;
		end;
	
feature {NONE}

	modify_context (new_context: CONTEXT) is
		local
			pixmap_name: STRING;
		do
			pixmap_name := editor.edited_context.bg_pixmap_name;
			new_context.set_bg_pixmap_name (pixmap_name);
			context_catalog.update_editors (new_context, Context_const.color_form_nbr);
		end;

end


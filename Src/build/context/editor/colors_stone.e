
class COLORS_STONE 

inherit

	ATTRIB_STONE

creation
	make

feature {NONE}

	create_focus_label is
		do
			set_focus_string (Focus_labels.colors_att_label)
		end;

	command: CLR_STONE_CMD is
		once
			!!Result
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.color_stone_pixmap
		end;
	
feature 

	eiffel_type: STRING is
		do
			!!Result.make (0);
			Result.append ("color");
		end;


	copy_attribute (new_context: CONTEXT) is
		local
			bg_color_name: STRING;
			fg_color_name: STRING;
			cmd: ATTRIB_CMD;
		do
			bg_color_name := editor.edited_context.bg_color_name;
			fg_color_name := editor.edited_context.fg_color_name;
			if (not (bg_color_name = Void) and then not bg_color_name.empty) or else
				(not (fg_color_name = Void) and then not fg_color_name.empty) then
				!!cmd.make (command);
				cmd.execute (new_context);
				modify_contexts (new_context);
			end;
		end;

feature {NONE}

	modify_context (new_context: CONTEXT) is
		local
			bg_color_name: STRING;
			fg_color_name: STRING;
		do
			bg_color_name := editor.edited_context.bg_color_name;
			if (not (bg_color_name = Void) and then not bg_color_name.empty) then
				new_context.set_bg_color_name (bg_color_name);
			end;
			fg_color_name := editor.edited_context.fg_color_name;
			if (not (fg_color_name = Void) and then not fg_color_name.empty) then
				new_context.set_fg_color_name (fg_color_name);
			end;
			context_catalog.update_editors (new_context, Context_const.color_form_nbr);
		end;

end


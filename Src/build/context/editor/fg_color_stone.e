
class FG_COLOR_STONE 

inherit

	ATTRIB_STONE
	
feature {NONE}

	command: FG_STONE_CMD is
		once
			!!Result
		end;

	pixmap: PIXMAP is
		do
			Result := Pixmaps.fg_color_stone_pixmap
		end;
	
feature 

	eiffel_type: STRING is
		do
			!!Result.make (0);
			Result.append ("color");
		end;

	copy_attribute (new_context: CONTEXT) is
		local
			color_name: STRING;
			cmd: ATTRIB_CMD;
		do
			color_name := editor.edited_context.fg_color_name;
			if not (color_name = Void) and then not color_name.empty then
				!!cmd.make (command);
				cmd.execute (new_context);
				modify_contexts (new_context);
			end;
		end;

	
feature {NONE}

	modify_context (new_context: CONTEXT) is
		local
			color_name: STRING;
		do
			color_name := editor.edited_context.fg_color_name;
			new_context.set_fg_color_name (color_name);
			context_catalog.update_editors (new_context, Context_const.color_form_nbr);
		end;

end


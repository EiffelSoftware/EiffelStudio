
class BG_COLOR_STONE 

inherit

	ATTRIB_STONE
	
feature {NONE}

	command: BG_STONE_CMD is
		once
			!!Result
		end;

	pixmap: PIXMAP is
		do
			Result := Bg_color_stone_pixmap
		end;

feature 

	copy_attribute (new_context: CONTEXT) is
		local
			color_name: STRING;
			cmd: ATTRIB_CMD;
		do
			color_name := editor.edited_context.bg_color_name;
			if not (color_name = Void) and then not color_name.empty then
				!!cmd.make (command);
				cmd.execute (new_context);
				modify_contexts (new_context);
			end;
		end;

	
feature {NONE}

	modify_context (new_context: CONTEXT) is
		local
			color_name: STRING
		do
			color_name := editor.edited_context.bg_color_name;
			new_context.set_bg_color_name (color_name);
			context_catalog.update_editors (new_context, color_form_number);
		end;
end


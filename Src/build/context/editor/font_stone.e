
class FONT_STONE 

inherit

	ATTRIB_STONE

creation

	make

feature {NONE}

	create_focus_label is
		do
			set_focus_string (Focus_labels.font_att_label)
		end;

	command: FONT_STONE_CMD is
		once
			!!Result
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.font_pixmap
		end;

feature 

	eiffel_type: STRING is
		do
			!!Result.make (0);
			Result.append ("font");
		end;


	copy_attribute (new_context: CONTEXT) is
		local
			font_name: STRING;
			cmd: ATTRIB_CMD;
		do
			font_name := editor.edited_context.font_name;
			if not (font_name = Void) and then not font_name.empty then
				!!cmd.make (command);
				cmd.execute (new_context);
				modify_contexts (new_context);
			end;
		end;

	
feature {NONE}

	modify_context (new_context: CONTEXT) is
		local
			font_name: STRING;
		do
			font_name := editor.edited_context.font_name;
			new_context.set_font_named (font_name);
			context_catalog.update_editors (new_context, Context_const.font_form_nbr);
		end;

end


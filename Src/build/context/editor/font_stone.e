
class FONT_STONE 

inherit

	ATTRIB_STONE

feature {NONE}

	command: FONT_STONE_CMD is
		once
			!!Result
		end;

	pixmap: PIXMAP is
		do
			Result := Font_pixmap
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
				io.putstring ("copying font%N");
			if not (font_name = Void) and then not font_name.empty then
				io.putstring ("context is ");
				io.putstring (new_context.label);
				io.new_line;
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
			context_catalog.update_editors (new_context, font_form_number);
		end;

end


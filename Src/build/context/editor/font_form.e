
class FONT_FORM 

inherit

	CONTEXT_CMDS
		rename
			font_cmd as command
		export
			{NONE} all
		end;
	EDITOR_OK_FORM
		redefine
			form_name
		
		end;
	PIXMAPS
		export
			{NONE} all
		end


creation

	make

	
feature 

	form_name: STRING is
			-- Name of the form in the menu
		do
			Result := F_ont_form_name;
		end;

	
feature {NONE}

	font_b: FONT_BOX;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, font_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			font_stone: FONT_STONE;
		do
			initialize (F_ont_form_name, a_parent);
			create_ok_button;
			!!font_b.make (F_ont_box, Current);
			font_b.hide_ok_button;
			font_b.hide_cancel_button;
			font_b.hide_apply_button;

			!!font_stone;
			font_stone.make (Current, a_parent);
			attach_left (font_b, 1);
			attach_right (font_b, 1);
			attach_top (font_b, 1);
			attach_bottom_widget (separator, font_b, 1);

			attach_right (font_stone, 20);
			attach_bottom (font_stone, 10);
			attach_bottom_widget (font_stone, separator, 5);
			detach_top (font_stone);
			detach_top (separator);
			detach_left (font_stone);
		end;

	
feature {NONE}

	reset is
		local
			font: FONT;
		do
			font := context.font;
			if not (font = Void) then
				font_b.set_font (font);
			end;
		end;

	
feature 

	apply is
		do
			context.set_font_named (font_b.font.n_ame);
		end;

end

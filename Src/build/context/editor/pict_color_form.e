
class PICT_COLOR_FORM 

inherit

	COMMAND
		export
			{NONE} all
		end;
	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			context
		end


creation

	make

	
feature {NONE}

	pixmap_name: EB_TEXT_FIELD;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, pict_color_form_number);
		end;

	
feature {NONE}

	pixmap_selection_box: PIXMAP_FILE_BOX;

	
feature 

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			label: LABEL_G;
			pixmap_open_b: PUSH_BG;
			Nothing: ANY
		do
			initialize (Pict_color_form_name, a_parent);
			!!label.make (P_ixmap_name, Current);
			!!pixmap_name.make (T_extfield, Current, pict_clr_cmd, a_parent);
			!!pixmap_open_b.make (P_Cbutton, Current);
			attach_top (label, 10);
			attach_left (label, 10);
			attach_left (pixmap_name, 10);
			attach_top_widget (label, pixmap_name, 10);
			attach_left (pixmap_open_b, 10);
			attach_top_widget (pixmap_name, pixmap_open_b, 5);

			pixmap_open_b.add_activate_action (Current, Nothing);
			pixmap_open_b.set_text ("open pixmap");
		end;

	
feature {NONE}

	context: PICT_COLOR_C;

	execute (argument: ANY) is
		do
			if (pixmap_selection_box = Void) then
				!!pixmap_selection_box.make 
					(pixmap_name, Current, pict_clr_cmd, editor);
			end;
			pixmap_selection_box.popup
		end;

	reset is
		do
			if not (context.pixmap_name = Void) then
				pixmap_name.set_text (context.pixmap_name);
			else
				pixmap_name.set_text ("");
			end;
		end;

	
feature 

	apply is
		do
			context.set_pixmap_name (pixmap_name.text)
		end;

end


deferred class PULLDOWN_C 

inherit

	MENU_C
		rename
			cut as old_cut,
			undo_cut as old_undo_cut,
			copy_attributes as menu_copy_attributes,
			reset_modified_flags as menu_reset_modified_flags,
			context_initialization as old_context_initialization
		redefine
			set_visual_name, widget, 
			retrieve_set_visual_name 
		end;

	MENU_C
		redefine
			set_visual_name, context_initialization, copy_attributes, 
			undo_cut, cut, widget, reset_modified_flags,
			retrieve_set_visual_name
		select
			cut, undo_cut, copy_attributes, context_initialization, 
			reset_modified_flags
		end;
	
feature

	widget: PULLDOWN;

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void;
				text_modified := False;
				update_tree_element
			else
				set_text (s)
			end;
		end;

	retrieve_set_visual_name (s: STRING) is
		do
			text_modified := True;
			widget.set_text (s);
			visual_name := clone (s);
		end;

	set_text (a_string: STRING) is
		do
			retrieve_set_visual_name (a_string);
			update_tree_element
		end;

	text: STRING is
		do
			Result := widget.text
		end;

	text_modified: BOOLEAN;


	reset_modified_flags is
		do
			menu_reset_modified_flags;
			text_modified := False;
		end;

feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if text_modified then
				other_context.set_text (text);
			end;
			menu_copy_attributes (other_context);
		end;

feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if text_modified then
				function_string_to_string (Result, context_name, "set_text", text)
			end;
			Result.append (old_context_initialization (context_name));
		end;

	
feature 

	cut is
		do
			old_cut;
			widget.button.set_managed (False);
		end;

	undo_cut is
		do
			old_undo_cut;
			widget.button.set_managed (True);
		end;

	forbid_recompute_size is
		deferred
		end;


	allow_recompute_size is
		deferred
		end;


	widget_set_center_alignment is
		deferred
		end;

	widget_set_left_alignment is
		deferred
		end;

	resize_policy_disabled: BOOLEAN;

	resize_policy_disabled_modified: BOOLEAN;

	disable_resize_policy (flag: BOOLEAN) is
		do
			resize_policy_disabled_modified := True;
			resize_policy_disabled := flag;
			if flag then
				forbid_recompute_size;
					-- the current size must be saved
				size_modified := True;
			else
				allow_recompute_size
			end;
		end;

	left_alignment: BOOLEAN;

	left_alignment_modified: BOOLEAN;

	set_left_alignment (flag: BOOLEAN) is
		do
			left_alignment_modified := True;
			left_alignment := flag;
			if flag then
				widget_set_left_alignment
			else
				widget_set_center_alignment
			end
		end;

end


deferred class LABEL_TEXT_C 

inherit

	PRIMITIVE_C
		rename
			option_list as old_list,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			is_fontable, context_initialization, 
			set_visual_name
		end;

	PRIMITIVE_C
		redefine
			reset_modified_flags, copy_attributes, 
			option_list,
			is_fontable, context_initialization, 
			set_visual_name 
		select
			option_list, copy_attributes, reset_modified_flags
		end

feature {NONE}

	reset_modified_flags is
		do
			old_reset_modified_flags;
			text_modified := False;
			resize_policy_disabled_modified := False;
			left_alignment_modified := False;
		end;
	
	copy_attributes (other_context: like Current) is
		do
			if text_modified then
				other_context.set_text (text)
			end;
			if left_alignment_modified then
				other_context.set_left_alignment (left_alignment);
			end;
			if resize_policy_disabled_modified then
				other_context.disable_resize_policy (resize_policy_disabled);
			end;
			old_copy_attributes (other_context);
		end;

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := True
		end;
 
	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (label_text_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

feature

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

	text: STRING is
		deferred
		end;

	text_modified: BOOLEAN;

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void;
				text_modified := False;
				widget_set_text (label);
				update_tree_element
			else
				set_text (s)
			end;
		end;

	set_text (s: STRING) is
		do
			text_modified := True;
			visual_name := clone (s);
			widget_set_text (label);
			update_tree_element
		end

feature {NONE}

	forbid_recompute_size is
		deferred
		end;
 
	allow_recompute_size is
		deferred
		end;
 
	widget_set_text (a_string: STRING) is
		deferred
		end;

	widget_set_center_alignment is
		deferred
        end;
 
    widget_set_left_alignment is
		deferred
        end;

feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if text_modified then
				function_string_to_string (Result, context_name, "set_text", text);
			end;
			if left_alignment_modified then
				cond_f_to_string (Result, left_alignment, context_name, "set_center_alignment", "set_left_alignment");
			end;
			if resize_policy_disabled_modified then
				cond_f_to_string (Result, resize_policy_disabled, context_name, "forbid_recompute_size", "allow_recompute_size");
			end;
		end;

end

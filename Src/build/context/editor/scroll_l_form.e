
class SCROLL_L_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end;
	EDITOR_FORM
		redefine
			context
		end;
	SCROLL_L_CONST


creation

	make

	
feature {NONE}

	visible_item_count: INTEGER_TEXT_FIELD;
	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, scroll_l_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			visible_label: LABEL_G;
		do
			initialize (Scroll_list_form_name, a_parent);

			!!visible_label.make (V_isible_items, Current);
			!!visible_item_count.make (T_extfield, Current, list_count_cmd, a_parent);
			visible_item_count.set_width (50);

			attach_left (visible_label, 10);
			attach_left (visible_item_count, 150);
			attach_right (visible_item_count, 10);

			attach_top (visible_label, 10);
			attach_top (visible_item_count, 10);
		end;

feature {NONE}

	context: SCROLL_LIST_C;

	reset is
		do
			visible_item_count.set_int_value (context.visible_item_count);
		end;

feature 

	apply is
		do
			if not visible_item_count.same_value (context.visible_item_count) then
				context.set_visible_item_count (visible_item_count.int_value);
			end;
		end;

end

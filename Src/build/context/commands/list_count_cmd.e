
class LIST_COUNT_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		end;
	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.scroll_l_att_form_nbr
		end;

	c_name: STRING is
		do
			Result := Context_const.list_count_cmd_name
		end;

	context: SCROLL_LIST_C;

	old_visible_item_count: INTEGER;

	context_work is
		do
			old_visible_item_count := context.visible_item_count;
		end;

	context_undo is
		local
			new_count: INTEGER;
		do	
			new_count := context.visible_item_count;
			context.set_visible_item_count (old_visible_item_count);
			old_visible_item_count := new_count;
		end;

end


class LIST_COUNT_CMD 

inherit

	CONTEXT_CMD
		redefine
			context
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			l_ist_count_cmd_name as c_name
		export
			{NONE} all
		end



	
feature {NONE}

	associated_form: INTEGER is
		do
			Result := scroll_l_form_number
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

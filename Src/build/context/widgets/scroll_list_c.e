

class SCROLL_LIST_C 

inherit

	PIXMAPS
		rename
			Scroll_list_pixmap as symbol
		export
			{NONE} all
		end;

	PRIMITIVE_C
		rename
			option_list as old_list,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, context_initialization, is_fontable,
			widget
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, copy_attributes, 
			context_initialization, is_fontable, option_list, widget
		select
			option_list, copy_attributes, reset_modified_flags
		end;

	SCROLL_L_CONST



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.scroll_page.scroll_list_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
			i: INTEGER;
			text: STRING;
		do
			!!widget.make (entity_name, a_parent);
			set_size (100, 100);
			widget.set_visible_item_count (3);
			from
				i := 1;
			until
				i > 5
			loop
				!!text.make (0);
				text.append ("Item");
				text.append (to_string (i));
				widget.put_right (text);
				i := i + 1;
				widget.forth;
			end;
		end;

	widget: SCROLL_LIST;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Scroll_list");
		end;

	
feature 

	eiffel_type: STRING is "SCROLL_LIST";

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (scroll_l_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

	-- ***********************
	-- * Specific attributes *
	-- ***********************

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := true
		end;

	visible_item_count: INTEGER is
			-- Number of visible item of list
		do
			Result := widget.visible_item_count
		end;

	count_modified: BOOLEAN;

	set_visible_item_count (a_count: INTEGER) is
			-- Set the number of visible items to `a_count'.
		do
			count_modified := True;
			widget.set_visible_item_count (a_count)
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			count_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if count_modified then
				other_context.set_visible_item_count (visible_item_count);
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		local
			func_name: STRING;
		do
			!!Result.make (0);
			if count_modified then
				function_int_to_string (Result, context_name, "set_visible_item_count", visible_item_count)
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_SCROLL_LIST is
		do
			!!Result.make (Current);
		end;

end



class TEXT_FIELD_C 

inherit

	PIXMAPS
		rename
			Text_field_pixmap as symbol
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
			stored_node, option_list, reset_modified_flags, 
			copy_attributes, context_initialization, is_fontable, widget
		select
			option_list, copy_attributes, reset_modified_flags
		end
	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_field_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: TEXT_FIELD;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Text_field");
		end;
	
feature 

	eiffel_type: STRING is "TEXT_FIELD";

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (text_field_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

	-- ***********************
	-- * specific attributes *
	-- ***********************

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := true
		end;

	maximum_size: INTEGER is
			-- Maximum number of characters in current text
		do
			Result := widget.maximum_size
		end;

	max_size_modified: BOOLEAN;

	set_maximum_size (new_size: INTEGER) is
			-- Set maximum_size to `new_size'.
		do
			max_size_modified := True;
			widget.set_maximum_size (new_size);
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			max_size_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if max_size_modified then
				other_context.set_maximum_size (maximum_size);
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if max_size_modified then
				function_int_to_string (Result, context_name, "set_maximum_size", maximum_size)
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_TEXT_FIELD is
		do
			!!Result.make (Current);
		end;

end

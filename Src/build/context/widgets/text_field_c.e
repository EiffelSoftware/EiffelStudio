

class TEXT_FIELD_C 

inherit

	PRIMITIVE_C
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			stored_node, context_initialization, is_fontable,
			widget		
		end;

	PRIMITIVE_C
		redefine
			stored_node, reset_modified_flags, 
			copy_attributes, context_initialization, is_fontable, widget
		select
			copy_attributes, reset_modified_flags
		end
	
feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.text_field_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.text_field_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
		end;

	widget: TEXT_FIELD


feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Text_field");
		end;
	
	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.text_field_att_form_nbr,
					Context_const.Attribute_format_nbr);
		end;

feature 

	eiffel_type: STRING is "TEXT_FIELD";

	full_type_name: STRING is "Text field"

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

feature -- Storage node

	stored_node: S_TEXT_FIELD is
		do
			!!Result.make (Current);
		end;

end

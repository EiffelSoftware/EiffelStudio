indexing
	description: "Context that represents a text field (EV_TEXT_FIELD)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class TEXT_FIELD_C 

inherit
	TEXT_COMPONENT_C
		redefine
			gui_object,
			reset_modified_flags,
			is_field
--			stored_node, 
--			copy_attributes, context_initialization, is_fontable,
--			default_commands_list
		end
	
feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.text_page.text_field_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature -- Default attributes

--	default_commands_list: LINKED_LIST [CMD] is
--		local
--			predefined_cmds: SHARED_PREDEF_COMS
--		do
--			Result := Precursor
--			create predefined_cmds
--			Result.extend (predefined_cmds.reset_to_empty_cmd)
--		end

--	default_event: KEY_RET_EV is
--		do
--			Result := key_return_ev
--		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Text_field")
		end

--	add_to_option_list (opt_list: ARRAY [INTEGER]) is
--		do
--			opt_list.put (Context_const.geometry_form_nbr,
--					Context_const.Geometry_format_nbr)
--			opt_list.put (Context_const.text_field_att_form_nbr,
--					Context_const.Attribute_format_nbr)
--		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_TEXT_FIELD"
		end

	full_type_name: STRING is
		do
			Result := "Text field"
		end

	-- ***********************
	-- * specific attributes *
	-- ***********************

feature -- Status report

--	is_fontable: BOOLEAN is
--			-- Is current context fontable
--		do
--			Result := true
--		end

	is_field: BOOLEAN is
		do
			Result := True
		end

	maximum_text_length: INTEGER is
			-- Maximum number of characters in current text
		do
--			Result := gui_object.maximum_text_length
		end

	max_length_modified: BOOLEAN

feature -- Status setting

	set_maximum_text_length (new_size: INTEGER) is
			-- Set `maximum_text_length' to `new_size'.
		do
			max_length_modified := True
			gui_object.set_maximum_text_length (new_size)
		end

	reset_modified_flags is
		do
			Precursor
			max_length_modified := False
		end

feature {NONE}

--	copy_attributes (other_context: like Current) is
--		do
--			if max_length_modified then
--				other_context.set_maximum_size (maximum_size)
--			end
--			Precursor (other_context)
--		end

	
feature {CONTEXT}

--	context_initialization (context_name: STRING): STRING is
--		do
--			!!Result.make (0)
--			if max_length_modified then
--				function_int_to_string (Result, context_name, "set_maximum_size", maximum_size)
--			end
--		end

feature -- Implementation

	gui_object: EV_TEXT_FIELD

feature -- Storage node

--	stored_node: S_TEXT_FIELD is
--		do
--			!!Result.make (Current)
--		end

end -- class TEXT_FIELD_C


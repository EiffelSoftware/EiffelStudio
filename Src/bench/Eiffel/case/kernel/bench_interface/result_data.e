indexing

	description: 
		"Data representing the declaration of result types for features.";
	date: "$Date$";
	revision: "$Revision $"

class RESULT_DATA

inherit

	FEATURE_ELEMENT_DATA
		redefine
			destroy_command,
			insert_before,
			copy, is_equal, 
			generate
		end;

creation

	make, make_from_storer, make_from_relation

feature -- Initialization

	make is
		do
			!! type.set_default_type
		end;

	make_from_storer (storer: S_RESULT_DATA) is
		require
			valid_storer: storer /= Void
		do
			!! type.make_from_storer (storer.type);
		end;

	make_from_relation (s:STRING) is
		do
			!! type.set_type_from_relation (s);
		end;

feature -- Properties

	text: STRING;
			-- Added text such as < or (n)<

	type: TYPE_DECLARATION;
			-- Result type

	--stone_cursor: SCREEN_CURSOR is
	--	do
	--	--	Result := Cursors.result_cursor
	--	end;

	stone_type: INTEGER is
		do
			Result := Stone_types.Result_type
		end;

	destroy_command (a_data: FEATURE_DATA):DESTROY is -- FEATURE_SET_RESULT_U is
		do
		--	!! Result.make_with_container (a_data)
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			fd: FEATURE_DATA
		do
			fd ?= data
			Result := fd /= Void and then fd.has_result and then
							fd.result_type = Current;
		end;

	illegal_characters (tag, txt: STRING): BOOLEAN is
		do
			Result := type.illegal_characters (txt)
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := type.is_equal (other.type);
		end;

feature -- Duplication

	copy (other: like Current) is
		do
			type := clone (other.type);
		end;

feature -- Element change

	insert_before (data_cont: FEATURE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		do
		end;

feature -- Output

	clickable_string, focus: STRING is
		do
			Result := type.name
		end;

	generate (text_area: TEXT_AREA; data: FEATURE_DATA ) is
		do
			text_area.append_string	( ": "	);
			if data.is_expanded then
				text_area.append_string("expanded ");
			end
			type.generate (text_area, data )
		end;

	generate_c (text_area: TEXT_AREA; data: FEATURE_DATA) is
        do
            
            type.generate_c (text_area, data)
			text_area.append_space		
        end;

feature -- Update

	update_type (class_data: CLASS_DATA) is
		require
			valid_class_data: class_data /= Void
		do
			type.update_type (class_data)
		end;

	set_text (s: STRING) is
		do
			text := s
		end

feature {NONE} -- Implementation

	--update_from_namer (namer: NAMER_WINDOW) is
	--	do
	--		type.update_type_from_namer (namer)
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--		namer.set_up (False, False);
	--		namer.set_text (focus);
	--		namer.set_class_list_with_prefix;
	--		namer.set_accept_like_input;
	--	end;

feature -- Storage

	storage_info: S_RESULT_DATA is
		do
			!! Result.make (text, type.storage_info)
		end;

invariant

	valid_type: type /= Void

end -- class RESULT_DATA

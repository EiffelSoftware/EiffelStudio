indexing

	description: "Data representing feature arguments.";
	date: "$Date$";
	revision: "$Revision $"


class ARGUMENT_DATA

inherit

	FEATURE_ELEMENT_DATA
		redefine
			copy, is_equal, generate
		end;

creation

	make, make_from_storer,make_from_relation

feature -- Initialization

	make is
			-- Initialize Current
		do
			id := "arg";
			!! type.set_default_type;
		ensure
			id_set: id.is_equal ("arg");
		end;

	make_from_storer (storer: S_ARGUMENT_DATA) is
			-- Make Current from `storer'.
		require
			valid_storer	: storer	/= void
		do
			id := storer.id;
			!! type.make_from_storer (storer.type);
		end;

	set_type (t: like type) is
		do
			type := t
		end

	make_from_relation (s:string) is
		  	-- Make for New_window
		do
			id:="arg"
			!! type.set_type_from_relation(s);
		end
	
feature -- Properties

	id: STRING;
			-- Id of Current

	type: TYPE_DECLARATION;
			-- Type of Current

	stone_type: INTEGER is
		require else
			valid_stone_types	: stone_types	/= void
		do
			Result := Stone_types.argument_type
		end;

	--stone_cursor: SCREEN_CURSOR is
	--	--require else
	--	--	valid_cursors	: cursors	/= void
	--	do
	--	--	Result := Cursors.argument_cursor
	--	end;

	destroy_command (a_data: FEATURE_DATA): DESTROY_LIST_ELEMENT is
		do
			!! Result.make (a_data, a_data.arguments, Current);
		end;

feature -- Access

	illegal_characters (tag, text: STRING): BOOLEAN is
			-- Does `tag' or `text' contain illegal characters?
		require else
			valid_type	: type	/= void
			valid_text	: text	/= void
		local
			i: INTEGER;
			ch: CHARACTER;
		do
			Result := type.illegal_characters (text)
			if not Result then
				from
					i := 1
				until
					i > text.count or else Result
				loop
					ch := text.item (i);
					Result := ch /= '_' and then
								(not ch.is_digit) and then
								(not ch.is_alpha)
					i := i + 1
				end;
			end;
		end;

	is_valid_for (data: DATA): BOOLEAN is
		local
			fd: FEATURE_DATA;
		do
			fd ?= data;
			Result := fd /= Void and then fd.arguments /= Void and
						then fd.arguments.has (Current);
		end;

feature -- Element change

	insert_before (data_cont: FEATURE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		local
			swap: SWAP_ELEMENT_U
		do
			!! swap.make (data_cont, data_cont.arguments, Current, a_data)
		end;

	update_type (class_data: CLASS_DATA) is
		require
			valid_class_data: class_data /= Void
			valid_type	: type	/= void
		do
			type.update_type (class_data)
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		require else
			valid_type	: type	/= void
		do
			Result := type.is_equal (other.type);
			if Result then
				Result := id.is_equal (other.id);
			end
		end;

feature -- Duplication

	copy (other: like Current) is
		do
			type := clone (other.type);
			id := clone (other.id);
		end;

feature -- Output

	generate (text_area: TEXT_AREA; data: FEATURE_DATA ) is
		require else
			valid_text_area	: text_area /= Void
			valid_type	: type	/= void
		local
			tmp: STRING
		do
			!!tmp.make (0);
			tmp.append (id);
			tmp.append (": ");
			text_area.append_clickable_string (stone (data), tmp);
			type.generate (text_area, data );
		end;

	add_argument (s: STRING) is
		do
			if id = Void then
				!! id.make (0)
			else
				id.append ("' ")
			end

			id.append (s)
		end

	clickable_string, focus: STRING is
		do
			!! Result.make (0);
			Result.append (id);
			Result.append (": ");
			Result.append (type.type.name);
		end;

feature -- Storage

	storage_info: S_ARGUMENT_DATA is
			-- Create storage info form Current
		do
			!! Result.make (id, type.storage_info);		
		end;

feature {NONE} -- Implementation

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--		namer.set_up (True, False);
	--		namer.set_tag_not_empty;
	--		namer.set_tag_id (id);
	--		namer.set_text (type.name);
	--		namer.set_class_list_with_prefix;
	--		namer.set_accept_like_input;
	--	end;

	--update_from_namer (namer: NAMER_WINDOW) is
	--	require else
	--		valid_type	: type	/= void
	--	do
	--		type.update_type_from_namer (namer);
	--		id := clone (namer.entered_id);
	--	end;

invariant

	non_void_type: type /= Void;
	non_void_id: id /= Void;

end -- class ARGUMENT_DATA

indexing

	description: "Data representing the renamed feature.";
	date: "$Date$";
	revision: "$Revision $"

class RENAME_DATA

inherit

	FEATURE_ELEMENT_DATA
		redefine
			destroy_command, insert_before, generate
		end;

creation

	make, make_from_storer


feature {NONE} -- Initialization

	make is
		do
			free_form_text := "renamed feature"
		ensure
			clause_set: clause.is_equal ("^CLASS.feature")
		end;

	make_from_storer (storer: S_RENAME_DATA) is
		do
			free_form_text := storer.free_form_text;
			if storer.origin_feature_key /= Void then
				origin_class_data := System.class_of_id 
							(storer.origin_feature_key.class_id);
				origin_feature_name := storer.origin_feature_key.feature_name;
			end;
		end;

feature -- Properties

	origin_class_data: CLASS_DATA
			-- Class where renamed feature comes from

	origin_feature_name: STRING
			-- Feature name of feature before being renamed

	rename_stone (data: FEATURE_DATA): RENAME_FEATURE_STONE is
		require
			valid_origin_class_data: origin_class_data /= Void;
			valid_origin_feature_name: origin_feature_name /= Void;
		do
			!! Result.make (Current, data)
		end;

	--stone_cursor: SCREEN_CURSOR is
	--	do
		--	if origin_class_data = Void then	
		--		Result := Cursors.rename_cursor
		--	else
		--		Result := Cursors.feature_cursor
		--	end
	--	end;

	stone_type: INTEGER is
		do
			Result := Stone_types.Rename_type
		end;

	destroy_command (a_data: FEATURE_DATA): FEATURE_SET_RENAME_U is
		do
			!! Result.make_with_container (a_data)
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			fd: FEATURE_DATA
		do
			fd ?= data;
			Result := fd /= Void and then fd.is_renamed and then
							fd.rename_clause = Current;
		end;

feature -- Setting

	set_origin_feature (feat: FEATURE_DATA) is
		do
			origin_feature_name := clone (feat.name);
			origin_class_data := feat.class_container
		end;

feature -- Output

	focus, clause, clickable_string: STRING is
		do
			if origin_feature_name /= Void and then
				origin_class_data/= Void then
				!! Result.make (0);
				Result.append ("feature whose name was");
				Result.append (origin_feature_name);
				Result.append ("in class ")
				Result.append (origin_class_data.name);
			else
				if free_form_text= Void then
					!! Result.make (5)
					Result.append("Renamed")
				else
					Result := free_form_text
				end
			end
		end;

	generate (text_area: TEXT_AREA; data: FEATURE_DATA ) is
		local
			tmp: STRING
		do
			tmp := clickable_string;
			if origin_feature_name = Void or origin_class_data= Void then
				text_area.append_clickable_string (stone (data), tmp);
			else
				text_area.append_clickable_string (rename_stone (data), tmp);
			end;
		end;

feature -- Element chage

	insert_before (data_cont: FEATURE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		do
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := clause.is_equal (other.clause)
		end;

feature -- Duplication

	copy (other: like Current) is
		do
			if other.origin_feature_name = Void then
				origin_feature_name := Void;
				origin_class_data := Void;
				free_form_text := clone (other.free_form_text)
			else
				origin_feature_name := clone (other.origin_feature_name);
				origin_class_data := other.origin_class_data
				free_form_text := Void;
			end;
		end;

feature {RENAME_FEATURE_STONE} -- Implementation

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--	--	namer.set_up (False, False);
		--	namer.set_text (clause);
		--	namer.set_list_of_features;
	--	end;

	--update_from_namer (namer: NAMER_WINDOW) is
	--	local
	--		feature_data: FEATURE_DATA;
	---	do
		--	feature_data ?= namer.selected_data;
		--	if feature_data /= Void then
		--		set_origin_feature (feature_data);
		--		free_form_text := Void;
		--	else
		--		origin_feature_name := Void;
		--		origin_class_data := Void;
		--		free_form_text := clone (namer.entered_text);
		--	end
	--	end;

	illegal_characters (tag, text: STRING): BOOLEAN is
		local
			i: INTEGER;
			ch: CHARACTER;
		do
			from
				i := 1
			until
				i > text.count or else Result
			loop
				ch := text.item (i);
				Result := ch /= '_' and then ch /= '^' and then
							ch /= '.' and then
							(ch < '0' or ch > '9') and then
							(ch < 'A' or ch > 'Z') and then
							(ch < 'a' or ch > 'z');
				i := i + 1
			end;
		end;

feature -- Storage

	storage_info: S_RENAME_DATA is
		local
			feature_key: S_FEATURE_KEY
		do
			!! Result;
			if free_form_text /= Void then
				Result.set_free_form_text (free_form_text);
			else
				if origin_feature_name /= Void and then
						origin_class_data /= Void  then
					if origin_class_data.is_in_system then
						!! feature_key.make (origin_feature_name, 
								origin_class_data.id);
						Result.set_origin_feature_key (feature_key);
					else
						Result.set_free_form_text (clause);
					end	;
				else
					Result.set_free_form_text ("")
				end
			end
		end

feature {RENAME_DATA, S_RENAME_DATA} -- Implementation

	free_form_text: STRING;
			-- Text entered if origin feature is not
			-- specified

	set_text (t: STRING) is
		do
			free_form_text := t
		end

end -- class RENAME_DATA

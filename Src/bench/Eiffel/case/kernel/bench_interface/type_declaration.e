indexing

	description: "Declaration of a eiffel class type.";
	date: "$Date$";
	revision: "$Revision $"

class TYPE_DECLARATION

inherit
		
	NAME_DATA
		redefine
			copy, is_equal
		end

creation

	set_default_type, set_type_from_relation, update_type, make_from_storer, set_type

feature -- Initialization

	make_from_storer (storer: S_TYPE_INFO) is
		require
			valid_storer: storer /= Void
		local
			s_basic_info: S_BASIC_TYPE_INFO;
			s_class_info: S_CLASS_TYPE_INFO;
			s_gen_info: S_GEN_TYPE_INFO;
		do
				-- Normally I would let polymorphism create
				-- the corresponding type but because the
				-- storage classes are common between case
				-- and bench I cannot reference specific
				-- case class in the storage directory, hence
				-- the following ugly non-O.O code. (dinov)
			if storer.is_not_actual_class_type then
				s_basic_info ?= storer; -- Cannot fail
				! BASIC_TYPE_INFO ! type.make_from_storer (s_basic_info)
			elseif storer.has_generics then
				s_gen_info ?= storer; -- Cannot fail
				! GEN_TYPE_INFO ! type.make_from_storer (s_gen_info)
			else
				s_class_info ?= storer; -- Cannot fail
				! CLASS_TYPE_INFO ! type.make_from_storer (s_class_info)
			end	
		end;

	update_type (class_data: CLASS_DATA) is
		require
			valid_class_data: class_data /= Void
		do
			if class_data = Void then
				! CLASS_TYPE_INFO ! type.set_name ("ANY");
			elseif class_data.has_generics then
				! GEN_TYPE_INFO ! type.update_type (class_data);
			else
				! CLASS_TYPE_INFO ! type.update_type (class_data);
			end
		end;

	set_default_type is
		do
			! CLASS_TYPE_INFO ! type.set_name ("ANY");
		end;

	set_type_from_relation(s: STRING) is
		do
			! CLASS_TYPE_INFO ! type.set_name (s);
		end;

feature -- Properties

	stone_type: INTEGER is
		do	
			--Result := Stone_types.class_type
		end;

	type: TYPE_INFO;

feature -- Setting

	set_name (s: STRING) is
		do
			! CLASS_TYPE_INFO ! type.set_name (s)
		end;

	set_type (t: like type) is
		require
			valid_t: t /= void
		do
			type := t
		end;


	--update_type_from_namer (namer: NAMER_WINDOW) is
	--	local
	--		tmp: STRING;
	--		a_name: STRING;
	--		selected_data: CLASS_DATA;
	--	do
	--		selected_data ?= namer.selected_data;
	--		if selected_data = Void then
	--			a_name:=clone (namer.entered_text);
	--			a_name.left_adjust;
	--			tmp := clone (a_name);
	--			a_name.to_lower;
	--			if a_name.count > 5 and then a_name.substring(1,5).is_equal ("like ")
--then
	--				tmp := tmp.substring (6, tmp.count);
	--				tmp.prune_all (' ');
	--				tmp.prune_all ('%T');
	--				a_name.replace_substring (tmp, 6, a_name.count);
	--			else
	--				a_name.prune_all (' ');
	--				a_name.prune_all ('%T');
	--				a_name.to_upper;
	---			end;
	--			a_name.replace_substring_all ("[", " [");
	--			! CLASS_TYPE_INFO ! type.set_name (a_name)
	--		else
	--			if selected_data.has_generics then
	--				! GEN_TYPE_INFO ! type.update_type (selected_data)
	--			else
	--				! CLASS_TYPE_INFO ! type.update_type (selected_data)
	--			end
	--		end;
	--	end;

	update_formal_from (gen_data: GENERIC_DATA) is
		local
			formal_type: BASIC_TYPE_INFO
		do
			! BASIC_TYPE_INFO ! type.set_name (gen_data.name);
		end;

feature -- Access

	illegal_characters (text: STRING): BOOLEAN is
			-- Does Current contain illegal characters?
		local
			i, c: INTEGER;
			char: CHARACTER;
			found_left_bracket, found_right_bracket: BOOLEAN
		do
			c := text.count;
			if c /= 0 and then text.item(1).is_alpha then
				from
					Result := True;
					i := 2;
				until
					i > c or else not Result
				loop
					char := text.item (i);
					if char = '[' then
						found_left_bracket := True
					elseif char = ']' then
						found_right_bracket := True
					else
						Result := char.is_digit or else
								char.is_alpha or else
								char = '_' or else
								char = ' ' or else -- next line added by pascalf, for allowing [p,k,l] in
								char = ','         -- Result type ...
					end;
					i := i + 1
				end
			end;
			Result := not (Result and then (found_left_bracket =
						found_right_bracket))
		end;

feature -- Update

	update_name is
		do
		end;

feature -- Output

	focus, name: STRING is
		do
			Result := type.name
		end;

	generate (text_area: TEXT_AREA; data: DATA ) is
		do
			type.generate (text_area, data, Current	)
		end;

	generate_c (text_area: TEXT_AREA; data: DATA) is
        do
            type.generate_c (text_area, data, Current)
        end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := type.is_equal (other.type)
		end;

feature -- Duplication

	copy (other: like Current) is
		do
			type := clone (other.type)
		end;

feature -- Storage

	storage_info: S_TYPE_INFO is
		do
			Result := type.storage_info
		end

invariant

	valid_type: type /= Void

end -- class TYPE_DECLARATION

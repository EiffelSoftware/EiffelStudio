indexing

	description: "Formal generics data within a class definition.";
	date: "$Date$";
	revision: "$Revision $"

class GENERIC_DATA

inherit

	CLASS_ELEMENT_DATA
		redefine
			generate, is_in_class_content
		end;

creation

	make, make_from_storer

feature {NONE} -- Initialization

	make	( default_name : STRING ) is
			-- Make a default generic_data at position `pos'.
		require
			has_name: default_name /= void;
			name_not_empty: not default_name.empty
		do
			name := clone (default_name);
		ensure
			name_set: name.is_equal (default_name);
		end;

	make_from_storer (storer: S_GENERIC_DATA) is
		do
			name := storer.name;
			if storer.constraint_type /= Void then
				!! constraint_type.set_default_type; 
				constraint_type.make_from_storer (storer.constraint_type);
			end
		end


feature -- Properties

	set_constraint_type (t: like constraint_type) is
		do
			constraint_type := t
		end

	constraint_type: TYPE_DECLARATION;
			-- class type if constrained

	name: STRING;
			-- Name of formal type

	type_info: TYPE_INFO is
			-- Type info of Current
		do
			if constraint_type = Void then
				! CLASS_TYPE_INFO ! Result.set_name ("ANY");
			else 
				Result := clone (constraint_type.type)
			end
		end;

	stone_type: INTEGER is
			-- Stone type of Current
		do
			Result := Stone_types.generic_type
		end;

	--stone_cursor: SCREEN_CURSOR is
	--	do
		--	Result := Cursors.generic_cursor
	--	end;

	destroy_command (a_data: CLASS_DATA): DESTROY_GENERIC is
		do
			!! Result.make (a_data, a_data.generics, Current);
		end;

	is_in_class_content: BOOLEAN is
		do
			Result := False
		end;

feature -- Setting

	set_name (s: STRING) is
		do
			name := clone (s);
			name.to_upper
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result :=
				equal (constraint_type, other.constraint_type) and then
					focus.is_equal (other.focus)
		end;

	has_name	( s : STRING )	: BOOLEAN	is
	do
		Result	:= name.is_equal	( s	)
	end

feature -- Duplication

	copy (other: like Current) is
		do
			if other.constraint_type = Void then
				constraint_type := Void;
				name := clone (other.name)
			else
				constraint_type := clone (other.constraint_type);
				name := clone (other.name);
			end;
		end;

feature -- Output

	full_name: STRING is
		do
			Result := clone (name);
			if constraint_type /= Void then
				Result.append ("->");
				Result.append (constraint_type.name)
				Result.prune_all('[')
				Result.prune_all(']')
			end;
		end;

	update_type (class_data: CLASS_DATA) is
		require
			valid_class_data: class_data /= Void
		do
			!! constraint_type.update_type (class_data)
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			cd: CLASS_DATA
		do
			cd ?= data
			Result := cd /= Void and then cd.generics /= Void and
						then cd.generics.has (Current);
		end;

feature -- Element change

	insert_before (data_cont: CLASS_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		local
			swap: SWAP_ELEMENT_U
		do
			!! swap.make (data_cont, data_cont.generics, Current, a_data)
		end;

feature -- Eiffel generation

	generate (text_area: TEXT_AREA; a_data: CLASS_DATA )	is 
		local
			tmp: STRING
		do
			if constraint_type = Void 
			then
				text_area.append_clickable_string	( stone	( a_data	)	, name	)
			else
				!! tmp.make (0);
				tmp.append (name);
				tmp.append ("->");
	
				text_area.append_clickable_string	( stone	( a_data	)	, tmp	)

				constraint_type.generate (text_area, a_data )
			end;
		end;

	set_link ( l: INHERIT_DATA ) is 
		do
			link := l
		end

	--update_from_namer (namer: NAMER_WINDOW) is
	--	local
	--		gnp: GENERIC_NAME_PARSER;
	--	do
	--		!! gnp.make (namer.entered_text);
--
	--		name := clone(gnp.name);

	--		if gnp.constraint /= Void then
	--			if constraint_type=Void then
	--				!! constraint_type.set_default_type;
	--			end;
	--			constraint_type.set_name (clone (gnp.constraint));
	--		else
	--			constraint_type := Void
	--		end;
	--	end;


	link : INHERIT_DATA
		-- link relative to the generic_data if it exists ... pascalf

	clickable_string, focus: STRING is
		do
			!! Result.make (0);
			Result.append (name);
			if constraint_type /= Void then
				Result.append ("->");
				Result.append (constraint_type.type.name);
			end
		end;

feature {NONE} -- Implementation

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--		namer.set_up (False, False);
	--		namer.set_class_list_with_prefix;
	--		namer.set_list_of_generic_constraints;
	--		namer.set_text (focus);
	--	end;

	illegal_characters (tag, text: STRING): BOOLEAN is
		local
			i, c: INTEGER;
			char: CHARACTER
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
					Result := char.is_digit or else
								char.is_alpha or else
								char = '_' or else
								char = ' ' or else
								char = '-' or else
								char = '>';
					i := i + 1
				end
			end
			Result := not Result
		end;

feature -- Storage

	storage_info: S_GENERIC_DATA is
		do
			if constraint_type = Void then
				!! Result.make (name, Void);
			else
				!! Result.make (name, constraint_type.storage_info);
			end
		end;

invariant
	
	valid_name: name /= Void;
	valid_constraint: constraint_type /= Void implies 
						constraint_type.type /= Void

end -- class GENERIC_DATA

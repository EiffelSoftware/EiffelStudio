indexing

	description: "Explicit class type information.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_TYPE_INFO

inherit

	TYPE_INFO
		redefine
			copy, is_equal, set_name
		end

creation

	set_name, update_type, make_from_storer

feature -- Initialization

	make_from_storer (storer: S_CLASS_TYPE_INFO) is
		local
			st : STRING
		do
		--	if storer.class_id > 0 then
		--		type := System.class_of_id (storer.class_id);
		--		if type = Void then 
		--			-- information lost ( from a Reverse ) => we use the 
		--			-- table of system_data ...
		--			free_text_name := system.hyper_system_classes.item(storer.class_id) -- new
		--			-- before free_text_name := storer.free_text_name;
--					if free_text_name= Void then
--						-- the information relative to this id is definitively lost 
--						Windows.add_message ("lost information from id=",1)
--						!! st.make(3)
--						st.append_integer ( storer.class_id )
--						Windows.add_message (st ,1)
--						!! free_text_name.make ( 3 )
--						free_text_name.append ("ANY")
--					end	
--				else
--					free_text_name := Void;
--				end
--			else
--				free_text_name := storer.free_text_name;
--			end
--		--ensure then
--		--	valid_class: storer.class_id > 0 implies type /= Void
		end;

feature -- Properties

	type: CLASS_DATA;
			-- Associated class data

	is_instantiated: BOOLEAN is
		do
			Result := type /= Void
		end

	name: STRING is
			-- Name of class type.
		do
			if type = Void then
				Result := free_text_name
			else
				Result := type.name
			end
			-- patch from pascal, temporary
			if Result = Void then
				!! free_text_name.make(5)
				free_text_name.append("")
				Result := free_text_name
			end
			Result.to_upper
		end;

	dummy_stone (a_data: DATA; type_dec: TYPE_DECLARATION): DUMMY_CLASS_STONE is
		do
			!! Result.make (a_data, type_dec)
		end;

	stone (a_data: DATA; type_dec: TYPE_DECLARATION): TYPE_DEC_STONE is
			-- Stone for class type
		do
			!! Result.make (a_data, type_dec, type)
		end;

feature -- Setting

	set_name (s: STRING) is
		local
			tmp: STRING;
		do
			free_text_name := clone (s);

			tmp := clone (s);
			tmp.to_lower;
			if tmp.count < 6 or else not tmp.substring (1,5).is_equal ("like ") then
				free_text_name.to_upper;
			end

			type := Void
		ensure then
			void_type: type = Void
		end;

	update_type (cl: CLASS_DATA) is
			-- Update type to class `cl' and
			-- name to `cl' name.
		do
			type := cl;
			free_text_name := Void
		ensure then
			type_set: type = cl;
			update_class_name: type.name = cl.name
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			if other.type = Void then
				Result := type = Void;
				if Result then
					Result := name.is_equal (other.name)
				end
			else
				Result := type = other.type and then
							name = other.name
			end;
		end;

feature -- Duplication

	copy (other: like Current) is
		do
			if other.type = Void then
				free_text_name := clone (other.name);
				type := Void
			else
				update_type (other.type);
			end;
		end;

feature -- Storage

	storage_info: S_CLASS_TYPE_INFO is
		local
			id: INTEGER
		do
			if type /= Void and then type.is_in_system then
				id := type.id;
			end
				-- Save name plus id just
				-- in case class was removed from
				-- system and this class type was not
				-- updated.
			!! Result.make (name, id);
		end;

invariant

	type_implies_name_equal_class_name: type /= Void
						implies type.name.is_equal (name)

end -- class CLASS_TYPE_INFO

indexing

	description:
		"Resource table hashed on resource name.";
	date: "$Date$";
	revision: "$Revision $"

class
	RESOURCE_TABLE

inherit
	HASH_TABLE [STRING, STRING]

creation

	make

feature -- Access

	get_integer (name: STRING; default_value: INTEGER): INTEGER is
			-- Value of the resource `name'; 
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		local
			string_value: STRING
		do
			search (name)
			if found then
				string_value := found_item
				if string_value.is_integer then
					Result := string_value.to_integer
				else
					Result := default_value
				end;
			else
				Result := default_value
			end
		end;

	get_pos_integer (name: STRING; default_value: INTEGER): INTEGER is
			-- Positive value of the resource `name'; 
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void;
			valid_default_value: default_value >= 0
		local
			string_value: STRING
		do
			search (name)
			if found then
				string_value := found_item
				if string_value.is_integer then
					Result := string_value.to_integer.abs
				else
					Result := default_value
				end;
			else
				Result := default_value
			end
		ensure
			result_is_positive: Result >= 0
		end;

	get_boolean (name: STRING; default_value: BOOLEAN): BOOLEAN is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		local
			string_value: STRING
		do
			search (name)
			if found then
				string_value := found_item 
				if string_value.is_boolean then
					Result := string_value.to_boolean
				else
					Result := default_value
				end;
			else
				Result := default_value
			end
		end;

	get_real (name: STRING; default_value: REAL): REAL is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		local
			string_value: STRING
		do
			search (name)
			if found then
				string_value := found_item
				if string_value.is_real then
					Result := string_value.to_real
				else
					Result := default_value
				end;
			else
				Result := default_value
			end
		end;

	get_string (name: STRING; default_value: STRING): STRING is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		do
			search (name)
			if found then
				Result := found_item
			else
				Result := default_value
			end
		end;

	get_array (name: STRING; default_value: ARRAY [STRING]): ARRAY [STRING] is
			-- Array value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		local
			a_text: STRING;
			a_list: LINKED_LIST [STRING];
			c, pos, last_pos: INTEGER;
			an_entry: STRING
		do
			search (name)
			if found then
				a_text := found_item
				!! a_list.make;
				from
					c := a_text.count;
					last_pos := 1;
					pos := 1
				until
					last_pos >= c
				loop
					pos := a_text.index_of (';', pos);
					if pos = 0 then
						an_entry := a_text.substring (last_pos, c);
						last_pos := c;
							--| Remove leading / trailing spaces
						an_entry.left_adjust;
						an_entry.right_adjust;
						a_list.extend (an_entry);
					elseif last_pos /= pos then
						an_entry := a_text.substring (last_pos, pos - 1);
							--| Remove leading / trailing spaces
						an_entry.left_adjust;
						an_entry.right_adjust;
						a_list.extend (an_entry);
						pos := pos + 1;
						last_pos := pos;
					else
						pos := pos + 1
						last_pos := pos;
					end;
				end;
				from
					!! Result.make (1, a_list.count);
					a_list.start
					pos := 1
				until
					a_list.after
				loop
					Result.put (a_list.item, pos);
					pos := pos + 1
					a_list.forth
				end
			else
				Result := default_value
			end
		end;

	get_character (name: STRING; default_value: CHARACTER): CHARACTER is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void;
		local
			string_value: STRING
		do
			search (name)
			if found then
				string_value := found_item
				if string_value.count > 0 then
					Result := string_value.item (1);
				else
					Result := default_value
				end;
			else
				Result := default_value
			end
		end;

end -- class RESOURCE_TABLE

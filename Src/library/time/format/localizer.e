indexing
	description: "";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	LOCALIZER

creation

	make

feature -- Initialization

	make is
			-- Initialize the data structures.
		do
			!! boolean_table.make (0);
			!! string_table.make (0);
			!! string_array_table.make (0);
			!! integer_table.make (0)
		end;

feature -- Access

	boolean_value (key: STRING; default_value: BOOLEAN): BOOLEAN is
			-- Boolean value associated with the `key', if present;
			-- otherwise `default_value'
		do
			if boolean_table.has (key) then
				Result := boolean_table.item (key)
			else
				Result := default_value
			end
		end;

	string_value (key, default_value: STRING): STRING is
			-- String associated with `key', if present;
			-- otherwise `default_value'
		require
			default_value_exists: default_value /= Void
		do
			if string_table.has (key) then
				Result := string_table.item (key)
			else
				Result := default_value
			end
		end;

	string_array_value (key: STRING; default_value: ARRAY [STRING]): ARRAY [STRING] is
			-- Array of string associated with `key', if present;
			-- otherwise `default_value'
		require
			default_value_exists: default_value /= Void
		do
			if string_array_table.has (key) then
				Result := string_array_table.item (key)
			else
				Result := default_value
			end
		end;

	integer_value (key: STRING; default_value: INTEGER): INTEGER is
			-- Integer value associated with the `key', if present;
			-- otherwise `default_value'
		do
			if integer_table.has (key) then
				Result := integer_table.item (key)
			else
				Result := default_value
			end
		end;

feature -- Element change

	load_from_file (file_name: FILE_NAME) is
			-- Load date from a file.
		require
			not_implemented: False
		do
		end;

	save_to_file (file_name: FILE_NAME) is
			-- Save data in a file.
		require
			not_implemented: False
		do
		end;

	record_boolean_value (value: BOOLEAN; key: STRING) is
			-- Record `value' with key `key'.
		require
			valid_key: key /= Void
			entry_not_in_table: not has_boolean_entry (key)
		do
			boolean_table.put (value, key)
		end;

	record_string_value (value, key: STRING) is
			-- Insert `value' with the key `key'.
		require
			valid_key: key /= Void
			entry_not_in_table: not has_string_entry (key)
		do
			string_table.put (value, key)
		end;

	record_string_array_value (value: ARRAY [STRING]; key: STRING) is
			-- Insert `value' with the key `key'.
		require
			valid_key: key /= Void
			entry_not_in_table: not has_string_array_entry (key)
		do
			string_array_table.put (value, key)
		end;

	record_integer_value (value: INTEGER; key: STRING) is
			-- Insert `value' with the key `key'.
		require
			valid_key: key /= Void
			entry_not_in_table: not has_integer_entry (key)
		do
			integer_table.put (value, key)
		end;

	force_boolean (value: BOOLEAN; key: STRING) is
			-- If `key' is present, replace corresponding item with value;
			-- otherwise record item with key `key'.
		require
			valid_key: key /= Void
		do
			boolean_table.force (value, key)
		end;

	force_string (value: STRING; key: STRING) is
			-- If `key' is present, replace corresponding item with value;
			-- otherwise record item with key `key'.
		require
			valid_key: key /= Void
		do
			string_table.force (value, key) 
		end;

	force_string_array (value: ARRAY [STRING]; key: STRING) is
			-- If `key' is present, replace corresponding item with value;
			-- otherwise record item with key `key'.
		require
			valid_key: key /= Void
		do
			string_array_table.force (value, key) 
		end;

	force_integer (value: INTEGER; key: STRING) is
			-- If `key' is present, replace corresponding item with value;
			-- otherwise record item with key `key'.
		require
			valid_key: key /= Void
		do
			integer_table.force (value, key)
		end;

	remove_boolean (key: STRING) is
			-- Remove boolean item associated with `key', if present.
		require
			valid_key: key /= Void
		do
			boolean_table.remove (key)
		end;

	remove_string (key: STRING) is
			-- Remove string item associated with `key', if present.
		require
			valid_key: key /= Void
		do
			string_table.remove (key)
		end;

	remove_string_array (key: STRING) is
			-- Remove array of strings item associated with `key', if present.
		require
			valid_key: key /= Void
		do
			string_array_table.remove (key)
		end;

	remove_integer (key: STRING) is
			-- Remove integer item associated with `key', if present.
		require
			valid_key: key /= Void
		do
			integer_table.remove (key)
		end;


feature -- Status report

	has_boolean_entry (key: STRING): BOOLEAN is
			-- Is there a boolean item with key `key'?
		require
			valid_key: key /= Void
		do
			Result := boolean_table.has (key)
		end;

	has_string_entry (key: STRING): BOOLEAN is
			-- Is there a string item with key `key'?
		require
			valid_key: key /= Void
		do
			Result := string_table.has (key)
		end;

	has_string_array_entry (key: STRING): BOOLEAN is
			-- Is there an array of strings item with key `key'?
		require
			valid_key: key /= Void
		do
			Result := string_array_table.has (key)
		end;

	has_integer_entry (key: STRING): BOOLEAN is
			-- Is there an integer item with key `key'?
		require
			valid_key: key /= Void
		do
			Result := integer_table.has (key)
		end;

feature {NONE} -- Implementation

	boolean_table: HASH_TABLE [BOOLEAN, STRING];

	string_table: HASH_TABLE [STRING, STRING];

	string_array_table: HASH_TABLE [ARRAY [STRING], STRING];

	integer_table: HASH_TABLE [INTEGER, STRING];

end -- class LOCALIZER


--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing

	description: "Store and retrieve keys.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class KEYS inherit

	HASH_TABLE [STRING, STRING]

	INTERNAL
		undefine 
			copy,
			is_equal
		end

	EXCEPTIONS
		rename
			class_name as exceptions_class_name
		undefine
			copy,
			is_equal
		end

creation

	make

feature

	reference_key (table: ANY): ANY is
			-- What is the object refered by unique 
			-- attribute associated with `table'.
		require
			table_not_void: table /= Void;
			table_exits: has (table.generator)
		local
			i: INTEGER;
			key_name: STRING;
		do
			from
				key_name := item (table.generator);
				i := 1
			until
				 Result /= Void or else i > field_count (table)
			loop
				if key_name.is_equal (field_name (i, table)) then
					Result := field (i, table)
				end;
				i := i + 1
			end
		ensure
			found: Result /= Void
		end;
	
end -- class KEYS


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

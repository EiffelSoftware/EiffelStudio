indexing

	description:
		"Describe an OO model and the keys for each classes.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class MODEL

feature -- Initialization

	make is
			-- Traverse, convert and print the model.
		local
			model_traversal: MODEL_TRAVERSAL;
			tables: LINKED_LIST [SQL_TABLE];
			pr: PRINT_REQUEST
		do
			!! tables.make;
			register_keys;
			!! model_traversal.make (model, tables, keys);
			!! pr.make (tables, output)
		end;

feature -- *To define*

	model: ANY is
			-- Root object of the model.
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	register_keys is
			-- Register all keys (multiple call to register_key)
		deferred
		end;

feature
		
	keys: KEYS is
			-- Keys of the model.
		once
			!! Result.make (30);
		ensure
			result_not_void: Result /= Void;
			keys_not_empty: not result.empty
		end;

	output: FILE is
			-- Where to print the result?
		once
			Result := io.output
		ensure
			result_not_void: Result /= Void
		end;

	register_key (field_name, table_name: STRING) is
			-- Register `field_name' key for 
			-- the table `table_name'.
		require
			field_name_not_void: field_name /= Void;
			table_name_not_void: table_name /= Void;
			keys_not_void: keys /= Void;
			key_not_registered: not keys.has (table_name)
		do
			keys.put (field_name, table_name)
		ensure
			key_registered: keys.has (table_name)
		end;

end -- class MODEL


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

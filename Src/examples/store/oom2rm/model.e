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
			create tables.make;
			register_keys;
			create model_traversal.make (model, tables, keys);
			create pr.make (tables, output)
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
			create Result.make (30);
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
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

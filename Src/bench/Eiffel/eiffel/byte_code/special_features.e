class SPECIAL_FEATURES

inherit

	ARRAY [STRING]
		rename
			make as array_make
		export 
			{NONE} all
		undefine
			twin
		end;
	BYTE_CONST

creation

	make


feature {NONE}

	current_count: INTEGER;
			-- Current item count
		
feature

	found: BOOLEAN;
			-- Was feature_name found from last find?

	make is
			-- Make an array of special feature names.
		do
			array_make (1, 4);
			put ("is_equal", 1);
			put ("standard_is_equal", 2);
			put ("deep_equal", 3);
			put ("standard_deep_equal", 4);
		end;

	find (feature_name: STRING) is
			-- Does Current have `feature_name'?
			-- Set found to True if found.
			-- Otherwise, set found to False.
		local
			i: INTEGER
		do
			from
				i := 1;
				found := False;
			until
				i > count
				or else found
			loop
				found := item(i).is_equal (feature_name);
			   	i := i + 1;
			end;
			if found then 
				current_count := i - 1;
			end
		end;

	bc_code: CHARACTER is
			-- Byte code constant associated to current special
			-- feature from find.
		require
			Found: found 
		do
			Result := Bc_eq 
		end;

	c_operation: STRING is
			-- C code constant associated to current special
			-- feature from find.
		require
			found: found
		do
			Result := "==" 
		end;

end

indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_FIELD 

creation -- Creation procedure

	make

feature  -- Initialization

	make is
			-- Create object with default values.
		do
			field_type := -1;
			field_rank := 0;
			use_value_delimiters := False;
			label_separator := ':';
			use_label := True
		end;

feature  -- Status report

	field_type: INTEGER

	field_value: ANY

	field_name: STRING

	field_rank: INTEGER
			-- Index of this field in the father object.

	use_label: BOOLEAN
			-- Has this field a given label ?

	use_value_delimiters: BOOLEAN
			-- Are value delimiters to be used  ?

	left_delimiter, right_delimiter, label_separator: CHARACTER

feature -- Status setting

	set_use_label (b: BOOLEAN) is
			-- Set `use_label' with `b'.
		do
			use_label := b
		ensure 
			use_label = b
		end;

	set_field (type: INTEGER;n: STRING) is
			-- Set field with type `type' and name `n'.
		require 
			name_exists: n /= Void
		do
			field_type := type;
			field_name := clone (n)
		ensure
			field_type = type;
			field_name.is_equal(n)
		end;

	set_value (v: ANY) is
			-- Set field value with `v'.
		require 
			value_exists: v /= Void
		do
			field_value := v
		end;

	set_rank (r: INTEGER) is
			-- Set field rank with `r'.
		do
			field_rank := r
		end;

	set_value_delimiters (ld, rd: CHARACTER) is
			-- Set field value delimiters with `ld' and `rd'.
		do
			use_value_delimiters := True;
			left_delimiter := ld;
			right_delimiter := rd
		ensure
			use_value_delimiters = True;
			left_delimiter = ld;
			right_delimiter = rd
		end;

	set_label_separator (ls: CHARACTER) is
			-- Set label separator with `ls'.
		do
			label_separator := ls
		ensure
			label_separator = ls
		end

end -- class EC_FIELD



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


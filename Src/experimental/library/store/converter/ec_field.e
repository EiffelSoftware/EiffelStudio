note

	status: "See notice at end of class.";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_FIELD

create -- Creation procedure

	make

feature  -- Initialization

	make
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

	field_value: detachable ANY

	field_name: detachable STRING

	field_rank: INTEGER
			-- Index of this field in the father object.

	use_label: BOOLEAN
			-- Has this field a given label ?

	use_value_delimiters: BOOLEAN
			-- Are value delimiters to be used  ?

	left_delimiter, right_delimiter, label_separator: CHARACTER

feature -- Status setting

	set_use_label (b: BOOLEAN)
			-- Set `use_label' with `b'.
		do
			use_label := b
		ensure
			use_label = b
		end;

	set_field (type: INTEGER;n: STRING)
			-- Set field with type `type' and name `n'.
		require
			name_exists: n /= Void
		do
			field_type := type;
			field_name := n.twin
		ensure
			field_type = type;
			field_name ~ n
		end;

	set_value (v: ANY)
			-- Set field value with `v'.
		require
			value_exists: v /= Void
		do
			field_value := v
		end;

	set_rank (r: INTEGER)
			-- Set field rank with `r'.
		do
			field_rank := r
		end;

	set_value_delimiters (ld, rd: CHARACTER)
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

	set_label_separator (ls: CHARACTER)
			-- Set label separator with `ls'.
		do
			label_separator := ls
		ensure
			label_separator = ls
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EC_FIELD




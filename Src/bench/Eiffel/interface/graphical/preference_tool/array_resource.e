indexing

	description:
		"Resource encapsulating an array of strings.";
	date: "$Date$";
	revision: "$Revision$"

class ARRAY_RESOURCE

inherit
	STRING_RESOURCE
		rename
			make as sr_make,
			is_valid as string_is_valid
		redefine
			set_value
		end;
	STRING_RESOURCE
		rename
			make as sr_make
		redefine
			set_value, is_valid
		select
			is_valid
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; an_array: ARRAY [STRING]) is
			-- Initialie Current
		do
			actual_value := an_array;
			update_value;
			name := a_name
		end

feature -- Setting

	set_actual_value (an_array: ARRAY [STRING]) is
			-- Set `actual_value' to `an_array' and
			-- update `value'.
		do
			actual_value := an_array;
			update_value
		end;

	set_value (a_string: STRING) is
			-- Set `value' to `a_string' and update
			-- `actual_value',
		require else
			a_string_is_valid: is_valid (a_string)
		do
			value := a_string;
			update_actual_value
		end

feature -- Properties

	actual_value: ARRAY [STRING]
			-- The array, as reprensented by `value'.

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		local
			parser: RESOURCE_PARSER
		do
			if string_is_valid (a_value) then
				Result := True
			else
				Result := False
			end
		end

feature {NONE} -- Implementation

	update_value is
			-- Updates `value' using current `actual_value'.
		local
			index: INTEGER;
			not_first_time: BOOLEAN
			c: INTEGER
		do
			!! value.make (0);
			c := actual_value.count
			if c > 0 then
				from
					index := 1
				until
					index > c
				loop
					if not not_first_time then
						not_first_time := True
					else
						value.append ("; ")
					end;
					value.append (actual_value.item (index));
					index := index + 1
				end
			end
		end;

	update_actual_value is
			-- Update `actual_value' using current `value'.
		local
			start_pos, end_pos: INTEGER
		do
			from
				!! actual_value.make (1, 0);
				start_pos := 1;
				end_pos := value.index_of (';', start_pos);
			until
				end_pos = 0
			loop
				actual_value.force (value.substring (start_pos, end_pos - 1), actual_value.count + 1);
				start_pos := end_pos + 1;
				end_pos := value.index_of (';', start_pos)
			end
			if start_pos <= value.count then
				actual_value.force (value.substring (start_pos, value.count), actual_value.count + 1)
			end
		end

end -- class ARRAY_RESOURCE

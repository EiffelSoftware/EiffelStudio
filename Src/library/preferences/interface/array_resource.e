indexing
	description	: "Resource encapsulating an array of strings."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ARRAY_RESOURCE

inherit
	STRING_RESOURCE
		rename
			make as sr_make,
			default_value as value
		redefine
			set_value, value
		end


creation
	make, 
	make_from_string

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: ARRAY [STRING]; a_type: RESOURCE_TYPE) is
			-- Initialize Current
		do
			type := a_type
			name := a_name
			actual_value := a_value
			update_value
		end

	make_from_string (a_name: STRING; a_value: STRING; a_type: ARRAY_RESOURCE_TYPE) is
			-- Initialize Current
		do
			type := a_type
			name := a_name
			value := a_value
			update_actual_value
		end

feature -- Access

	value: STRING
			-- Value of the resource 

	actual_value: ARRAY [STRING]
			-- The array, as reprensented by `value'.

feature -- Setting

	set_actual_value (an_array: ARRAY [STRING]) is
			-- Set `actual_value' to `an_array' and
			-- update `value'.
		do
			actual_value := an_array
			update_value
		end

	set_value (a_string: STRING) is
			-- Set `value' to `a_string' and update
			-- `actual_value',
		do
			value := a_string
			update_actual_value
		end

feature {NONE} -- Implementation

	update_value is
			-- Updates `value' using current `actual_value'.
		local
			index: INTEGER
			not_first_time: BOOLEAN
			c: INTEGER
		do
			create value.make (0)
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
						value.append (";")
					end;
					value.append (actual_value.item (index))
					index := index + 1
				end
			end
		end

	update_actual_value is
			-- Update `actual_value' using current `value'.
		local
			start_pos, end_pos: INTEGER
		do
			create actual_value.make (1, 0)
			if not value.is_empty then
				from
					start_pos := 1
					end_pos := value.index_of (';', start_pos)
				until
					end_pos = 0 or start_pos = value.count
				loop
					actual_value.force (value.substring (start_pos, end_pos - 1), actual_value.count + 1)
					start_pos := end_pos + 1
					end_pos := value.index_of (';', start_pos)
				end
				if start_pos <= value.count then
					actual_value.force (value.substring (start_pos, value.count), actual_value.count + 1)
				end
			end
		end

end -- class ARRAY_RESOURCE

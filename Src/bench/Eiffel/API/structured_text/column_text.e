indexing

	description: 
		"Text that has column information";
	date: "$Date$";
	revision: "$Revision $"

class COLUMN_TEXT

inherit

	TEXT_ITEM
		redefine
			image
		end

create

	make

feature -- Initialization

	make (num: like column_number) is
			-- Initialize `column_number' with `num'.
		require
			num_is_pos: num > 0
		do
			column_number := num
		ensure
			set: column_number = num 
		end;

feature -- Access

	column_number: INTEGER
			-- Column number

	number_of_blanks (last_pos: INTEGER): INTEGER is
			-- Number of blanks spaces between 
			-- `last_pos' and `column_number'
		do
			Result := column_number - last_pos;
			if Result < 0 then	
				Result := 1
			end
		ensure
			positive_result: Result > 0;
			if_negative_then_is_1: 
				(column_number - last_pos) < 0 implies
					Result = 1
		end

feature -- Properties

	image: STRING is
			-- Empty string
		once
			Result := ""
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_column_text (Current)
		end

end -- class COLUMN_TEXT

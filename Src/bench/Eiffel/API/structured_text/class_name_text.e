indexing

	description: 
		"Item to denote a class_name.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_NAME_TEXT

inherit

	CLICKABLE_TEXT
		redefine
			append_to
		end

creation

	make

feature -- Access

	file_name: STRING is
			-- Name of the file where the class text is stored;
			-- The final ".e" has been removed
		local
			classc_stone: CLASSC_STONE;
			classi_stone: CLASSI_STONE;
			count: INTEGER
		do
			classc_stone ?= stone;
			if classc_stone /= Void then
				Result := clone (classc_stone.file_name)
			else
				classi_stone ?= stone;
				if classi_stone /= Void then
					Result := clone (classi_stone.file_name)
				else
					!!Result.make (0)
				end
			end;
			count := Result.count;
			if 
				count > 1 and then 
				Result.item (count) = 'e' and then
				Result.item (count - 1) = '.'
			then
				Result.head (count - 2)
			end
		ensure
			Result /= Void
		end;

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current class name text to `text'.
        do
			text.process_class_name_text (Current)
        end

end -- class CLASS_NAME_TEXT

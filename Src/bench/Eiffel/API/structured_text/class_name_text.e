class CLASS_NAME_TEXT

inherit

	CLICKABLE_TEXT

creation

	make

feature

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
				Result := classc_stone.file_name
			else
				classi_stone ?= stone;
				if classi_stone /= Void then
					Result := classi_stone.file_name
				else
					Result := ""
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

end

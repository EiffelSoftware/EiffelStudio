class COMMENT_TEXT

inherit
	TEXT_ITEM

creation
	make

feature

	make (line: STRING) is
		do
			image.make (line.count + 2);
			image.append ("--");
			image.append (line);
		end;

	start is
		do
			position := 1;
			quoted := false;
			compute_item;		
		end;

	item: STRING;


	forth is
		do
			position := end_position + 1;
			compute_item
		end


	after: BOOLEAN is
		do
			Result := position > image.count;
		end;


feature {}

	position: INTEGER;

	end_position: INTEGER;

	compute_item is
		local
			end_character: CHARACTER;
		do
			if not after then
				if quoted then 
					end_character := '%''
				else
					end_character := '`'
				end;
				from
					end_position := position
				until
					end_position > count
					or else image.item (end_position) = end_character
				loop
					end_position := end_position + 1;
				end;
				item = substring (image, position, end_position - 1)
			end;
			quoted := not quoted;	
		end
				
end
	

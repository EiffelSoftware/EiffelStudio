indexing

	description: 
		"Text that contains comments.";
	date: "$Date$";
	revision: "$Revision $"

class COMMENT_TEXT

inherit

	TEXT_ITEM

creation

	make

feature -- Initialization

	make (line: STRING) is
		do
			image.make (line.count + 2);
			image.append ("--");
			image.append (line);
		end;

feature -- Property

	item: STRING;
			-- Current item
			
feature -- Access

	after: BOOLEAN is
			-- Is position after?
		do
			Result := position > image.count;
		end;

feature -- Cursor posistion

	start is
			-- Move position to the start of Current comment.
		do
			position := 1;
			quoted := false;
			compute_item;		
		end;

	forth is
			-- Move position to the next item of Current comment.
		do
			position := end_position + 1;
			compute_item
		end

feature {NONE} -- Implementation

	position: INTEGER;
			-- Current position of comment

	end_position: INTEGER;
			-- End position of comment

	compute_item is
			-- Compute Current item of comment
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
	

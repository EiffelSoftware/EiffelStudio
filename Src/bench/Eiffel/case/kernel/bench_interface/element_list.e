indexing

	description: "List of element data.";
	date: "$Date$";
	revision: "$Revision $"

class ELEMENT_LIST [T->ELEMENT_DATA]

inherit

	LINKED_LIST [T]
		rename
			duplicate as duplicate_n
		redefine
			is_equal
		end;

creation

	make

feature -- Duplication

	duplicate: like Current is
			-- Duplicate Current structure and its items
		local
			pos: CURSOR
		do
			!! Result.make
			pos := cursor
			from
				start
			invariant
				same_index: index = Result.index
			variant
				remaining_elements: count - index
			until
				off
			loop
				Result.extend (clone(item))
				forth
			end
			go_to (pos)
		ensure
			result_duplicated: is_equal (Result)
		end;

feature -- Output

	generate (text_area: TEXT_AREA; data: DATA ) is
			-- Generate to `text_area' with container `data'.
		require
			valid_text_area: text_area /= Void;
		do
			from
				start
			until
				after
			loop
				item.generate (text_area, data	);
				text_area.new_line;
				forth
			end;
		end;

	generate_string (text_area: TEXT_AREA; data: DATA ) is
			-- Generate to `text_area' with container `data'.
		require
			valid_text_area: text_area /= Void;
		do
			from
				start
			until
				after
			loop
				item.generate (text_area, data );
				text_area.new_line;
				forth
			end;
		end;


feature -- Properties

	is_equal (other: like Current): BOOLEAN is
			-- Is `Current' list equal to `other' (ie, same elements, in 
			-- the same order) ?
			--| Should be implemented this way in ancestors...
		local
			pos, opos: like cursor
		do
			from
				pos := cursor   -- save cursors positions
				opos := other.cursor
				start;
				other.start
				Result := (count = other.count)
			until
				after or else not Result
			loop
				Result := other.item.is_equal (item);
				other.forth
				forth;
			end;
	
			go_to(pos) -- restore cursors positions
			other.go_to(opos)
		end

end -- ELEMENT_LIST [T->ELEMENT_DATA]

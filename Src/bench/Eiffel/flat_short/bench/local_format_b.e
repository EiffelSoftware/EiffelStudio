indexing

	description: 
		"Format details related to the output of a format.";
	date: "$Date$";
	revision: "$Revision $"

class LOCAL_FORMAT_B

inherit

	LOCAL_FORMAT

feature -- Properties

	position_in_text: CURSOR;
			-- Position of text
			--| Used for rollback

	insertion_point: CURSOR;
			-- Last position for left parantheses

	must_abort_on_failure : BOOLEAN;
		-- rollback all the EIFFEL_LIST if one token cannot be printed?
		--| eg : true for a manifest array: don't print the array at
		--| all if one item is not exported
		--| false for an assertion: keep printing the following items even
		--| if one must be ommited 

feature -- Setting

	set_insertion_point (p: like insertion_point) is
			-- Set `insertion_point' to `p'.
		do
			insertion_point := p;
		ensure
			insertion_point = p
		end;

	set_position (pos: like position_in_text) is
			-- Set `position_in_text' to `pos'.
		do
			position_in_text := pos;
		ensure
			position_in_text = pos
		end;

	set_must_abort (b: BOOLEAN) is
			-- Set must_abort_on_failure to b.
		do
			must_abort_on_failure := b;
		ensure
			must_abort_on_failure = b
		end;

end -- class LOCAL_FORMAT_B

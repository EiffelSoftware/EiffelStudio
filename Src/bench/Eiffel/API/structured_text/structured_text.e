indexing

	description: 
		"List of text items as a result of formatting ast structures.";
	date: "$Date$";
	revision: "$Revision $"

class STRUCTURED_TEXT

inherit

	TWO_WAY_LIST [TEXT_ITEM]
		export 
			{NONE}
				all;
			{ANY}
				cursor, start, forth, after, item, empty,
				finish, wipe_out, islast, first_element, last
		end;
	SHARED_RESCUE_STATUS

creation

	make

feature -- Element change

	add (v: like item) is
			-- Add item `v' to end.
		require
			at_end: not empty implies islast
		do
			put_right (v);
			finish;
		ensure
			at_end: islast
		end;

	insert_two (cur: CURSOR; v1, v2: like item) is
			-- Insert at cursor position `cur' item `v1'
			-- and `v2'.
		do
			go_to (cur);
			put_right (v2);
			put_right (v1);
			finish;
		ensure
			at_end: islast
		end; 

	cursor_out: BOOLEAN;	

	head (pos: CURSOR) is
			-- List until `pos'.
		do
			if not cursor_out then 
					-- cursor no more in list
					-- no easy way to test. Use the exception.
				go_to (pos);
				if before then
					wipe_out
				elseif not after then
					forth;
				end;
				if not after then
					split (count);
					remove_sublist
				end;
			else
				cursor_out := False
			end;
			finish;
		rescue
			if Rescue_status.is_unexpected_exception then
				if not cursor_out then
					cursor_out := true;
					retry
				end;
			end
		end;

	image: STRING is
			-- Raw text. Result is created for each call
		local
			linkable: LINKABLE [TEXT_ITEM]
		do
			!! Result.make (0);
			from
				linkable := first_element
			until
				linkable = Void
			loop
				Result.append (linkable.item.image);
				linkable := linkable.right;
			end;
		end;

end -- class STRUCTURED_TEXT

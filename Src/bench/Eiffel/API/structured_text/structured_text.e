class STRUCTURED_TEXT

inherit

	TWO_WAY_LIST [TEXT_ITEM]
		export 
			{NONE}
				all;
			{ANY}
				cursor, start, forth, after, item, last, empty,
				finish, off, go_i_th, index, extend, wipe_out
		end;
	SHARED_RESCUE_STATUS

creation

	make

feature

	add (v: like item) is
		do
			finish;
			put_right (v);
			forth;
		end;

	insert (pos: CURSOR; v: like item) is
		do
			go_to (pos);
			put_right (v);
			finish;
		end; 

	head (pos: CURSOR) is
		local
			cursor_out: BOOLEAN;	
		do
			if not cursor_out then -- cursor no more in list
								-- no easy way to test. use the exception	
				go_to (pos);
				if before then
					wipe_out
				elseif not after then
					forth;
				end;
				if not after then
					split (count);
					remove_sublist
				end
			end;
		rescue
			if Rescue_status.is_unexpected_exception then
				if not cursor_out then
					cursor_out := true;
					retry
				end;
			end
		end;



	image: STRING is
			-- raw text. Result is created for each call
		local
			s: STRING
		do
			!! Result.make (0);
			from
				start
			until
				after	
			loop
				s := item.image;
				if s /= void then
					Result.append (s);
				end;
				forth
			end;
		end;



end



			

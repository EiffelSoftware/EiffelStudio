
deferred class CLICK_WINDOW

feature
	
	put_string (s: STRING) is deferred end;

	put_clickable_string (a: ANY; s: STRING) is deferred end;

	new_line is deferred end;

	put_int (i: INTEGER) is
		do
			put_string (i.out);
		end;

end

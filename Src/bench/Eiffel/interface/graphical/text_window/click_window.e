
deferred class CLICK_WINDOW

feature
	
	put_string (s: STRING) is deferred end;

	put_clickable_string (a: ANY; s: STRING) is deferred end;

	new_line is deferred end;

	put_char (c: CHARACTER) is deferred end;

	put_int (i: INTEGER) is
		do
			put_string (i.out);
		end;

	display is do end;

	clear_window is do end;

feature -- Obsolete

	putstring (s: STRING) is obsolete "Use put_string"
		do
			put_string (s);
		end;

end

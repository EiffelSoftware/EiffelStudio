
-- File window with kind of a clickable interface...

class FILE_WINDOW

inherit

	CLICK_WINDOW
		rename
			putstring as click_w_putstring
		end;

	PLAIN_TEXT_FILE

creation

	make

feature

	open_file is
		local
			retried: BOOLEAN
		do
			if not retried then
				open_write
			end;
		rescue
			io.error.putstring ("Cannot create file: ");
			io.error.putstring (name);
			io.error.new_line;
			retried := True;
			retry
		end;

feature

	put_string (s: STRING) is do putstring (s) end;

	put_clickable_string (a: ANY; s: STRING) is do putstring (s) end;

	put_char (c: CHARACTER) is do putchar (c) end;

end

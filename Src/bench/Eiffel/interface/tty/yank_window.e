
-- Stores the output in a string

class YANK_WINDOW

inherit

	WINDOWS;

	CLICK_WINDOW

creation

	make

feature

	stored_output: STRING

	make is
		do
			!!stored_output.make (0);
		end;

	reset_output is
		do
			stored_output.wipe_out
		end;

--	open_file is
--		local
--			retried: BOOLEAN
--		do
--			if not retried then
--				open_write
--			end;
--		rescue
----			io.error.putstring ("Cannot create file: ");
--			io.error.putstring ("Cannot create file: ");
--			io.error.putstring (name);
--			io.error.new_line;
----			retried := True;
--			retry
--		end;

	put_string (s: STRING) is
		do
			error_window.put_string (s);
			stored_output.append (s)
		end;

	put_clickable_string (a: ANY; s: STRING) is
		do
			error_window.put_string (s);
			stored_output.append (s)
		end;

	put_char (c: CHARACTER) is
		do
			error_window.put_char (c)
			stored_output.extend (c)
		end;

	new_line is
		do
			error_window.new_line;;
			stored_output.extend ('%N')
		end;

end

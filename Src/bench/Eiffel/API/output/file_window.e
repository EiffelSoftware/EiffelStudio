indexing

	description: 
		"Terminal window that redirects output to a file.";
	date: "$Date$";
	revision: "$Revision $"

class FILE_WINDOW

inherit

	OUTPUT_WINDOW;

	PLAIN_TEXT_FILE

	PLATFORM_CONSTANTS

creation

	make

feature -- Output

	open_file is
			-- Open file.
		local
			retried: BOOLEAN
			i, nb: INTEGER
			sub_name: STRING
			d: DIRECTORY
			c: CHARACTER
		do
			if not retried then
					-- Create recursively the file name
				from
					c := Directory_separator
					if is_windows then
							-- For Windows we can have either `c:\' and the existence
							-- does work on `c:\' only, not on `c:'. So we have to search
							-- until the next `Directory_separator'.
						i := name.index_of (':', 1)
					end
					i := name.index_of (c, i + 2)
					nb := name.count
				until
					i = 0
				loop
					sub_name := name.substring (1, i - 1)
					create d.make (sub_name)
					if not d.exists then
						d.create_dir
					end
					i := name.index_of (c, i + 2)
				end
				open_write
			end;
		rescue
			retried := True;
			retry
		end;

	put_char (c: CHARACTER) is 
			-- Put character `c' to current position in file.
		do 
			putchar (c) 
		end;

end -- class FILE_WINDOW

indexing

	description: "A file with primitives for indenting.";
	date: "$Date$";
	revision: "$Revision $"

class INDENT_FILE 

inherit

	PLAIN_TEXT_FILE
		rename
			make as make_with_name,
			putstring as file_putstring,
			new_line as file_new_line,
			putchar as file_putchar,
			close as unix_file_close
		export
			{NONE} all;
			{ANY} open_read, name, delete,
				is_open_write, exists, is_closed
		end;
	TEXT_AREA
		redefine
			output_to_disk
		end;
	CONSTANTS

creation

	make, make_with_name

feature {NONE} -- Initialization

	make (f_name: STRING; parser: FILTER_PARSER) is
		require
			valid_f_name: f_name /= Void;
		local
			format: CELL2 [STRING, STRING];
		do
			if f_name /= Void then
				make_open_write (f_name);
				if parser = Void then
						-- it is ascii
					!! format_table.make (0)
				else
					format_table := parser.format_table;
					if format_table /= Void then
						format := format_table.item (Filter_keys.f_Class_declaration);
						if format /= Void then
							file_putstring (format.item1);
						end;
					end
				end;
			end
		end;
	
feature -- Setting

	close is
			-- Close Current indent file.
		require
			is_open: not is_closed
		local
			format: CELL2 [STRING, STRING]
		do
			if format_table /= Void then
				format := format_table.item (Filter_keys.f_Class_declaration);
				if format /= Void and then format.item2 /= Void then
					file_putstring (format.item2)
				end;
				unix_file_close;
			end
		ensure
			is_closed: is_closed
		end;

feature -- Element change

	new_line is
			-- Write a '\n'.
			-- Do not allow two ore more consecutive blank lines.
		local
			format: CELL2 [STRING, STRING]
		do
			if nl < 2 then
				format := format_table.item (Filter_keys.f_New_line);
				if format = Void then
					file_new_line;
				else
					file_putstring (format.item1);
					if format.item2 /= Void then
						file_new_line;
						file_putstring (format.item2);
					end;
				end;
				emitted := false;
				nl := nl + 1;
			end;
		end;

	append_space is
		do
			emit_tabs;
			nl := 0;
			file_putchar (space_character);
		end;

	append_clickable_string (a: STONE; s: STRING) is
		-- Append clickable string to Current
		do
			append_string (s)
		end;

	append_comment_string (s: STRING) is
			-- Write string `s'.
		local
			format: CELL2 [STRING, STRING]
		do
			format := format_table.item (Filter_keys.f_Comment);
			emit_tabs;
			nl := 0;
			if format = Void then
				file_putstring (s);
			else
				file_putstring (format.item1);
				if format.item2 /= Void then
					file_putstring (s);
					file_putstring (format.item2);
				end
			end;
		end;

	append_string (s: STRING) is
			-- Write comment `s'.
		do
			emit_tabs;
			nl := 0;
			file_putstring (s);
		end;

	append_keyword (s: STRING) is
			-- Write keyword `s'.
		local
			format: CELL2 [STRING, STRING];
			text_image: STRING
		do
			text_image := clone (s);
			text_image.to_lower;
			-- Filters format allows substition of key words
			-- (Ignore it for the time being).
			-- format := format_table.item (text_image);
			if format = Void then
				format := format_table.item (Filter_keys.f_Keyword)
			end;
			emit_tabs;
			nl := 0;
			if format = Void then
				file_putstring (s);
			else
				file_putstring (format.item1);
				if format.item2 /= Void then
					file_putstring (s);
					file_putstring (format.item2);
				end
			end;
		end;

	append_character (c: CHARACTER) is
			-- Write character `c'.
		do
			emit_tabs;
			nl := 0;
			file_putchar (c);
		end;

feature -- Properties

	special_string (str: STRING): STRING is
			-- Special string representation of additional symbols 
			-- contained by `str'.
			--| For Current, simply returns an empty string, since
			--| no additional symbol should be generate into a file
		do
			!! Result.make (0)
		end

feature {NONE} -- Implementation

	format_table: HASH_TABLE [CELL2 [STRING, STRING], STRING];

	old_tabs: INTEGER;
			-- Saved indentation value

	emitted: BOOLEAN;
			-- Have leading tabs already been emitted?

	nl: INTEGER;
			-- Number of consecutive new line generated

	output_to_disk: BOOLEAN is True;
			-- Output Current file to disk?

	space_character: CHARACTER is
		once
			Result := ' '
		end;

	emit_tabs is
			-- Emit the `tabs' leading tabs.
		local
			i: INTEGER;
			format: CELL2 [STRING, STRING];
		do
			if not emitted then
				format := format_table.item (Filter_keys.f_Tab);
				if format = Void then
					from
						i := 1;
					until
						i > tabs
					loop
						file_putchar ('%T');
						i := i + 1;
					end;
				else
					from
						i := 1;
					until
						i > tabs
					loop
						file_putstring (format.item1);
						if format.item2 /= Void then
							file_putchar ('%T');
							file_putstring (format.item2);
						end;
						i := i + 1;
					end;
				end;
				emitted := true;
			end;
		end;

end -- class INDENT_FILE


-- Terminal window with kind of a clickable interface...

class TERM_WINDOW

inherit

	OUTPUT_WINDOW

feature

	put_string (s: STRING) is do io.error.putstring (s) end;

	new_line is do io.error.new_line end;

	put_char (c: CHARACTER) is do io.error.putchar (c) end;

end

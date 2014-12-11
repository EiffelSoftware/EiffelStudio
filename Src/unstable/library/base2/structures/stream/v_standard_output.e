note
	description: "Streams that output textual representation of values to the console."
	author: "Nadia Polikarpova"
	model: separator

class
	V_STANDARD_OUTPUT

inherit
	V_OUTPUT_STREAM [detachable ANY]
		redefine
			default_create
		end

create
	default_create,
	make_with_separator

feature {NONE} -- Initialization

	default_create
			-- Create a stream with `default_separator'.
		do
			make_with_separator (default_separator)
		ensure then
			separator_effect: separator = default_separator
		end

	make_with_separator (sep: STRING)
			-- Create a stream and set `separator' to `s'.
		do
			separator := sep
		ensure
			separator_effect: separator = sep
		end

feature -- Access

	separator: STRING
			-- String that is output after every element.

	default_separator: STRING = " "
			-- Default value of `separator'.			

feature -- Status report

	off: BOOLEAN = False
			-- Is current position off scope?

feature -- Replacement

	output (v: detachable ANY)
			-- Put `v' into the stream and move to the next position.
		note
			modify: nothing__
		do
			print (v)
			print (separator)
		end

end

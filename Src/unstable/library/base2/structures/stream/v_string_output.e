note
	description: "Streams that output textual representation of values to a string."
	author: "Nadia Polikarpova"
	model: destination, separator

class
	V_STRING_OUTPUT

inherit
	V_OUTPUT_STREAM [detachable ANY]

create
	make,
	make_with_separator

feature {NONE} -- Initialization

	make (dest: STRING)
			-- Create a stream that outputs into `dest'.
			-- (Use `default_separator' as `separator').
		do
			make_with_separator (dest, default_separator)
		ensure
			string_effect: destination = dest
			separator_effect: separator = default_separator
		end

	make_with_separator (dest, sep: STRING)
			-- Create a stream that outputs into `dest'
			-- and uses `sep' as `separator'.
		do
			destination := dest
			separator := sep
		ensure
			string_effect: destination = dest
			separator_effect: separator = sep
		end

feature -- Access

	destination: STRING
			-- Destination string.

	separator: STRING
			-- String that is output after every element.

	default_separator: STRING = " "
			-- Default value of `separator'.

	Void_out: STRING = "Void"
			-- String representation of `Void'.			

feature -- Status report

	off: BOOLEAN = False
			-- Is current position off scope?

feature -- Replacement

	output (v: detachable ANY)
			-- Put `v' into the stream and move to the next position.
		note
			modify: destination
		do
			if v = Void then
				destination.append (Void_out)
			else
				destination.append (v.out)
			end
			destination.append (separator)
		ensure then
			string_effect_void: v = Void implies destination ~ (old destination.twin) + Void_out + separator
			string_effect_non_void: v /= Void implies destination ~ (old destination.twin) + v.out + separator
		end
end

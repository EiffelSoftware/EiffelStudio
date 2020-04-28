note

	description:

		"Generates sequence of unique names"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_UNIQUE_NAME_GENERATOR

inherit

	ANY

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make,
	make_with_string_stream

feature {NONE} -- Initialisation

	make (a_prefix: STRING)
			-- Create new unique name generator, which uses
			-- `a_prefix' as a prefix for its unique names.
		require
			a_prefix_not_void: a_prefix /= Void
		do
			prefixx := a_prefix
		ensure
			prefix_set: prefixx = a_prefix
		end

	make_with_string_stream (a_prefix: STRING)
			-- Create new unique name generator, which uses
			-- `a_prefix' as a prefix for its unique names.
			-- Create a new string stream which
		require
			a_prefix_not_void: a_prefix /= Void
		local
		do
			make (a_prefix)
			create output_string.make (20)
			if attached output_string as l_output_string then
				create {KL_STRING_OUTPUT_STREAM} output_stream.make (l_output_string)
			end
		ensure
			prefix_set: prefixx = a_prefix
			output_string_not_void: output_string /= Void
			output_stream_not_void: output_stream /= Void
		end

feature {ANY} -- Access

	output_stream: detachable KI_CHARACTER_OUTPUT_STREAM
			-- Output stream to append next unique name to

	output_string: detachable STRING
			-- Output string. Only valid when `Current' was created with
			-- `make_with_string_stream'. Note that with multiple calls to
			-- `generate_new_name' the generated names will be appended to
			-- `output_string'. It might be a good idea to call
			-- `output_string.wipe_out' after `generate_new_name'.

	prefixx: STRING

feature {ANY} -- Basic operations

	set_output_stream (a_output_stream: KI_CHARACTER_OUTPUT_STREAM)
			-- Set `output_stream'
		require
			a_output_stream_not_void: a_output_stream /= Void
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
		end

	generate_new_name
			-- Generate new unique name and append it to
			-- `output_stream'.
		require
			output_stream_not_void: output_stream /= Void
		do
			if attached output_stream as l_output_stream then
				index := index + 1
				l_output_stream.put_string (prefixx)
				l_output_stream.put_integer (index)
			end
		end

feature {NONE} -- Implementation

	index: INTEGER

end

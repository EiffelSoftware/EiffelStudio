indexing

	description:

		""

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class DRC_STREAM_WRITER

inherit
	
	DRC_FORMATTED_TEXT_WRITER

create

	make

feature {NONE} -- Initialization

	make (a_output_stream: like output_stream) is
		require
			a_output_stream_not_void: a_output_stream /= Void
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
		end

	make_string (a_string: STRING) is
		require
			a_string_not_void: a_string /= Void
		do
			create {KL_STRING_OUTPUT_STREAM} output_stream.make (a_string)
		end

feature {ANY} -- Basic Queries

	output_stream: KI_TEXT_OUTPUT_STREAM
	
feature

	put_string (a_string: STRING) is
		do
			output_stream.put_string (a_string)
		end

	begin_emphasis is
		do
		end

	end_emphassis is
		do
		end

	put_link (a_url, a_title: STRING) is
		do
			put_string (a_string)
			put_string (" (")
			put_string (a_url)
			put_string (")")
		end

	begin_paragraph is
		do
			output_stream.put_new_line
		end

	end_paragraph is
		do
			output_stream.put_new_line
			output_stream.put_new_line
		end

	begin_unordered_list is
		do
			output_stream.put_new_line
		end

	end_unordered_list is
		do
			output_stream.put_new_line
		end

	begin_list_item is
		do
			put_string ("  *")
		end

	end_list_item is
		do
			output_stream.put_new_line
		end

	begin_code is
		do
		end

	end_code is
		do
		end
	
	put_new_line is
		do
			output_stream.put_new_line
		end
	
invariant

	output_stream_not_void: output_stream /= Void
	
end

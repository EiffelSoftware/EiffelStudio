indexing
	description: "Exception object for EiffelVision, will be replaced when exception objects are available"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEPTION

create
	make_with_tag_and_trace


feature {NONE} -- Initialization

	make_with_tag_and_trace (a_tag, a_trace_string: STRING) is
			-- Make `Current' with `tag' set to `a_tag' and `trace_as_string' set to `a_trace_string'
		require
			tag_not_void: a_tag /= Void
			trace_string_not_void: a_trace_string /= Void
		do
			tag := a_tag
			trace_as_string := a_trace_string
		ensure
			tag_set: tag.is_equal (a_tag)
			trace_as_string_set: trace_as_string.is_equal (a_trace_string)
		end
		
feature -- Access

	tag: STRING
		-- Exception tag of `Current'

	trace_as_string: STRING
		-- Exception trace represented as a string

end

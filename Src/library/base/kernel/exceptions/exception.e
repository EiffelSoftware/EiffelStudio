indexing
	description: "Exception object for EiffelVision, will be replaced when exception objects are available"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	trace_as_string: STRING;
		-- Exception trace represented as a string

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end

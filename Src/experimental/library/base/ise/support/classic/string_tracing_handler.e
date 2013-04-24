note
	description: "Abstract class to dispatch tracing events to user using TYPE and STRING data."
	legal: "See notice at end of class."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"

deferred class
	STRING_TRACING_HANDLER

inherit
	TRACING_HANDLER
		rename
			trace as internal_trace
		end

feature -- Tracing

	trace (a_type: TYPE [detachable ANY]; a_class_name, a_feature_name: detachable STRING; a_depth: INTEGER; a_is_entering: BOOLEAN)
			-- Trigger a trace operation from a feature represented by `a_feature_name' defined in
			-- class `a_class_name' and applied to an object of type `a_type' at a call depth `a_depth'.
			-- If `a_is_entering' we are entering the routine, otherwise we are exiting it.			
		require
			a_depth_non_negative: a_depth >= 0
		deferred
		end

feature {NONE} -- Implementation

	frozen internal_trace (a_type_id: INTEGER; a_c_class_name, a_c_feature_name: POINTER; a_depth: INTEGER; a_is_entering: BOOLEAN)
			-- Convert arguments `a_c_class_name' and `a_c_feature_name' to STRINGs and execute `trace'.
		local
			l_class_name: STRING
			l_type: TYPE [detachable ANY]
			l_buffer: like c_buffer
		do
			l_type := internal.type_of_type (a_type_id)
			if a_c_class_name /= default_pointer and a_c_feature_name /= default_pointer then
				l_buffer := c_buffer
				l_buffer.set_shared_from_pointer (a_c_class_name)
				l_class_name := l_buffer.string
				l_buffer.set_shared_from_pointer (a_c_feature_name)
				trace (l_type, l_class_name, l_buffer.string, a_depth, a_is_entering)
			else
				trace (l_type, Void, Void, a_depth, a_is_entering)
			end
		end

	internal: REFLECTOR
			-- Quick access to features of INTERNAL
		once ("THREAD")
			create Result
		ensure
			internal_not_void: Result /= Void
		end

	c_buffer: C_STRING
			-- Buffer to convert C strings to Eiffel strings
		once ("THREAD")
			create Result.make_empty (0)
		ensure
			c_buffer_not_void: Result /= Void
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

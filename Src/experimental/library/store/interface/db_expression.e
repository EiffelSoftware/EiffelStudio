note

	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"
	product: "EiffelStore"
	database: "All bases"

deferred class DB_EXPRESSION inherit

	STRING_HDL

feature -- Status report

	last_query: detachable STRING
			-- Last SQL statement used
		obsolete
			"Use `last_query_32' instead [2017-11-30]."
		do
			if attached last_query_32 as l_str then
				Result := l_str.as_string_8
			end
		end

	last_query_32: detachable STRING_32
			-- Last SQL statement used

	is_executable: BOOLEAN
			-- Is the query executable?
		do
			Result := attached last_query_32
		end

	is_affected_row_count_supported: BOOLEAN
			-- Is `affected_row_count' supported?
		deferred
		end

	affected_row_count: INTEGER_32
			-- The number of rows changed, deleted, or inserted by the last statement
		require
			is_affected_row_count_supported: is_affected_row_count_supported
		deferred
		end

feature -- Status setting

	set_query (query: READABLE_STRING_GENERAL)
			-- Set `last_query_32' with `query'.
		require
			query_not_void: query /= Void
		do
			last_query_32 := query.as_string_32
		ensure
			last_query_32_changed: attached last_query_32 as lt_s and then lt_s.same_string (query.as_string_32)
		end

feature -- Basic operations

	execute_query
			-- Execute `last_query'.
		require
			is_executable: is_executable
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DB_EXPRESSION




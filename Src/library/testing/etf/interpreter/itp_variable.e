note
	description: "[
		Objects representing variables.
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class ITP_VARIABLE

inherit

	ITP_EXPRESSION
		undefine
			is_equal
		end

	HASHABLE
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_index: INTEGER)
			-- Create new variable with `a_index'.
		require
			a_index_positive: a_index > 0
		do
			index := a_index
		ensure
			index_set: index = a_index
		end

feature -- Access

	name (a_prefix: STRING): STRING
			-- Name of variable
			-- Return a new string every time.
		require
			a_prefix_attached: a_prefix /= Void
			not_a_prefix_is_empty: not a_prefix.is_empty
		do
			create Result.make (5)
			Result.append (a_prefix)
			Result.append (index.out)
		ensure
			result_attached: Result /= Void
			good_result: Result.is_equal (a_prefix + index.out)
		end

	hash_code: INTEGER
		do
			Result := index
		ensure then
			good_result: Result = index
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := (index = other.index)
		ensure then
			good_result: Result = (index = other.index)
		end

	index: INTEGER
			-- Index of current variable

feature -- Processing

	process (a_processor: ITP_EXPRESSION_PROCESSOR)
		do
			a_processor.process_variable (Current)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

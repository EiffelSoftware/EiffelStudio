note
	description: "[
		EQA_RESULT which represents a failed execution.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EMPTY_RESULT

inherit
	EQA_RESULT

create
	make

feature {NONE} -- Initialization

	make (a_tag: READABLE_STRING_8; an_output: detachable READABLE_STRING_8)
			-- Initialize `Current' indicating that test could not be executed at all.
			--
			-- `a_tag': Short tag describing reason for error.
		require
			a_tag_attached: a_tag /= Void
		do
			create tag.make_from_string (a_tag)
			create date.make_now
			if an_output /= Void then
				create information.make_from_string (an_output)
			else
				create information.make_empty
			end
		ensure
			tag_set: tag.same_string (a_tag)
			information_set: attached an_output as l_output implies information.same_string (l_output)
		end

feature -- Access

	date: DATE_TIME
			-- <Precursor>

	tag: IMMUTABLE_STRING_8
			-- <Precursor>

	information: IMMUTABLE_STRING_8
			-- <Precursor>

feature -- Status report

	is_pass: BOOLEAN = False
			-- <Precursor>

	is_fail: BOOLEAN = False
			-- <Precursor>

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

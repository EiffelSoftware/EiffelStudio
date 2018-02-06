note
	description : "Objects that represent a group of errors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_GROUP

inherit
	ERROR

create
	make

feature {NONE} -- Initialization

	make (a_errors: LIST [ERROR])
			-- Initialize `Current'.
		do
			name := a_errors.count.out + " errors"
			create {ARRAYED_LIST [ERROR]} sub_errors.make (a_errors.count)
			sub_errors.fill (a_errors)
		end

feature -- Access

	code: INTEGER = -1

	name: STRING

	message: STRING_32
		do
			create Result.make_from_string (name)
			across
				sub_errors as s
			loop
				if
					attached s.item as e and then
					attached e.message as m
				then
					Result.append_character ('%N')
					Result.append_string (m)
				end
			end
		end

	sub_errors: LIST [ERROR]
			-- Error contained by Current.

feature -- Visitor

	process (a_visitor: ERROR_VISITOR)
			-- Process Current using `a_visitor'.
		do
			a_visitor.process_group (Current)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

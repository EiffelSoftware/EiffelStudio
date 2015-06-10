note
	description: "Simple counter component."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_COUNTER

create
	put

feature

	item: INTEGER

	put, replace (i: INTEGER)
		do
			item := i
		end

	next_item: INTEGER
		do
			Result := item + 1
			item := Result
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

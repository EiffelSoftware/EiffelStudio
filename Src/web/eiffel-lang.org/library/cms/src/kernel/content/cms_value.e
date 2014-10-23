note
	description: "Summary description for {CMS_VALUE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_VALUE

inherit

	STRING_TABLE[ANY]
		rename
			make as old_make,
			make_caseless as make
		redefine
			empty_duplicate
		end

create
	make

feature {NONE} -- Duplication

	empty_duplicate (n: INTEGER): like Current
			-- Create an empty copy of Current that can accommodate `n' items
		do
			create Result.make (n)
		end
note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

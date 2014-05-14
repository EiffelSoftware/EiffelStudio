note
	description: "Summary description for {WSF_SESSION_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SESSION_DATA

inherit
	STRING_TABLE [detachable ANY]
		rename
			make as old_make,
			make_caseless as make
		redefine
			empty_duplicate
		end

create
	make

feature -- Access

	expiration: detachable DATE_TIME

feature -- Element change

	set_expiration (dt: like expiration)
		do
			expiration := dt
		end

feature {NONE} -- Duplication

	empty_duplicate (n: INTEGER): like Current
			-- Create an empty copy of Current that can accommodate `n' items
		do
			create Result.make (n)
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

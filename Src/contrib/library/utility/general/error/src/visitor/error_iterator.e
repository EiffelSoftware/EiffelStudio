note
	description : "Error list iterator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_ITERATOR

inherit
	ERROR_VISITOR

feature -- Access

	process_error (e: ERROR)
		do
		end

	process_custom (e: ERROR_CUSTOM)
		do
			process_error (e)
		end

	process_group (g: ERROR_GROUP)
		do
			if attached g.sub_errors as err then
				from
					err.start
				until
					err.after
				loop
					process_error (err.item)
					err.forth
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

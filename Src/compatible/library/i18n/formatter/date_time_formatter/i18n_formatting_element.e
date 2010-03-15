note
	description: "Common ancestor for all formatting elements"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_FORMATTING_ELEMENT

feature -- Output

	filled (a_date: DATE; a_time: TIME): STRING_32
 			-- fill `Current' with informations
 			-- in `a_date' and `a_time'
 		require
 			a_date_exists: a_date /= Void
 			a_time_exists: a_time /= Void
 		deferred
		ensure
			result_exists: Result /= Void
 		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

note
	description: "[
		Common ancestor for all mock classes used to test the testing framework.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TET_MOCK

inherit
	DISPOSABLE_SAFE

feature {NONE} -- Cleaning

	frozen safe_dispose (an_explicit: BOOLEAN)
			-- <Precursor>
		do
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

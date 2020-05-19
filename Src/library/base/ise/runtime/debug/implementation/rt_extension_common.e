note
	description: "Common routine for RT_EXTENSION classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_EXTENSION_COMMON

feature -- Trace

	dtrace_indent (n: INTEGER)
			-- note: might be removed with 6.2
		do
			io.error.put_string_32 (create {STRING_32}.make_filled (' ', 2 * n))
		end

	dtrace (m: READABLE_STRING_32)
			-- note: might be be removed with 6.2	
		require
			m_attached: m /= Void
		do
			io.error.put_string_32 (m)
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

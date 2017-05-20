note
	description: "Information about the current thread execution"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_ENVIRONMENT

feature -- Access

	current_thread_id: POINTER
			-- Thread identifier of the Current thread	
		do
			if attached {SYSTEM_THREAD}.current_thread as l_thread then
				Result := default_pointer + l_thread.managed_thread_id
			end
		end

	get_current_id: POINTER
			-- Returns a pointer to the thread-id of the thread.
		obsolete
			"Use `current_thread_id' instead. [2017-05-31]"
		do
			Result := current_thread_id
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

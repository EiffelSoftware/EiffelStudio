note
	description: "Utility class for executing code with exclusive access. {SSL_EXCLUSIVE_ACCESS}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_EXCLUSIVE_ACCESS

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialize

	default_create
			-- <Precursor>
		do
			create mutex.make
		end

	mutex: MUTEX
		-- mutex

feature -- Calls
	
	call (action: separate PROCEDURE)
			-- call action.
		do
			action.call
		end

feature -- Access

	enter
			-- Enter exclusive section.
		do
			mutex.lock
		end

	leave
			-- Enter exclusive section.
		do
			mutex.unlock
		end


note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
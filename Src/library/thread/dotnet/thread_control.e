note
	description: "Control over thread execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_CONTROL

inherit
	THREAD_ENVIRONMENT

feature -- Basic operations

	join_all
			-- The calling thread waits for all other threads to terminate.
		do
			(create {THREAD_DOTNET_CONTROL}).join_all
		end

	yield
			-- The calling thread yields its execution in favor of another
			-- thread.
		do
			{SYSTEM_THREAD}.sleep(0)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

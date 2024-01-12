note
	description: "[
			Objects that manage the Eiffel tracing. You can start and
			stop the Eiffel tracing whenever you want to. It only works
			if `trace (yes)' is enabled in your project configuration file.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TRACING_SETTING

feature -- Status report

	is_tracing: BOOLEAN
			-- Is tracing currently enabled?
		require
			valid_platform: not {PLATFORM}.is_dotnet
		do
		end

feature -- Status setting

	enable_tracing
			-- Start tracing.
		require
			valid_platform: not {PLATFORM}.is_dotnet
		do
		ensure
			class
		end

	disable_tracing
			-- Stop tracing
		require
			valid_platform: not {PLATFORM}.is_dotnet
		do
		ensure
			class
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

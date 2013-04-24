note
	description: "Widget that allows you to add a Windows as your child if you know its HANDLE."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PLUG

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			is_in_default_state
		end

create
	make

feature {NONE} -- Initialization

	make (a_native_window_handle: POINTER)
			-- Create a plug widget using `a_native_window_handle' window handle.
		require
			is_windows: {PLATFORM}.is_windows
			a_handle_not_null: a_native_window_handle /= default_pointer
		do
			handle := a_native_window_handle
			default_create
		end

feature -- Access

	handle: POINTER
		-- Window Handle controlled by `Current'.

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PLUG_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PLUG_IMP} implementation.make (handle)
		end

	is_in_default_state: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

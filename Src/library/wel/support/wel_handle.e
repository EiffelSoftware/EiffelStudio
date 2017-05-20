note
	description: "Windows HANDLE that has to be closed after use."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HANDLE

inherit
	DISPOSABLE
		redefine
			copy
		end

create
	make

feature {NONE} -- Creation

	make (value: like item)
		do
			item := value
		end

feature -- Status report

	is_open: BOOLEAN
			-- Is handle open?
		do
			Result := item /= default_pointer
		end

feature -- Access

	item: POINTER
			-- Handle value.

feature -- Duplication

	copy (other: WEL_HANDLE)
			-- Raise an excepion.
			-- (Handle duplication is not supported.)
		do
			check
				can_copy: False
			then
			end
		end

feature -- Status setting

	close
			-- Close handle.
		require
			is_open
		do
			if {WEL_API}.close_handle (item) = 0 then end
			item := default_pointer
		ensure
			not is_open
		end

	checked_close: BOOLEAN
			-- Close handle and report whether the operation was successful.
		require
			is_open
		do
			Result := {WEL_API}.close_handle (item) /= 0
			item := default_pointer
		ensure
			not is_open
		end

feature -- Disposal

	dispose
		do
			if is_open then
				close
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

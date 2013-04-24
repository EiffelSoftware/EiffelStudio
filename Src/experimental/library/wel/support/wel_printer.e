note
	description: "Facilities for printing and get printer information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PRINTER

inherit
	WEL_ANY

create
	make,
	make_with_name

feature

	make
			-- Initialize Current with default printer if any.
		local
			l_printer_name: WEL_STRING
			l_length: INTEGER
			l_error_code: INTEGER
		do
			create l_printer_name.make_empty (256)
			l_length := 256
			if not {WEL_API}.get_default_printer (l_printer_name.item, $l_length, $l_error_code) then
				if l_error_code = {WEL_WINDOWS_ERROR_MESSAGES}.Error_insufficient_buffer_value then
					create l_printer_name.make_empty (l_length)
					if {WEL_API}.get_default_printer (l_printer_name.item, $l_length, $l_error_code) then
						make_with_name (l_printer_name.substring (1, l_length))
					end
				end
			else
				make_with_name (l_printer_name.substring (1, l_length))
			end
		end


	make_with_name (a_name: READABLE_STRING_GENERAL)
			-- Initialize Current with printer `a_name'.
		local
			l_name: WEL_STRING
			l_handle: POINTER
		do
			create l_name.make (a_name)
			if {WEL_API}.open_printer (l_name.item, $l_handle, default_pointer) then
				item := l_handle
			end
		end

feature -- Access

	printer_info_2: detachable WEL_PRINTER_INFO_2
			-- Printer information associated with current printer if available.
		require
			exists: exists
		local
			l_needed: INTEGER
			l_error_code: INTEGER
		do
			if
				not {WEL_API}.get_printer (item, 2, default_pointer, 0, $l_needed, $l_error_code) and then
				l_error_code = {WEL_WINDOWS_ERROR_MESSAGES}.Error_insufficient_buffer_value
			then
					-- This is expected to fail and now `l_needed' should have the expected
					-- buffer size
				create Result.make_with_size (l_needed)
				l_error_code := 0
				if not {WEL_API}.get_printer (item, 2, Result.item, l_needed, $l_needed, $l_error_code) then
						-- We could not get the printer info.
					Result := Void
				end
			end
		end

feature {NONE} -- Removal

	destroy_item
			-- Destroy associated printer underlying datastructure.
		do
			if {WEL_API}.close_printer (item) then
			end
			item := default_pointer
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

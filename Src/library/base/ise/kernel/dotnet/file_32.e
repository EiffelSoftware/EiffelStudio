note
	description: "Same as {FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILE_32

inherit
	FILE
		rename
			change_name as change_name_8,
			make as make_8,
			name as name_8,
			reset as reset_8
		redefine
			set_buffer
		end

feature {NONE} -- Creation

	make (fn: STRING_32)
			-- Create file object with `fn' as file name.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		local
			u: UTF_CONVERTER
		do
				-- Encode name as UTF-8.
			make_8 (u.string_32_to_utf_8_string_8 (fn))
			create internal_file.make (fn.to_cil)
		ensure
			file_named: name.same_string (fn)
			file_closed: is_closed
		end

feature -- Access

	name: STRING_32
			-- File name.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32 (name_8)
		end

feature -- Modification

	reset (fn: STRING_32)
			-- Change file name to `fn' and reset
			-- file descriptor and all information.
		require
			valid_file_name: fn /= Void
		local
			u: UTF_CONVERTER
		do
				-- Encode name as UTF-8.
			reset_8 (u.string_32_to_utf_8_string_8 (fn))
			make (fn)
		ensure
			file_renamed: name.same_string (fn)
			file_closed: is_closed
		end

	change_name (new_name: STRING_32)
			-- Change file name to `new_name'
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
			file_exists: exists
		local
			l_info: FILE_INFO
			u: UTF_CONVERTER
		do
			create l_info.make (new_name.to_cil)
			if l_info.exists and not same_file (new_name) then
				l_info.delete
			end
			internal_file.refresh
			internal_file.move_to (new_name.to_cil)
			name_8 := u.string_32_to_utf_8_string_8 (new_name)
		ensure
			name_changed: name ~ new_name
		end

feature {NONE} -- Status setting

	set_buffer
			-- <Precursor>
		do
			buffered_file_info.update (name)
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

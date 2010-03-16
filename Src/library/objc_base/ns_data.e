note
	description: "Summary description for {NS_DATA}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DATA

inherit
	NS_OBJECT
		undefine
			copy
		end

	NS_COPYING

create {NS_OBJECT}
	share_from_pointer

feature -- Creating Data Objects

--	make_with_bytes_length (a_bytes: POINTER; a_length: INTEGER): NS_OBJECT
--		do
--			{NS_DATA_API}.init_with_bytes_length (item, a_bytes, a_length)
--		end

--	init_with_bytes_no_copy_length (a_bytes: ; a_length: INTEGER): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_bytes_no_copy_length (item, a_bytes.item, a_length, Result.item)
--		end

--	init_with_bytes_no_copy_length_free_when_done (a_bytes: ; a_length: INTEGER; a_b: BOOLEAN): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_bytes_no_copy_length_free_when_done (item, a_bytes.item, a_length, a_b, Result.item)
--		end

--	init_with_contents_of_file_options_error (a_path: NS_STRING; a_read_options_mask: INTEGER; a_error_ptr: POINTER[NS_ERROR]): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_contents_of_file_options_error (item, a_path.item, a_read_options_mask, a_error_ptr.item, Result.item)
--		end

--	init_with_contents_of_url_options_error (a_url: NSURL; a_read_options_mask: INTEGER; a_error_ptr: POINTER[NS_ERROR]): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_contents_of_url_options_error (item, a_url.item, a_read_options_mask, a_error_ptr.item, Result.item)
--		end

--	init_with_contents_of_file (a_path: NS_STRING): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_contents_of_file (item, a_path.item, Result.item)
--		end

--	init_with_contents_of_url (a_url: NSURL): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_contents_of_url (item, a_url.item, Result.item)
--		end

--	init_with_contents_of_mapped_file (a_path: NS_STRING): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_contents_of_mapped_file (item, a_path.item, Result.item)
--		end

--	init_with_data (a_data: NS_DATA): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_data (item, a_data.item, Result.item)
--		end

feature -- Accessing Data

	bytes: POINTER
		do
			Result := {NS_DATA_API}.bytes (item)
		end

	description: NS_STRING_BASE
		do
			create Result.share_from_pointer ({NS_DATA_API}.description (item))
		end

	get_bytes (a_buffer: POINTER)
		do
			{NS_DATA_API}.get_bytes (item, a_buffer.item)
		end


	get_bytes_length (a_buffer: POINTER; a_length: INTEGER)
		do
			{NS_DATA_API}.get_bytes_length (item, a_buffer.item, a_length)
		end

	get_bytes_range (a_buffer: POINTER; a_range: NS_RANGE)
		do
			{NS_DATA_API}.get_bytes_range (item, a_buffer.item, a_range.item)
		end

	subdata_with_range (a_range: NS_RANGE): NS_DATA
		do
			create Result.share_from_pointer ({NS_DATA_API}.subdata_with_range (item, a_range.item))
		end

feature -- Testing Data

	length: INTEGER
		do
			Result := {NS_DATA_API}.length (item)
		end

	is_equal_to_data (a_other: NS_DATA): BOOLEAN
		do
			Result := {NS_DATA_API}.is_equal_to_data (item, a_other.item)
		end

feature -- Storing Data

	write_to_file_atomically (a_path: NS_STRING_BASE; a_use_auxiliary_file: BOOLEAN): BOOLEAN
			-- Writes the bytes in the receiver to the file specified by a given path.
			-- Returns True if the operation succeeds.
		do
			Result := {NS_DATA_API}.write_to_file_atomically (item, a_path.item, a_use_auxiliary_file)
		end

--	write_to_url_atomically (a_url: NS_URL; a_atomically: BOOLEAN): BOOLEAN
--		do
--			Result := {NS_DATA_API}.write_to_url_atomically (item, a_url.item, a_atomically)
--		end

--	write_to_file_options_error (a_path: NS_STRING; a_write_options_mask: INTEGER; a_error_ptr: POINTER[NS_ERROR]): BOOLEAN
--		do
--			Result := {NS_DATA_API}.write_to_file_options_error (item, a_path.item, a_write_options_mask, a_error_ptr.item)
--		end

--	write_to_url_options_error (a_url: NS_URL; a_write_options_mask: INTEGER; a_error_ptr: POINTER[NS_ERROR]): BOOLEAN
--		do
--			Result := {NS_DATA_API}.write_to_url_options_error (item, a_url.item, a_write_options_mask, a_error_ptr.item)
--		end

--	mutable_bytes:
--		do
--			create Result.make_shared ({NS_DATA_API}.mutable_bytes (item))
--		end

--	set_length (a_length: INTEGER)
--		do
--			{NS_DATA_API}.set_length (item, a_length)
--		end

--	append_bytes_length (a_bytes: ; a_length: INTEGER)
--		do
--			{NS_DATA_API}.append_bytes_length (item, a_bytes.item, a_length)
--		end

--	append_data (a_other: NS_DATA)
--		do
--			{NS_DATA_API}.append_data (item, a_other.item)
--		end

--	increase_length_by (a_extra_length: INTEGER)
--		do
--			{NS_DATA_API}.increase_length_by (item, a_extra_length)
--		end

--	replace_bytes_in_range_with_bytes (a_range: NS_RANGE; a_bytes: )
--		do
--			{NS_DATA_API}.replace_bytes_in_range_with_bytes (item, a_range.item, a_bytes.item)
--		end

--	reset_bytes_in_range (a_range: NS_RANGE)
--		do
--			{NS_DATA_API}.reset_bytes_in_range (item, a_range.item)
--		end

--	set_data (a_data: NS_DATA)
--		do
--			{NS_DATA_API}.set_data (item, a_data.item)
--		end

--	replace_bytes_in_range_with_bytes_length (a_range: NS_RANGE; a_replacement_bytes: ; a_replacement_length: INTEGER)
--		do
--			{NS_DATA_API}.replace_bytes_in_range_with_bytes_length (item, a_range.item, a_replacement_bytes.item, a_replacement_length)
--		end

--	init_with_capacity (a_capacity: INTEGER): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_capacity (item, a_capacity, Result.item)
--		end

--	init_with_length (a_length: INTEGER): NS_OBJECT
--		do
--			create Result.make
--			{NS_DATA_API}.init_with_length (item, a_length, Result.item)
--		end

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

note
	description: "A low-level string class to solve some garbage collector problems (mainly objects moving around) when interfacing with C APIs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

inherit
	DISPOSABLE

	STRING_HANDLER

	NATIVE_STRING_HANDLER

create
	set_with_eiffel_string, share_from_pointer, make_from_pointer, make_from_path

convert
	set_with_eiffel_string ({READABLE_STRING_GENERAL, STRING_8, STRING_32})

feature {NONE} -- Initialization

	make_from_pointer (a_utf8_ptr: POINTER)
			-- Set `item' to `a_utf8_ptr' and gain ownership of memory.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		do
			set_from_pointer (a_utf8_ptr, c_strlen (a_utf8_ptr) + 1,  False)
		end

	make_from_path (a_path: PATH)
			-- Set `item' to the content of `a_path'.
		require
			attached a_path
		local
			s: STRING_8
			n: like {STRING_8}.count
			a: ANY
		do
			if {PLATFORM}.is_dotnet then
				set_with_eiffel_string (a_path.utf_8_name)
			else
				s := a_path.utf_8_name
				n := s.count
				item := {GLIB}.g_malloc (n + 1)
				a := s.to_c
				item.memory_copy ($a, n + 1)
				string_length := n
				is_shared := False
			end
		end

feature -- Access

	is_shared: BOOLEAN
		-- Is `item' shared with gtk?

	item: POINTER
			-- Pointer to the UTF8 string.

	string: STRING_32
			-- Locale string representation of the UTF8 string
		local
			l_ptr: MANAGED_POINTER
		do
			l_ptr := shared_pointer_helper
			l_ptr.set_from_pointer (item, string_length)
			Result := {UTF_CONVERTER}.utf_8_0_pointer_to_escaped_string_32 (l_ptr)

				-- Reset shared pointer.
			l_ptr.set_from_pointer (default_pointer, 0)
		end

	string_length: INTEGER
			-- Length of string data held in `managed_data'

	set_with_eiffel_string (a_string: READABLE_STRING_GENERAL)
			-- Create `item' and retain ownership.
		require
			a_string_not_void: a_string /= Void
		do
			internal_set_with_eiffel_string (a_string, False)
		ensure
			string_set: string.same_string_general (a_string)
		end

	share_with_eiffel_string (a_string: READABLE_STRING_GENERAL)
			-- Create `item' but do not take ownership.
		require
			a_string_not_void: a_string /= Void
		do
			internal_set_with_eiffel_string (a_string, True)
		ensure
			string_set: string.same_string_general (a_string)
		end

	share_from_pointer (a_utf8_ptr: POINTER)
			-- Set `Current' to use `a_utf8_ptr'.
			-- `a_utf8_ptr' is not owned by `Current' as it isn't copied so do not free from outside.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		do
			set_from_pointer (a_utf8_ptr, c_strlen (a_utf8_ptr) + 1, True)
		end

feature {NONE} -- Implementation

	shared_pointer_helper: MANAGED_POINTER
			-- Reusable Managed Pointer for UTF8 pointer manipulations.
		once
			create Result.share_from_pointer (default_pointer, 0)
		end

	internal_set_with_eiffel_string (a_string: READABLE_STRING_GENERAL; a_shared: BOOLEAN)
			-- Create a UTF8 string from Eiffel String `a_string'
		require
			a_string_not_void: a_string /= Void
		local
			utf8_ptr: POINTER
			bytes_written: INTEGER
			i: INTEGER
			l_code: NATURAL_32
			l_string_length: INTEGER
			l_ptr: MANAGED_POINTER
		do
			l_string_length := a_string.count

				-- First compute how many bytes we need to convert `a_string' to UTF-8.
			from
				i := l_string_length
			until
				i = 0
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
					bytes_written := bytes_written + 1
				elseif l_code <= 0x7FF then
					bytes_written := bytes_written + 2
				elseif l_code <= 0xFFFF then
					bytes_written := bytes_written + 3
				else -- l_code <= 0x10FFFF
					bytes_written := bytes_written + 4
				end
				i := i - 1
			end

				-- Fill `utf_ptr8' with the converted data.
			from
				i := 1
				if item /= default_pointer and then not is_shared then
						-- Reuse memory pointed to by `item' instead of freeing it.
					utf8_ptr := {GLIB}.g_realloc (item, bytes_written + 1)
						-- Set `item' to `default_pointer' so that it won't be GC'd.
					item := default_pointer
				else
					utf8_ptr := {GLIB}.g_malloc (bytes_written + 1)
				end
				l_ptr := shared_pointer_helper
				l_ptr.set_from_pointer (utf8_ptr, bytes_written + 1)
				bytes_written := 0
					-- TODO: Use `{UTF_CONVERTER}`.
			until
				i > l_string_length
			loop
				l_code := a_string.code (i)
				if l_code <= 127 then
						-- Of the form 0xxxxxxx.
					l_ptr.put_natural_8 (l_code.to_natural_8, bytes_written)
					bytes_written := bytes_written + 1
				elseif l_code <= 0x7FF then
						-- Insert 110xxxxx 10xxxxxx.
					l_ptr.put_natural_8 ((0xC0 | (l_code |>> 6)).to_natural_8, bytes_written)
					l_ptr.put_natural_8 ((0x80 | (l_code & 0x3F)).to_natural_8, bytes_written + 1)
					bytes_written := bytes_written + 2
				elseif l_code <= 0xFFFF then
						-- Start with 1110xxxx
					l_ptr.put_natural_8 ((0xE0 | (l_code |>> 12)).to_natural_8, bytes_written)
					l_ptr.put_natural_8 ((0x80 | ((l_code |>> 6) & 0x3F)).to_natural_8, bytes_written+1)
					l_ptr.put_natural_8 ((0x80 | (l_code & 0x3F)).to_natural_8, bytes_written+2)
					bytes_written := bytes_written + 3
				else -- l_code <= 0x10FFFF then
						-- Start with 11110xxx
					check
						max_4_bytes: l_code <= 0x10FFFF
						-- UTF-8 has been restricted to 4 bytes characters
					end
					l_ptr.put_natural_8 ((0xF0 | (l_code |>> 18)).to_natural_8, bytes_written)
					l_ptr.put_natural_8 ((0x80 | ((l_code |>> 12) & 0x3F)).to_natural_8, bytes_written+1)
					l_ptr.put_natural_8 ((0x80 | ((l_code |>> 6) & 0x3F)).to_natural_8, bytes_written+2)
					l_ptr.put_natural_8 ((0x80 | (l_code & 0x3F)).to_natural_8, bytes_written+3)
					bytes_written := bytes_written + 4
				end
				i := i + 1
			end
			l_ptr.put_integer_8 (0, bytes_written)

				-- The value of bytes_written doesn't take the null character in to account.
			set_from_pointer (utf8_ptr, bytes_written + 1, a_shared)

				-- Reset shared pointer helper.
			l_ptr.set_from_pointer (default_pointer, 0)
		end

	set_from_pointer (a_ptr: POINTER; a_size: INTEGER; a_shared: BOOLEAN)
			--  Set `item' to use `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			size_valid: a_size > 0
		do
				-- Free existing memory, if any.
			dispose
			string_length := a_size - 1
			item := a_ptr
			is_shared := a_shared
		end

	dispose
			-- Dispose `Current'.
		do
				-- This routine is also called from `set_from_pointer'.
			if item /= default_pointer and then not is_shared then
				{GLIB}.g_free (item)
				item := default_pointer
			end
		end

feature {NONE} -- Externals

	c_strlen (ptr: POINTER): INTEGER
		external
			"C macro signature (char *): EIF_INTEGER use <string.h>"
		alias
			"strlen"
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

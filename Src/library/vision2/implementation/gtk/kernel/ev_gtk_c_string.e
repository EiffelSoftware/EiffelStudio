indexing
	description: "A low-level string class to solve some garbage collector problems (mainly objects moving around) when interfacing with C APIs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

inherit
	DISPOSABLE

create
	set_with_eiffel_string, share_from_pointer, make_from_pointer

convert
	set_with_eiffel_string ({STRING})

feature {NONE} -- Initialization

	make_from_pointer (a_utf8_ptr: POINTER) is
			-- Set `item' to `a_utf8_ptr' and gain ownership of memory.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		do
			set_from_pointer (a_utf8_ptr, byte_length_from_utf8_ptr (a_utf8_ptr),  False)
		end

feature -- Access

	is_shared: BOOLEAN
		-- Is `item' shared with gtk?

	item: POINTER
			-- Pointer to the UTF8 string.


	string: STRING is
			-- Locale string representation of the UTF8 string
		local
			l_ptr: MANAGED_POINTER
			l_nat8: NATURAL_8
			l_code: NATURAL_32
			i, nb: INTEGER
		do
			from
				i := 0
				nb := string_length
				l_ptr := shared_pointer_helper
				l_ptr.set_from_pointer (item, nb)
				create Result.make (nb)
			until
				i = nb
			loop
				l_nat8 := l_ptr.read_natural_8 (i)
				if l_nat8 <= 127 then
						-- Form 0xxxxxxx.
					Result.extend (l_nat8.to_character)

				elseif (l_nat8 & 0xE0) = 0xC0 then
						-- Form 110xxxxx 10xxxxxx.
					l_code := (l_nat8 & 0x1F).to_natural_32 |<< 6
					i := i + 1
					l_nat8 := l_ptr.read_natural_8 (i)
					l_code := l_code | (l_nat8 & 0x3F).to_natural_32
					Result.extend (l_code.to_character)

				elseif (l_nat8 & 0xF0) = 0xE0 then
					-- Form 1110xxxx 10xxxxxx 10xxxxxx.
					-- Not supported yet since Eiffel does not support character code greater than 255
					-- we replace it with space.
					Result.extend (' ')
					i := i + 2

				elseif (l_nat8 & 0xF8) = 0xF0 then
					-- Form 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx.
					-- Not supported yet since Eiffel does not support character code greater than 255
					-- we replace it with space.
					Result.extend (' ')
					i := i + 3
				end
				i := i + 1
			end
				-- Reset shared pointer.
			l_ptr.set_from_pointer (default_pointer, 0)
		end

	string_length: INTEGER
			-- Length of string data held in `managed_data'

	set_with_eiffel_string (a_string: STRING) is
			-- Create `item' and retain ownership.
		require
			a_string_not_void: a_string /= Void
		do
			internal_set_with_eiffel_string (a_string, False)
		ensure
			string_set: a_string.is_equal (string)
		end

	share_with_eiffel_string (a_string: STRING) is
			-- Create `item' but do not take ownership.
		require
			a_string_not_void: a_string /= Void
		do
			internal_set_with_eiffel_string (a_string, True)
		ensure
			string_set: a_string.is_equal (string)
		end

	share_from_pointer (a_utf8_ptr: POINTER) is
			-- Set `Current' to use `a_utf8_ptr'.
			-- `a_utf8_ptr' is not owned by `Current' as it isn't copied so do not free from outside.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		do
			set_from_pointer (a_utf8_ptr, byte_length_from_utf8_ptr (a_utf8_ptr), True)
		end

feature {NONE} -- Implementation

	shared_pointer_helper: MANAGED_POINTER is
			-- Reusable Managed Pointer for UTF8 pointer manipulations.
		once
			create Result.share_from_pointer (default_pointer, 0)
		end

	internal_set_with_eiffel_string (a_string: STRING; a_shared: BOOLEAN) is
			-- Create a UTF8 string from Eiffel String `a_string'
		require
			a_string_not_void: a_string /= Void
		local
			utf8_ptr: POINTER
			bytes_written: INTEGER
			i, l_code: INTEGER
			a_string_size: INTEGER
			l_string_length: INTEGER
			l_ptr: MANAGED_POINTER
		do
			l_string_length := a_string.count

				-- First compute how many bytes we need to convert `a_string' to UTF-8.
			from
				i := l_string_length
				bytes_written := 0
			until
				i = 0
			loop
				if a_string.item (i).code > 127 then
					bytes_written := bytes_written + 1
				end
				bytes_written := bytes_written + 1
				i := i - 1
			end

				-- Fill `utf_ptr8' with the converted data.
			from
				i := 1
				if item /= default_pointer and then not is_shared then
						-- Reuse memory pointed to by `item' instead of freeing it.
					utf8_ptr := {EV_GTK_EXTERNALS}.g_realloc (item, bytes_written + 1)
						-- Set `item' to `default_pointer' so that it won't be GC'd.
					item := default_pointer
				else
					utf8_ptr := {EV_GTK_EXTERNALS}.g_malloc (bytes_written + 1)
				end
				l_ptr := shared_pointer_helper
				l_ptr.set_from_pointer (utf8_ptr, bytes_written + 1)
				bytes_written := 0
			until
				i > l_string_length
			loop
				l_code := a_string.item (i).code
				if l_code <= 127 then
						-- Of the form 0xxxxxxx.
					l_ptr.put_natural_8 (l_code.to_natural_8, bytes_written)
				else
					check
						ascii_only: l_code <= 255
					end
						-- Insert 110xxxxx 10xxxxxx.
					l_ptr.put_natural_8 ((0xC0 | (l_code |>> 6)).to_natural_8, bytes_written)
					bytes_written := bytes_written + 1
					l_ptr.put_natural_8 ((0x80 | (l_code & 0x3F)).to_natural_8, bytes_written)
				end
				bytes_written := bytes_written + 1
				i := i + 1
			end
			l_ptr.put_integer_8 (0, bytes_written)

				-- The value of bytes_written doesn't take the null character in to account.
			a_string_size := bytes_written + 1
			set_from_pointer (utf8_ptr, a_string_size, a_shared)

				-- Reset shared pointer helper.
			l_ptr.set_from_pointer (default_pointer, 0)
		end

	set_from_pointer (a_ptr: POINTER; a_size: INTEGER; a_shared: BOOLEAN) is
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

	byte_length_from_utf8_ptr (a_utf8_ptr: POINTER): INTEGER is
			-- Length in bytes of UTF8 pointer `a_utf8_ptr'.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		local
			l_ptr: MANAGED_POINTER
			l_done: BOOLEAN
			l_nat8: NATURAL_8
		do
				-- We compute it ourself since we cannot trust GTK `g_utf8_validate'.
				-- This is a security risk as we don't know how much we can read, we limit ourself
				-- to the maximum we can allocate.
			l_ptr := shared_pointer_helper
			l_ptr.set_from_pointer (a_utf8_ptr, {INTEGER}.max_value)
			from
				Result := 0
			until
				l_done
			loop
				l_nat8 := l_ptr.read_natural_8 (Result)
				if l_nat8 <= 127 then
					l_done := l_nat8 = 0
				elseif (l_nat8 & 0xE0) = 0xC0 then
					Result := Result + 1
				elseif (l_nat8 & 0xF0) = 0xE0 then
					Result := Result + 2
				elseif (l_nat8 & 0xF8) = 0xF0 then
					Result := Result + 3
				end
				Result := Result + 1
			end
				-- Reset shared pointer helper.
			l_ptr.set_from_pointer (default_pointer, 0)
		end

	dispose is
			-- Dispose `Current'.
		do
				-- This routine is also called from `set_from_pointer'.
			if item /= default_pointer and then not is_shared then
				{EV_GTK_EXTERNALS}.g_free (item)
				item := default_pointer
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_C_STRING


indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

create
	make, make_from_pointer
	
	
feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Create a UTF8 string from `a_string'
		local
			utf8_ptr: POINTER
			string_value: ANY
			bytes_read, bytes_written, gerror: INTEGER
		do
			string_value := a_string.to_c
			utf8_ptr := feature {EV_GTK_DEPENDENT_EXTERNALS}.g_locale_to_utf8 ($string_value, -1, $bytes_read, $bytes_written, $gerror)
				-- The value of bytes_written doesn't take the null character in to account
			create managed_data.make_from_pointer (utf8_ptr, bytes_written + 1)
			feature {EV_GTK_EXTERNALS}.g_free (utf8_ptr)
		end

	make_from_pointer (a_utf8_ptr: POINTER) is
			-- Set `Current' to use `a_utf8_ptr'
		do
			create managed_data.make_from_pointer (a_utf8_ptr, feature {EV_GTK_DEPENDENT_EXTERNALS}.g_utf8_strlen (a_utf8_ptr, -1) + 1)
		end

feature -- Access

	item: POINTER is
			-- Pointer to the UTF8 string
		do
			Result := managed_data.item
		end

	string: STRING is
			-- Locale string representation of the UTF8 string
		local
			str_ptr: POINTER
			bytes_read, bytes_written, gerror: INTEGER
		do
			str_ptr := feature {EV_GTK_DEPENDENT_EXTERNALS}.g_locale_from_utf8 (item, -1, $bytes_read, $bytes_written, $gerror)
			if str_ptr /= default_pointer then
				create Result.make_from_c (str_ptr)				
			else
				-- Sometimes the UTF8 string cannot be translated
				create Result.make_from_c (item)
			end
		end	

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
		-- Pointer to the UTF8 string
	

end -- class EV_GTK_C_STRING

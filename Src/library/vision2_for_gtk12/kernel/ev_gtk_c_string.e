indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

create
	set_with_eiffel_string, make_from_pointer, share_from_pointer

convert
	set_with_eiffel_string ({STRING})
	
	
feature {NONE} -- Initialization

	make_from_pointer (a_ptr: POINTER) is
			-- Set `Current' to use `a_ptr'
		require
			a_pointer_valid: a_ptr /= default_pointer
		local
			a_string: STRING
		do
			create a_string.make_from_c (a_ptr)
			set_with_eiffel_string (a_string)
		end

	share_from_pointer (a_ptr: POINTER) is
			-- Set `Current' to use `a_ptr'.
		require
			a_pointer_valid: a_ptr /= default_pointer
		do
				--| Fixme added sharing implementation to avoid memory copy.
			make_from_pointer (a_ptr)
		end

feature -- Access

	set_with_eiffel_string (a_string: STRING) is
			-- Create a UTF8 string from `a_string'
		require
			a_string_not_void: a_string /= Void
		local
			a_string_value: ANY
		do
			a_string_value := a_string.to_c
				-- String count doesn't take the null character in to account
			create managed_data.make_from_pointer ($a_string_value, a_string.count + 1)
		end

	item: POINTER is
			-- Pointer to the UTF8 string
		do
			Result := managed_data.item
		end

	string: STRING is
			-- Locale string representation of the UTF8 string
		do
			create Result.make_from_c (item)
		end	

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER;
		-- Pointer to the UTF8 string
	

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


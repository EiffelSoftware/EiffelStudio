indexing
	description: "Abstract Bind or Define Variable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_variable.e $"
--
--*****************  Version 2  *****************
--User: Roman Movchan Date: 2.09.02    Time: 23:12
--Updated in $/ELDORA/src/handles

deferred class
	OCI_VARIABLE
	
inherit
	OCI_HANDLE_ATTR
	
	OCI_DEFINITIONS
		export {NONE} all
		undefine
			is_equal
		end
		
	MEMORY
		rename
			free as free_object
		export {NONE} all
		undefine
			is_equal
		redefine
			dispose
		end
	
feature {NONE} -- Initialization

	make_variable (type: INTEGER_16; size: INTEGER) is
			-- Create a bind/define variable
		require
			valid_data_type_and_size: valid_data_type_and_size (type, size)
			buffer_not_allocated: not buffer_allocated
		do
			data_type := type
			data_size := size
			allocate_buffer
		ensure
			assigned_data_type: data_type = type
			assigned_data_size: data_size = size
			buffer_allocated: buffer_allocated
		end
		
feature -- Access

	value: ANY is
			-- Current value of bind/define variable
		require
			not_null: not is_null
			buffer_allocated: buffer_allocated
		deferred
		end
	
	data_type: INTEGER_16
		-- Data type code (see External Oracle datatypes in OCI_DEFINITIONS)
	
	data_size: INTEGER
		-- (Maximum) Size of data in bytes

	valid_data_type_and_size (type: INTEGER_16; size: INTEGER): BOOLEAN is
			-- Are `type' and `size' valid values for `data_type' and `data_size' ?
		deferred
		end
	
feature -- Status report

	is_null: BOOLEAN is
			-- Is current value of the variable `NULL' ?
		do
			Result := indicator = null
		end
		
	is_truncated: BOOLEAN is
			-- Has value been truncated ?
		do
			Result := indicator = -2 or indicator > 0
		end
		
	value_too_large: BOOLEAN is
			-- Is actual value greater than maximum length ?
		do
			Result := indicator = -2
		end
		
	full_length: INTEGER is
			-- Actual length of the value before truncation
		require
			truncated: is_truncated
			length_known: not value_too_large
		do
			Result := indicator.to_integer
		end
	
	buffer_allocated: BOOLEAN
		-- Has `buffer' been allocated ?
	
feature {OCI_STATEMENT} -- Status setting

	null: INTEGER_16 is -1
		-- Indicator value that represents `NULL'
			
	set_null is
			-- Set value of the variable to `NULL'
		local
			temp: INTEGER_16
		do
			temp := null
			indicator_ptr.memory_copy ($temp, 2)
		end
	
feature -- Removal

	dispose is
			-- Free `buffer' when disposing of `Current'
		do
			if buffer_allocated then
				free_buffer
			end
			Precursor
		end
		
feature {NONE} -- Implementation

	buffer: POINTER
		-- Buffer to store the value
		
	indicator_ptr: POINTER
		-- Address where indicator value will be stored
	
	indicator: INTEGER_16 is
			-- Indicator variable;
			-- for input, the following values can be assigned:
			--   -1	- Oracle assigns a NULL to the column, ignoring the value of the input variable
			-- >= 0 - Oracle assigns the value of the input variable to the column
			-- on output, can have the following values:
			--   -2	- the item has been truncated; the original length is longer than the maximum data 
			--        length that can be returned in the indicator variable
			--   -1	- the selected value is null, and the value of the output variable is unchanged
			--    0	- Oracle assigned an intact value to the host variable
			--  > 0	- the item has been truncated; the value is the actual length before truncation
		require
			buffer_allocated: buffer_allocated
		do
			($Result).memory_copy (indicator_ptr, 2)
		ensure
			valid_result: Result >= -2
		end

	actual_length_ptr: POINTER
		-- Address where actual length of data is stored
		
	actual_length: INTEGER_16 is
			-- Actual length of data
		require
			buffer_allocated: buffer_allocated
		do
			($Result).memory_copy (actual_length_ptr, 2)
		ensure
			valid_result: Result >= 0
		end
		
	return_code_ptr: POINTER
			-- Address where return code is stored
			
	return_code: INTEGER_16 is
			-- Column level return code
		require
			buffer_allocated: buffer_allocated
		do
			($Result).memory_copy (return_code_ptr, 2)
		ensure
			valid_result: Result >= 0
		end
	
	allocate_buffer is
			-- Allocate `buffer' according to `data_size'
		require
			valid_data_size: data_size > 0
			buffer_not_allocated: not buffer_allocated
		do
			buffer := default_pointer.memory_alloc (data_size)
			indicator_ptr := default_pointer.memory_alloc (2)
			actual_length_ptr := default_pointer.memory_alloc (2)
			return_code_ptr := default_pointer.memory_alloc (2)
			buffer_allocated := True
		ensure
			buffer_allocated: buffer_allocated
		end
		
	free_buffer is
			-- Free `buffer'
		require
			buffer_allocated: buffer_allocated
		do
			buffer.memory_free
			indicator_ptr.memory_free
			actual_length_ptr.memory_free
			return_code_ptr.memory_free
			buffer_allocated := False
		ensure
			buffer_not_allocated: not buffer_allocated
		end
		
invariant
	valid_data_type_and_size: valid_data_type_and_size (data_type, data_size)
		
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




end -- class OCI_VARIABLE

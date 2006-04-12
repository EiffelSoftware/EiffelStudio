indexing
	description: "Encapsulation of STATSTG structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STATSTG

inherit
	ECOM_WRAPPER

	ECOM_STGTY
		export
			{NONE} all
		end
	
	ECOM_STGM
		export
			{NONE} all
		end

	ECOM_LOCK_TYPES
		export
			{NONE} all
		end

create
	make

feature -- Access

	name: STRING is
			-- name
		local
			l_string: WEL_STRING
		do
			create l_string.make_by_pointer (c_name (item))
			Result := l_string.string
		end

	is_same_name (other_name: STRING): BOOLEAN is
		require
			valid_other_name: other_name /= Void
		local
			l_string, l_string2: WEL_STRING
		do
			create l_string.make (other_name);
			create l_string2.make_by_pointer (c_name (item))
			Result := l_string.is_equal (l_string2)
		end

	type: INTEGER is
			-- Type of object
			-- Returns one of the values from the STGTY enumeration.
			-- See class ECOM_STGTY for values 
		do
			Result := c_type (item)
		ensure
			valid_type: is_valid_stgty (Result)
		end

	size: ECOM_ULARGE_INTEGER is
			-- Size in bytes of stream or byte array. 
		do
			create Result.make_from_pointer (c_size (item))
		ensure
			Result /= Void and Result.item /= Default_pointer
		end

	modification_time: WEL_FILE_TIME is
			-- Last modification time 
		do
			create Result.make_by_pointer (c_modification_time (item))
		ensure
			Result /= Void
		end

	creation_time: WEL_FILE_TIME is
			-- Creation time  
		do
			create Result.make_by_pointer (c_creation_time (item))
		ensure
			Result /= Void
		end

	access_time: WEL_FILE_TIME is
			-- Last access time 
		do
			create Result.make_by_pointer (c_access_time (item))
		ensure
			Result /= Void
		end

	mode: INTEGER is
			-- Access mode specified when the 
			-- object was opened. 
			-- See class ECOM_STGM for values 
		do
			Result := c_mode (item)
		ensure
			valid_mode: is_valid_stgm (Result)
		end

	locks_supported: INTEGER is
			-- Types of region locking supported 
			-- by stream or byte array. See the LOCKTYPES 
			-- enumeration for the values available. This member 
			-- is not used for storage objects. 
		do
			Result := c_locks_supported (item)
		end

	clsid: POINTER is
			-- Class identifier for storage object; 
			-- set to CLSID_NULL for new storage objects. This member 
			-- is not used for streams or byte arrays. 
		do
			Result := c_clsid (item)
		end

feature {NONE} -- Implementation

	memory_free is
			-- Free STATSTG structure
		local
			l_pointer: POINTER
		do
			l_pointer := c_name (item)
			if l_pointer /= default_pointer then
				c_co_task_mem_free (l_pointer)
			end
			item.memory_free
			item = default_pointer
		end

feature {NONE} -- Externals

	c_co_task_mem_free (a_item: like item) is
			-- Call `CoTaskMemFree' on `a_item'.
		external
			"C inline use <windows.h>"
		alias
			"CoTaskMemFree((void*)$a_item)"
		end

	c_name (a_item: like item): POINTER is
			-- Retrieve `pwcsName' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"((STATSTG*)$a_item)->pwcsName"
		end

	c_size (a_item: like item): POINTER is
			-- Retrieve pointer on `cbSize' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"&(((STATSTG*)$a_item)->cbSize)"
		end

	c_type (a_item: like item): POINTER is
			-- Retrieve `type' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"((STATSTG*)$a_item)->type"
		end

	c_modification_time (a_item: like item): POINTER is
			-- Retrieve pointer on `mtime' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"&(((STATSTG*)$a_item)->mtime)"
		end

	c_modification_time (a_item: like item): POINTER is
			-- Retrieve pointer on `mtime' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"&(((STATSTG*)$a_item)->mtime)"
		end

	c_creation_time (a_item: like item): POINTER is
			-- Retrieve pointer on `ctime' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"&(((STATSTG*)$a_item)->ctime)"
		end

	c_access_time (a_item: like item): POINTER is
			-- Retrieve pointer on `atime' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"&(((STATSTG*)$a_item)->atime)"
		end

	c_mode (a_item: like item): POINTER is
			-- Retrieve `grfMode' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"((STATSTG*)$a_item)->grfMode"
		end

	c_locks_supported (a_item: like item): BOOLEAN is
			-- Retrieve `grfMode' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"(EIF_BOOLEAN)(((STATSTG*)$a_item)->grfLocksSupported)"
		end

	c_clsid (a_item: like item): POINTER is
			-- Retrieve pointer on `clsid' field of STATSTG structure
		external
			"C inline use <windows.h>"
		alias
			"&(((STATSTG*)$a_item)->clsid)"
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

end -- class ECOM_STATSTG


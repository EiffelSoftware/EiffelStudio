indexing

	description:
		"Objects that may be stored and retrieved along with all their dependents. %
		%This class may be used as ancestor by classes needing its facilities.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	STORABLE

feature -- Access

	retrieved (file: UNIX_FILE): STORABLE is
			-- Retrieved object structure, from external
			-- representation previously stored in `file'.
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if file content is not a `STORABLE' structure.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_read: file.is_open_read
		do
			Result := c_retrieved (file.file_pointer)
		ensure
			Result_exists: Result /= Void
		end


feature -- Element change

	basic_store (file: UNIX_FILE) is
			-- Produce on `file' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable within current system only.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
		do
			c_basic_store (file.file_pointer, $Current)
		end;

	general_store (file: UNIX_FILE) is
			-- Produce on `file' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it 
			--| possible to overcome class name clashes.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
		do
			c_general_store (file.file_pointer, $Current)
		end

feature {NONE} -- Implementation

	c_retrieved (file_ptr: POINTER): STORABLE is
			-- Object structured retrieved from file of pointer
			-- `file_ptr'
		external
			"C"
		alias
			"eretrieve"
		end;

	c_basic_store (file_ptr: POINTER; object: STORABLE) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		alias
			"estore"
		end;

	c_general_store (file_ptr: POINTER; object: STORABLE) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		alias
			"eestore"
		end;

end -- class STORABLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

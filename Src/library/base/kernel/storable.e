indexing

	description:
		"Objects that may be stored and retrieved along with all their dependents. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	STORABLE

inherit
	EXCEPTIONS

feature -- Access

	retrieved (file: IO_MEDIUM): STORABLE is
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
			file_is_binary: not file.is_plain_text
		do
			Result := c_retrieved (file.handle)
		ensure
			Result_exists: Result /= Void
		end

	retrieve_by_name (file_name: STRING): STORABLE is
			-- Retrieve object structure, from external
			-- representation previously stored in a file
			-- called `file_name'.
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if file content is not a `STORABLE' structure.
			-- Will return Void if the file does not exist or
			-- is not readable.
		require
			file_name_exists: file_name /= Void
			file_name_meaningful: not file_name.empty
		local
			file: RAW_FILE
		do
			!!file.make (file_name)
			if file.exists and then file.is_readable then
				file.open_read
				Result := c_retrieved (file.descriptor)
				file.close
			end
		end
	
feature -- Element change

	basic_store (file: IO_MEDIUM) is
			-- Produce on `file' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable within current system only.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
			file_is_binary: not file.is_plain_text
		do
			c_basic_store (file.handle, $Current)
		end;

	general_store (file: IO_MEDIUM) is
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
			file_is_binary: not file.is_plain_text
		do
			c_general_store (file.handle, $Current)
		end

	independent_store (file: IO_MEDIUM) is
			-- Produce on `file' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
			file_is_binary: not file.is_plain_text
		do
			c_independent_store (file.handle, $Current)
		end

	store_by_name (file_name: STRING) is
			-- Produce on file called `file_name' an external
			-- representation of the entire object structure 
			-- reachable from current object.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
		require
			file_name_not_void: file_name /= Void
			file_name_meaningful: not file_name.empty
		local
			file: RAW_FILE
			a: ANY
		do
			!!file.make (file_name)
			if (file.exists and then file.is_writable) or else
				(file.is_creatable) then
				file.open_write 
				c_general_store (file.descriptor, $Current)
				file.close
			else
				a := ("write permission failure").to_c
				eraise ($a, Io_exception)
			end
		end

feature {NONE} -- Implementation

	c_retrieved (file_handle: INTEGER): STORABLE is
			-- Object structured retrieved from file of pointer
			-- `file_ptr'
		external
			"C"
		alias
			"eretrieve"
		end;

	c_basic_store (file_handle: INTEGER; object: STORABLE) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		alias
			"estore"
		end;

	c_general_store (file_handle: INTEGER; object: STORABLE) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		alias
			"eestore"
		end;

	c_independent_store (file_handle: INTEGER; object: STORABLE) is
			-- Store object structure reachable form current object
			-- in file pointer `file_ptr'.
		external
			"C"
		alias
			"sstore"
		end;

end -- class STORABLE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

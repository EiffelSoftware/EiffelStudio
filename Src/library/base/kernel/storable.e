--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------


-- Facilities for storing and retrieving objects in binary format.
-- Classes needing these facilities should inherit from this class.


class STORABLE

feature -- Access

	retrieved (file: UNIX_FILE): STORABLE is
			-- Retrieved object structure from external representation
			-- previously stored in file `file'
			--| Use reverse assignment attempt to access to correct
			--| type of root object.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_read: file.is_open_read
		do
			Result := c_retrieved (file.file_pointer)
		ensure
			Result_exists: Result /= Void
		end


feature -- Modification & Insertion

	basic_store (file: UNIX_FILE) is
			-- Produce an external representation of the entire
			-- object structure reachable for current object.
			-- Write this representation onto file `file'
			-- retrievable within current type system only.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
		do
			c_basic_store (file.file_pointer, $Current)
		end;

	general_store (file: UNIX_FILE) is
			-- Produce an external representation of the entire
			-- object structure reachable for current object.
			-- Write this representation onto file of name `file'
			-- retrievable from other type systems for a same machine
			-- architecture.
			--| This primitive may use a visible name of a class written
			--| in the visible clause of the ace file. This provides the
			--| user with the possibility to remove class clash names.
		require
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
		do
			c_general_store (file.file_pointer, $Current)
		end


feature  {NONE} -- External, Access

	c_retrieved (file_ptr: POINTER): STORABLE is
			-- Object structured retrieved from file of pointer
			-- `file_ptr'
		external
			"C"
		alias
			"eretrieve"
		end


feature  {NONE} -- External, Modification & Insertion

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

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

	retrieved (medium: IO_MEDIUM): ANY is
			-- Retrieved object structure, from external
			-- representation previously stored in `medium'.
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if medium content is not a stored Eiffel structure.
		require
			medium_not_void: medium /= Void;
			medium_exists: medium.exists;
			medium_is_open_read: medium.is_open_read
			medium_supports_storable: medium.support_storable
		do
			Result := medium.retrieved
		ensure
			Result_exists: Result /= Void
		end

	retrieve_by_name (file_name: STRING): ANY is
			-- Retrieve object structure, from external
			-- representation previously stored in a file
			-- called `file_name'.
			-- To access resulting object under correct type,
			-- use assignment attempt.
			-- Will raise an exception (code `Retrieve_exception')
			-- if file content is not a stored Eiffel structure.
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
				Result := file.retrieved
				file.close
			end
		end

feature -- Element change

	basic_store (medium: IO_MEDIUM) is
			-- Produce on `medium' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable within current system only.
		require
			medium_not_void: medium /= Void;
			medium_exists: medium.exists;
			medium_is_open_write: medium.is_open_write
			medium_supports_storable: medium.support_storable
		do
			medium.basic_store (Current)
		end;

	general_store (medium: IO_MEDIUM) is
			-- Produce on `medium' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable from other systems for same platform
			-- (machine architecture).
			--| This feature may use a visible name of a class written
			--| in the `visible' clause of the Ace file. This makes it
			--| possible to overcome class name clashes.
		require
			medium_not_void: medium /= Void;
			medium_exists: medium.exists;
			medium_is_open_write: medium.is_open_write
			medium_supports_storable: medium.support_storable
		do
			medium.general_store (Current)
		end

	independent_store (medium: IO_MEDIUM) is
			-- Produce on `medium' an external representation of the
			-- entire object structure reachable from current object.
			-- Retrievable from other systems for the same or other
			-- platform (machine architecture).
		require
			medium_not_void: medium /= Void;
			medium_exists: medium.exists;
			medium_is_open_write: medium.is_open_write
			medium_supports_storable: medium.support_storable
		do
			medium.independent_store (Current)
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
				file.general_store (Current)
				file.close
			else
				a := ("write permission failure").to_c
				eraise ($a, Io_exception)
			end
		end

end -- class STORABLE

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------


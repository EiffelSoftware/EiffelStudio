indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class FILE2DBMS

inherit

	converter
		rename
			make as converter_make
		export
			{NONE} container, container_size
		redefine
			store_object
		end

creation -- Creation procedures

	make

feature -- Initialization

	make is
		do
			converter_make;
			!! store.make;
			!! control.make
		end;

feature -- Status setting

	set_repository (new_repository: DB_REPOSITORY) is
			-- Set storage repository with `new_repository'.
		require
			repository_not_void: new_repository /= Void
		do
			store.set_repository(new_repository)
		ensure
			owns_repository: owns_repository
		end;

feature  -- Status report

	owns_repository: BOOLEAN is
			-- Is Current attached to a repository?
		do
			Result := store.owns_repository
		end;

feature {NONE} -- Status report

	store: DB_STORE

	control: DB_CONTROL

feature {NONE} -- Basic operations

	store_object is
			-- Insert each retrieved object from external file into database.
		do
			store.put(parse.ecp_reference);
			if not control.is_ok then
				conv_error := true;
				conv_message := clone (control.error_message)
			end	
		end

end -- class FILE2DBMS



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


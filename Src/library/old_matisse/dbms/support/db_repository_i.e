indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: repository
	Product: EiffelStore
	Database: All_Bases

deferred class DB_REPOSITORY_I

feature -- Initialization

	load is
			-- Load in description of repository `repository_name'.
		deferred
		end


feature -- Basic operations

	generate_class is
			-- Generate Eiffel class template according to data
			-- representation given by `repository_name'.
		deferred
		end

feature -- Status setting

	allocate (object: ANY; repository_name: STRING) is
			-- Create a schema table `repository_name' conforming 
			-- to `object' basic attributes.
		deferred
		end

	change_name (repository_name: STRING) is
			-- Set repository name with `repository_name'.
		deferred
		end

feature -- Status report

	conforms (object: ANY): BOOLEAN is
			-- Is the structure of repository_name the same
			-- as the structure of `object'.
		deferred
		end

	exists: BOOLEAN is
			-- Does current repository exist in database schema ?
		deferred
		end

end -- class DB_REPOSITORY_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

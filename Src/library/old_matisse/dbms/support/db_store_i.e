indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: store
	Product: EiffelStore
	Database: All_Bases

deferred class DB_STORE_I

inherit

	DB_STATUS_USE

	DB_EXEC_USE

feature -- Status setting

	set_repository (one_repository: DB_REPOSITORY_I) is
			-- Associate `one_repository' handle to current
			-- db_store handle.
		require
			parameter_not_void: one_repository /= Void
		deferred
		ensure
			repository_not_void: repository /= Void
		end

feature -- Status report

	owns_repository: BOOLEAN is
			-- Is the current store operation associated
			-- with a repository?
		deferred
		ensure
			existence_condition: Result = (repository /= Void)
		end

feature -- Basic operations

	put (object: ANY) is
			-- Store `object' into active repository.
		require
			object_exists: object /= Void
			owns_repository: owns_repository
		deferred
		end

	force (obj: ANY) is
			-- Store `object' into supposingly fixed
			-- and resizable active repository.
		require
			object_exists: obj /= Void
			owns_repository: owns_repository
		deferred
		end

feature {NONE} -- Status report

	repository: DB_REPOSITORY_I is
			-- Associated repository handle
		deferred
		end

end -- class DB_STORE_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

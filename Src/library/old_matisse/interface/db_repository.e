indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class DB_REPOSITORY

inherit

	DB_STATUS_USE
		export
			{ANY} is_ok
			{ANY} is_connected
		end

	DB_EXEC_USE
		export
			{NONE} all
		end

creation -- Creation procedure

	make

feature -- Status report

	loaded: BOOLEAN
			-- Is current repository data description 
			-- retrieved from base?

	repository_name: STRING
			-- Name of repository

	exists: BOOLEAN is
			-- Does repository `repository_name' exist?
		require
			is_ok: is_ok
			rep_loaded: loaded
		do
			Result := implementation.exists
		end

	conforms (object: ANY): BOOLEAN is
			-- Do `object' attributes match the data description
			-- accessed through `repository_name' ?
		require
			parameter_not_void: object /= Void
			is_loaded: loaded
			is_ok: is_ok
		do
			Result := implementation.conforms (object)
		end

feature -- Initialization

	make (name: STRING) is
			-- Create repository with `name'.
		require
			name_exists: name /= Void
		do
			implementation := handle.database.db_repository_i
			implementation.change_name (name)
			repository_name := name
		ensure
			repository_name.is_equal (name)
		end

feature -- Basic operations

	load is
			-- Load persistent data description accessible through
			-- `repository_name'.
		require
			repository_name: repository_name /= Void
			connected: is_connected
		do
			implementation.load
			loaded := true
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		ensure
			loaded
		end

	generate_class is
			-- Generate an Eiffel class template mapping
			-- the loaded data description.
		require
			is_ok: is_ok
			rep_loaded: loaded
		do
			implementation.generate_class
		end

	change_name (new_name: STRING) is
			-- Change repository name with `new_name'.
		require
			is_ok: is_ok
			name_exists: new_name /= Void
		do
			repository_name := clone (new_name)
			implementation.change_name (new_name)
			loaded := false
		ensure
			new_name.is_equal (repository_name)
		end

	allocate (object: ANY) is
			-- Generate a database repository according to the
			-- data representation of Eiffel object `object'.
		require
			connected: is_connected
			obj_exists: object /= Void
			is_ok: is_ok
		do
			implementation.allocate (object, repository_name)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end

feature {DB_STORE} -- Implementation

	implementation: DB_REPOSITORY_I
			-- Handle reference to specific database implementation

end -- class DB_REPOSITORY


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


note

	status: "See notice at end of class.";
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

create -- Creation procedure

	make

feature -- Status report

	loaded: BOOLEAN
			-- Is current repository data description
			-- retrieved from base?

	repository_name: STRING
			-- Name of repository

	exists: BOOLEAN
			-- Does repository `repository_name' exist?
		require
			is_ok: is_ok
			rep_loaded: loaded
		do
			Result := implementation.exists
		end

	conforms (object: ANY): BOOLEAN
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

	make (name: STRING)
			-- Create repository with `name'.
		require
			name_exists: name /= Void
			connected: is_connected
		do
			implementation := handle.database.db_repository
			implementation.change_name (name)
			repository_name := name
		ensure
			repository_name.is_equal (name)
		end

feature -- Access

	column_i_th(i: INTEGER): COLUMNS[DATABASE]
			-- Column corresponding to indice 'i'
		require
			indice_valid: i>=1 and i<=column_number
		do
			Result := implementation.column_i_th(i)
		ensure
			Result /= Void
		end

	column_number: INTEGER
			-- Column number
		do
			Result := implementation.column_number
		ensure
			Result >= 0
		end

feature -- Basic operations

	load
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

	generate_class (f: FILE)
			-- Generate an Eiffel class template mapping
			-- the loaded data description.
		require
			is_ok: is_ok
			rep_loaded: loaded
			file_exists: f /= Void and then f.exists
		do
			implementation.generate_class (f)
		end

	change_name (new_name: STRING)
			-- Change repository name with `new_name'.
		require
			is_ok: is_ok
			name_exists: new_name /= Void
		do
			repository_name := new_name.twin
			implementation.change_name (new_name)
			loaded := false
		ensure
			ensure_name (new_name)
		end

	allocate (object: ANY)
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

	implementation: DATABASE_REPOSITORY [DATABASE]
			-- Handle reference to specific database implementation

	ensure_name (new_name: STRING): BOOLEAN
		require
			not_void: new_name /= Void
		local
			tmp_string: STRING
		do
			tmp_string := new_name.as_lower
			Result := repository_name.is_equal (tmp_string)
			tmp_string.to_upper
			Result := Result or repository_name.is_equal (tmp_string)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DB_REPOSITORY




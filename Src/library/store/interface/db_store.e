indexing

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: store
	Product: EiffelStore
	Database: All_Bases

class DB_STORE

inherit

	DB_STATUS_USE
		export
			{ANY} is_ok, is_connected
		end

	DB_EXEC_USE

create -- Creation procedure

	make

feature -- Status setting

	set_repository (repository: DB_REPOSITORY) is
			-- Set implementation repository with `repository'.
		require
			repository_not_void: repository /= Void
		do
			implementation.set_repository (repository.implementation)
		ensure
			owns_repository: owns_repository
		end

feature -- Status report

	owns_repository: BOOLEAN is
			-- Is Current linked to a repository?
		do
			Result := implementation.owns_repository
		end

feature -- Basic operations

	put (object: ANY) is
			-- Insert `object' in repository attached to Current.
		require
			connected: is_connected
			object_exists: object /= Void
			is_ok: is_ok
			owns_repository: owns_repository
		do
			implementation.put (object)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end

	force (object: ANY) is
			-- Insert `object' in repository attached to Current.
		require
			connected: is_connected
			object_exists: object /= Void
			is_ok: is_ok
			owns_repository: owns_repository
		do
			implementation.force (object)
			if not is_ok and then is_tracing then
				trace_output.putstring (error_message)
				trace_output.new_line
			end
		end

feature {NONE} -- Implementation

	implementation: DATABASE_STORE [DATABASE]
		-- Handle reference to specific database implementation

feature {NONE} -- Initialization

	make is
			-- Create an interface object to store in active base.
		do
			implementation := handle.database.db_store
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




end -- class DB_STORE




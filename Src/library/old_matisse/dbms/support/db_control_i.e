indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

deferred class DB_CONTROL_I

inherit

	DB_STATUS_USE
		export
			{ANY} is_connected
		end

feature -- Status setting and report

	connect: INTEGER is
			-- Connection status from database handle
		require
			not_already_connected: not is_connected
		deferred
		end

	disconnect: INTEGER is
			-- Disconnection status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	commit: INTEGER is
			-- Commit status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	rollback: INTEGER is
			-- Rollback status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	transaction_count: INTEGER is
			-- Number of started transactions with database handle
		require
			connection_exists: is_connected
		deferred
		end

	begin: INTEGER is
			-- Start of transaction status from database handle
		require
			connection_exists: is_connected
		deferred
		end

	begin_version_access(version:STRING):INTEGER is
			-- Start of version access status from database handle
			-- value of "latest" may be used for 'version' 
		require
			Version_exists: version /= Void and not version.empty
			connection_exists: is_connected
		deferred
		end

	end_version_access:INTEGER is
			-- End version access status from database handle
		require
			connection_exists: is_connected
		deferred
		end

feature -- Initialization
	trans_tbl_make(fn:STRING) is
		deferred	
		end

	trans_tbl_create is
		deferred	
		end

	trans_tbl_restore is
		deferred	
		end

	trans_tbl_exists:BOOLEAN is
		deferred	
		end

	trans_tbl_filename:STRING is
		deferred	
		end

end -- class DB_CONTROL_I


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

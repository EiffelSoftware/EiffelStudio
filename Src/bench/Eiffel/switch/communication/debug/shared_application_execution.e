indexing
	description	: "Shared instance of Application execution.";
	date		: "$Date$";
	revision	: "$Revision $"

class SHARED_APPLICATION_EXECUTION

feature -- Access

	Application_initialized: BOOLEAN is
		do
			Result := cell_Application_initialized.item
		end

	Application: APPLICATION_EXECUTION is
		once
			create Result.make
		end

feature {DEBUGGER_MANAGER} -- Build

	build_shared_application_execution (dbg_manager: DEBUGGER_MANAGER) is
		require
			not Application_initialized
		do
			check application.debugger_manager = Void end
			Application.set_debugger_manager (dbg_manager)
			cell_Application_initialized.put (True)
		ensure
			Application_initialized
		end

feature {NONE} -- Impl

	cell_Application_initialized: CELL [BOOLEAN] is
		once
			create Result.put (False)
		end

end -- class SHARED_APPLICATION_EXECUTION

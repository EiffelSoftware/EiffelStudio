indexing
	description	: "Shared instance of Application execution.";
	date		: "$Date$";
	revision	: "$Revision $"

class SHARED_APPLICATION_EXECUTION

feature -- Access

	Application: APPLICATION_EXECUTION is
		once
			create Result.make
		end		

	Application_notification_controller: APPLICATION_NOTIFICATION_CONTROLLER is
		once
			create Result.make
		end

end -- class SHARED_APPLICATION_EXECUTION

indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_APPLICATION_EXECUTION

feature -- Access

	Application: APPLICATION_EXECUTION is
		once
			!! Result.make
		end

end -- class SHARED_APPLICATION_EXECUTION

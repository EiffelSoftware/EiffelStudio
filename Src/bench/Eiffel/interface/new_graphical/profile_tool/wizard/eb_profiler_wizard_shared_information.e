indexing
	description	: "Object to access the information associated with a state in the profiler wizard."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_PROFILER_WIZARD_SHARED_INFORMATION

feature {NONE} -- Implementation

	information: EB_PROFILER_WIZARD_INFORMATION is
			-- Information entered so far
		do
			Result ?= wizard_information
			check
				Result_not_void: Result /= Void
			end
		ensure
			Result_not_void: Result /= Void
		end
		
		
	wizard_information: EB_WIZARD_INFORMATION is
			-- Information entered so far (base class)
		deferred
		end
			
end -- class EB_PROFILER_WIZARD_SHARED_INFORMATION

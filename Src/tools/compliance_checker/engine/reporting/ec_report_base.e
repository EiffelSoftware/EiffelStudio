indexing
	description: "[
		Base, abstract implementation for all report entities.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_REPORT_BASE
	
feature -- Access

	report: EC_REPORT is
			-- Report associated with report entity.
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
	parent: EC_REPORT_BASE is
			-- Parent report entity of current entity.
		deferred
		end
	
end -- class EC_REPORT_BASE

indexing
	description: "[
				Facilities for adapting the exception handling mechanism.
				This class may be used as ancestor by classes needing its facilities.
			  ]"
	external_name: "ISE.Base.Exceptions"

class 
	EXCEPTIONS

feature -- Status report

	assertion_violation: BOOLEAN is
		indexing
			description: "[
						Is last exception originally due to a violated
						assertion or non-decreasing variant?
					  ]"
		do
		end

	is_developer_exception: BOOLEAN is
		indexing
			description: "Is the last exception originally due to a developer exception?"
		do
			Result := exception.get_source.is_equal (Developer_exception_source)
		end

feature -- Access

	Developer_exception_source : STRING is "ISE.DE"
		indexing
			description: "Characterize exceptions raised by developer."
		end

	tag_name: STRING is
		indexing
			description: "Tag of last violated assertion clause."
		do
			Result := exception.get_message
		end

	recipient_name: STRING is
		indexing
			description: "[
						Name of the routine whose execution was
						interrupted by last exception.
					  ]"
		do
			Result := exception.get_target_site.get_name
		end

	class_name: STRING is
		indexing
			description: "[
						Name of the class that includes the recipient
						of original form of last exception.
					  ]"
		do
			Result := exception.get_target_site.get_reflected_type.get_full_name
		end

	exception: SYSTEM_EXCEPTION is
		indexing
			description: "Exception object of last exception that occurred."
		do
			result := exception_manager.last_exception
		end

	exception_trace: STRING is
		indexing
			description: "String representation of the exception trace."
		do
			Result := exception.get_stack_trace
		end

	original_tag_name: STRING is
		indexing
			description: "Assertion tag for original form of last assertion violation."
		do
			Result := original_exception.get_message
		end

	original_exception: SYSTEM_EXCEPTION is
		indexing
			description: "Original code of last exception that triggered. Current exception"
		do
			Result := exception.get_base_exception
		end

	original_recipient_name: STRING is
		indexing
			description: "[
						Name of the routine whose execution was
						interrupted by original form of last exception.
					 ]"
		do
			Result := original_exception.get_target_site.get_name
		end

	original_class_name: STRING is
		indexing
			description: "[
						Name of the class that includes the recipient
						of original form of last exception.
					  ]"
		do
			Result := original_exception.get_target_site.get_reflected_type.get_full_name
		end

	help_link: STRING is
		indexing
			description: "Link to the help file associated with this exception."
		do
			Result := exception.get_help_link
		end
		
	inner_exception: SYSTEM_EXCEPTION is
		indexing
			description: "Reference to the inner exception."
		do
			Result := exception.get_inner_exception
		end

	source: STRING is
		indexing
			description: "Name of the application or the object that causes the error."
		do
			Result := exception.get_source
		end		
		
feature -- Status setting

	raise (name: STRING) is
		indexing
			description: "Raise a developer exception of name `name'."
		local
			local_exception: SYSTEM_EXCEPTION
		do
			create local_exception.make_1 (name)
			local_exception.set_source (Developer_exception_source)
			internal_raise (local_exception)
		end

	raise_from_exception (excp: SYSTEM_EXCEPTION) is
		indexing
			description: "Raise a developer exception from `exception'."
		do
			internal_raise (excp)
		end
		

	die (status: INTEGER) is
		indexing
			description: "[
						Terminate execution with exit status `status',
						without triggering an exception.
					  ]"
		local
			environment: SYSTEM_ENVIRONMENT
		do
			environment.exit (status)
		end

feature {NONE} -- Implementation

	internal_raise (excp: SYSTEM_EXCEPTION) is
		do
			exception_manager.raise (excp)
		end		

	exception_manager: EXCEPTION_MANAGER
		indexing
			description: "Runtime exception manager"
		end

end -- class EXCEPTIONS

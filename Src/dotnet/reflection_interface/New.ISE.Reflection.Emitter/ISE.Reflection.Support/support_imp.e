indexing
	description: "Provide support for code generation and reflection."
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

deferred class
	SUPPORT_IMP
	
feature -- Access

	last_error: ERROR_INFO
		indexing
			description: "Last error"
		end

	errors_table: ERRORS_TABLE is
		indexing
			description: "Errors table"
		once
			create Result.make
		ensure
			table_created: Result /= Void
		end
		
	interface: SUPPORT

feature -- Basic Operations

	create_error (a_name, a_description: SYSTEM_STRING) is
		indexing
			description: "Create `last_error_info' and add it to `errors_table'."
		local
			converter: GLOBAL_CONVERSATION [ANY]
		do
			interface.create_error( converter.to_eiffel_string(a_name), converter.to_eiffel_string(a_description))
		end

	create_error_from_info (a_code: INTEGER; a_name, a_description: SYSTEM_STRING) is
		indexing
			description: "Create error info from `a_code', `a_name' and `a_description'."
		local
			converter: GLOBAL_CONVERSATION [ANY]
		do
			interface.create_error_from_info( a_code, converter.to_eiffel_string(a_name), converter.to_eiffel_string(a_description))
		end
		
end -- class SUPPORT_IMP

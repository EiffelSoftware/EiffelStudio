indexing
	description: "Error occurred during storage or data retrieval"
	external_name: "ISE.Reflection.ErrorInfo"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end
	
class
	ERROR_INFO
	
create
	make
	
feature {NONE} -- Initialization

	make (a_code: like code; a_name: like name; a_description: like description) is
		indexing
			description: "[
						Set `code' with `a_code'.
						Set `name' with `a_name'.
						Set `description' with `a_description'.
					  ]"
			external_name: "Make"
		require
			valid_code: a_code >= 0
			non_void_name: a_name /= Void
			not_empty_name: a_name.get_length > 0
			non_void_description: a_description /= Void
			not_empty_description: a_description.get_length > 0
		do
			code := a_code
			name := a_name
			description := a_description
		ensure
			code_set: code = a_code
			name_set: name.equals_string (a_name)
			description_set: description.equals_string (a_description)
		end			

feature -- Access

	code: INTEGER
		indexing
			description: "Error code"
			external_name: "Code"
		end

	name: STRING 
		indexing
			description: "Error name"
			external_name: "Name"
		end			
			
	description: STRING 
		indexing
			description: "Error description"
			external_name: "Description"
		end	

invariant
	valid_code: code >= 0
	non_void_name: name /= Void
	not_empty_name: name.get_length > 0
	non_void_description: description /= Void
	not_empty_description: description.get_length > 0
			
end -- class ERROR_INFO

indexing
	description: "Error occurred during storage or data retrieval"
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
		require
			valid_code: a_code >= 0
			non_void_name: a_name /= Void
			not_empty_name: a_name.count > 0
			non_void_description: a_description /= Void
			not_empty_description: a_description.count > 0
		do
			code := a_code
			name := a_name
			description := a_description
		ensure
			code_set: code = a_code
			name_set: name.is_equal (a_name)
			description_set: description.is_equal (a_description)
		end			

feature -- Access

	code: INTEGER
		indexing
			description: "Error code"
		end

	name: STRING 
		indexing
			description: "Error name"
		end			
			
	description: STRING 
		indexing
			description: "Error description"
		end	

invariant
	valid_code: code >= 0
	non_void_name: name /= Void
	not_empty_name: name.count > 0
	non_void_description: description /= Void
	not_empty_description: description.count > 0
			
end -- class ERROR_INFO

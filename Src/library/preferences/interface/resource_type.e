indexing
	description: "Abstraction of a type of resource"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RESOURCE_TYPE

feature -- Access

	xml_name: STRING is
			-- String that represents this type in XML representations.
		deferred
		ensure
			not_trivial: Result /= Void and then not Result.is_empty
		end

	registry_name: STRING is
			-- String that represents this type in registry keys.
		deferred
		ensure
			six_chars_no_underscore: Result /= Void and then Result.count = 6 and then not Result.has ('_')
		end

feature -- Status report

	error_message: STRING
			-- Error message if last resource creation failed.

feature -- Basic operations

	load_resource (name, value: STRING): RESOURCE is
			-- Take a string representation and create the associated resource.
		require
			valid_name: name /= Void and not name.is_empty
		deferred
		ensure
			error_if_failed: Result = Void implies error_message /= Void
			resource_type_initialized: Result.type = Current
		end

end -- class RESOURCE_TYPE

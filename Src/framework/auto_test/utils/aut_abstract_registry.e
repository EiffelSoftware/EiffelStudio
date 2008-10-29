indexing
	description	: "Abstract registry."
	author: "Ilinca Ciupa and Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_ABSTRACT_REGISTRY
	
feature -- Access

	subkeys (key: STRING): DS_LINEAR [STRING] is
			-- List of subkeys of key `key' or `Void' if 
			-- there is no `key' key.
		require
			is_available: is_available
			key_not_void: key /= Void
		deferred
		ensure
			no_empty_keys: Result /= Void implies not Result.has (Void)
		end

	string_value (key: STRING): STRING is
			-- String value of key `key';
			-- `Void' if there is no key `key' or its type is not string.
		require
			is_available: is_available
			key_not_void: key /= Void
		deferred
		end
		
feature -- Status report

	is_available: BOOLEAN is
			-- Is registry available on current platform?
		deferred
		end

end
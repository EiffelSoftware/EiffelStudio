indexing
	metadata: 
		create {ATTRIBUTE_USAGE_ATTRIBUTE}.make ({ATTRIBUTE_TARGETS}.all_) end
		
	dotnet_constructors: make
		
class
	A

inherit
	NATIVE_ATTRIBUTE
		rename
			make as make_attribute
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_message: SYSTEM_STRING; a_value: SYSTEM_STRING) is
		do
			print (a_message)
			print ("%N")
			value := a_value
		ensure
			value_set: value = a_value
		end
		
feature -- Access

	value: SYSTEM_STRING
		indexing
			property: auto
		end

end

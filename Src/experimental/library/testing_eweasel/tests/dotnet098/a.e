indexing
	metadata: 
		create {ATTRIBUTE_USAGE_ATTRIBUTE}.make ({ATTRIBUTE_TARGETS}.all_) end
		
class
	A

inherit
	NATIVE_ATTRIBUTE

create
	make

feature -- Properties

	property: SYSTEM_STRING --assign set_property
		indexing
			property: auto
		end
		
	set_property (a_property: like property) is
		do
			property := a_property
		end

end

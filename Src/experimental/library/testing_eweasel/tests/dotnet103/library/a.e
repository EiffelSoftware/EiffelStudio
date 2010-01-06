indexing
	dotnet_constructors: make	
	metadata:
		create {EIFFEL_CONSUMABLE_ATTRIBUTE}.make (True) end
		
class
	A

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	make is
		do
		end
		
feature -- Properties

	property_a: INTEGER assign set_property_a
		indexing
			property: auto
		end
		
	set_property_a (a_value: like property_a)
		do
			property_a := a_value
		ensure
			property_a_set: property_a = a_value
		end
	
end

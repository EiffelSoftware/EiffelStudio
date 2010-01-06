indexing
	dotnet_constructors: make
			
class
	B

inherit
	A

create
	make
		
feature -- Properties

	property_b: INTEGER assign set_property_b
		indexing
			property: auto
		end
		
	set_property_b (a_value: like property_b)
		do
			property_b := a_value
		ensure
			property_b_set: property_b = a_value
		end
			
end

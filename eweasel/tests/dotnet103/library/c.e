indexing
	dotnet_constructors: make
	metadata:
		create {EIFFEL_CONSUMABLE_ATTRIBUTE}.make (True) end
		
class
	C

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	make is
		do
		end
		
feature -- Basic operations

	no_consume
			-- Should not be consumed
		indexing
			metadata:
				create {EIFFEL_CONSUMABLE_ATTRIBUTE}.make (False) end
		do
		end
		
feature -- Properties

	property_c: INTEGER assign set_property_c
		indexing
			property: auto
		end
		
	set_property_c (a_value: like property_c)
		do
			property_c := a_value
		ensure
			property_c_set: property_c = a_value
		end
	
end

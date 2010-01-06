class PROPERTIES1

inherit
	PROPERTIES

feature {NONE} -- Initialization

	init_properties
		do
		end

feature -- Access

	property1: SYSTEM_STRING assign set_property1
		indexing
			$PROPERTY
		end

feature -- Element Change

	set_property1 (a_property1: like property1)
			-- Set `property'
		do
			property1 := a_property1
		end

end

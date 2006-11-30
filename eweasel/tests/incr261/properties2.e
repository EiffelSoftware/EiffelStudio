class PROPERTIES2

inherit
	PROPERTIES

feature {NONE} -- Initialization

	init_properties
		do
		end

feature -- Access

	property2: SYSTEM_STRING assign set_property2
		indexing
			property: auto
		end

feature -- Element Change

	set_property2 (a_property2: like property2)
			-- Set `property'
		do
			property2 := a_property2
		end

end

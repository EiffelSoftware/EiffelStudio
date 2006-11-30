class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			create properties
			if {PLATFORM}.is_dotnet then
				properties.property1 := "TEST"
			end

		end

feature -- Access

	properties: ALL_PROPERTIES

end

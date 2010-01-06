class
	TEST

inherit
	OTHER_CLASS

create
	make

feature {NONE} -- Initialization

	make is
		do
			print (my_property)
		end

feature -- Properties

	my_property: SYSTEM_STRING is
			-- Deferred propery
		do
			Result := "Success%N"
		end
end
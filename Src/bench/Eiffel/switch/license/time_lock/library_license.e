class LIBRARY_LICENSE

inherit
	DUMMY_LICENSE
		rename
			application_name as library_name,
			set_application_name as set_library_name
		end

creation
	make

feature {NONE} -- Implementation

	application_delay: INTEGER is 120

	override_key_line: INTEGER is 17

feature -- Initialization

	make is
		do
		end

end

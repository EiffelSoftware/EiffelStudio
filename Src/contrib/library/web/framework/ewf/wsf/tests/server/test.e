class
	TEST

inherit
	WSF_DEFAULT_SERVICE [TEST_EXECUTION]

	TEST_SERVICE [TEST_EXECUTION]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			base_url: detachable READABLE_STRING_8
		do
			print ("Test Server that could be used for autotest%N")
			base_url := {TEST_SETTINGS}.base_url
			if base_url.is_whitespace then
				base_url := Void
			end

			set_service_option ("port", {TEST_SETTINGS}.port_number)
			set_service_option ("base", base_url)
			set_service_option ("verbose", True)
			make_and_launch
		end



end

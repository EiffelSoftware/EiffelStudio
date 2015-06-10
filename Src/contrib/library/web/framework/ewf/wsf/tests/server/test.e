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
		do
			print ("Test Server that could be used for autotest%N")
--			base_url := "/test/"

			set_service_option ("port", 9091)
			set_service_option ("verbose", True)
			make_and_launch
		end



end

class
	TEST

inherit
	WSF_DEFAULT_SERVICE

	TEST_SERVICE

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

feature -- Helper

	server_log_path: STRING
		local
			fn: FILE_NAME
		once
			create fn.make_from_string ("server_test.log")
			Result := fn.string
		end

	server_log (m: STRING_8)
		local
			f: RAW_FILE
		do
			create f.make (server_log_path)
			f.open_append
			f.put_string (m)
			f.put_character ('%N')
			f.close
		end

	base_url: detachable STRING

	test_url (a_query_url: READABLE_STRING_8): READABLE_STRING_8
		local
			b: like base_url
		do
			b := base_url
			if b = Void then
				b := ""
			end
			Result := "/" + b + a_query_url
		end

end

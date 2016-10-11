note
	description: "Summary description for {}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTION

inherit
	TEST_EXECUTION_I

create
	make

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
		once
			Result := {TEST_SETTINGS}.base_url

			if Result.is_whitespace then
				Result := Void
			end
		end

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


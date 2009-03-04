note
	description : "test_project application root class"
	author		: "sdz"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			server: XB_SERVER_TCP
		do
			create server.make_with_port({XB_SERVER_TCP}.default_http_server_port)
			--test_encoding_facility
		end

	test_encoding_facility
			--
		local
			code: ENCODING_FACILITIES
			d: NATURAL
			b: BOOLEAN
			e: NATURAL
			t: TUPLE [value: NATURAL; flag: BOOLEAN]
		do
			d := 2147483647
			b := false
			create code.make
			e := code.encode_natural (d, b)
			io.new_line
			io.new_line
			assert_equal (d, code.decode_natural (e))
			assert_equal (b, code.decode_flag (e))
			e := code.change_flag (e, true)
			assert_equal (d, code.decode_natural (e))
			assert_equal (code.decode_flag (e), true)
			t := code.decode_natural_and_flag (e)
			assert_equal (t.value, d)
			assert_equal (t.flag, true)
		end

	assert_equal (a, b: ANY)
			--
		local
			l_e: DEVELOPER_EXCEPTION
			retried: BOOLEAN
		do
			if not retried then
				if a /= b then
					create l_e
					l_e.set_message ("Not equal")
					(create {EXCEPTION_MANAGER}).raise (l_e)
				else
					print ('.')
				end
			else
				print ('#')
			end
		rescue
			retried := True
			retry
		end

end

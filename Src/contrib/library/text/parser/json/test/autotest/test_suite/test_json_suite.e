note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_JSON_SUITE

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			create file_reader
		end

feature -- Tests Pass

	test_json_pass1
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("pass1.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("pass1.json",parse_json.is_parsed = True)
			end
		end

	test_json_pass2
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("pass2.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("pass2.json",parse_json.is_parsed = True)
			end
		end

    test_json_pass3
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("pass3.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("pass3.json",parse_json.is_parsed = True)
			end
		end

feature -- Tests Failures
    test_json_fail1
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail1.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail1.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail2
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail2.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail2.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail3
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail3.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail3.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail4
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail4.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail4.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail5
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail5.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail5.json",parse_json.is_parsed = False)
			end
		end


	test_json_fail6
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail6.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail6.json",parse_json.is_parsed = False )
			end
		end

 	test_json_fail7
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail7.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail7.json",parse_json.is_parsed = False)
			end
		end

  	test_json_fail8
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail8.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail8.json",parse_json.is_parsed = False )
			end
		end


	test_json_fail9
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail9.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail9.json",parse_json.is_parsed = False)
			end
		end


	test_json_fail10
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail10.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail10.json",parse_json.is_parsed = False)
			end
		end

   	test_json_fail11
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail11.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail11.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail12
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail12.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail12.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail13
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail13.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail13.json",parse_json.is_parsed = False)
			end
		end

  	test_json_fail14
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail14.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail14.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail15
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail15.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail15.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail16
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail16.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail16.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail17
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail17.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail17.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail18
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail18.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail18.json",parse_json.is_parsed = True)
			end
		end

	test_json_fail19
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail19.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail19.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail20
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail20.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail20.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail21
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail21.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail21.json",parse_json.is_parsed = False)
			end
		end


 	test_json_fail22
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail22.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail22.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail23
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail23.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail23.json",parse_json.is_parsed = False)
			end
		end

 	test_json_fail24
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail24.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail24.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail25
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail25.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail25.json",parse_json.is_parsed = False)
			end
		end


   	test_json_fail26
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail26.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail26.json",parse_json.is_parsed = False)
			end
		end


   	test_json_fail27
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail27.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail27.json",parse_json.is_parsed = False)
			end
		end


   	test_json_fail28
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail28.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail28.json",parse_json.is_parsed = False)
			end
		end


   	test_json_fail29
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail29.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail29.json",parse_json.is_parsed = False )
			end
		end


   	test_json_fail30
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail30.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail30.json",parse_json.is_parsed = False)
			end
		end

	test_json_fail31
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail31.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail31.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail32
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail32.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail32.json",parse_json.is_parsed = False)
			end
		end

    test_json_fail33
    		--
		local
			parse_json: like new_json_parser
		do
			if attached json_file_from ("fail33.json") as json_file then
				parse_json := new_json_parser (json_file)
				json_value := parse_json.parse_json
				assert ("fail33.json",parse_json.is_parsed = False)
			end
		end

feature -- JSON_FROM_FILE

	file_reader: JSON_FILE_READER

	json_value: detachable JSON_VALUE

   	json_file_from (fn: STRING): detachable STRING
		do
			Result := file_reader.read_json_from (test_dir + fn)
			assert ("File contains json data", Result /= Void)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_parser (a_string)
		end

	test_dir: STRING
		local
			i: INTEGER
		do
			Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
				-- The should looks like
				-- ..json\test\autotest\test_suite\EIFGENs\test_suite\Testing\execution\TEST_JSON_SUITE.test_json_fail1\..\..\..\..\..\fail1.json
			from
				i := 5
			until
				i = 0
			loop
				Result.append_character ('.')
				Result.append_character ('.')
				Result.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
				i := i - 1
			end
--			Result := "/home/jvelilla/work/project/Eiffel/ejson_dev/trunk/test/autotest/test_suite/"	
		end

invariant
	file_reader /= Void

end



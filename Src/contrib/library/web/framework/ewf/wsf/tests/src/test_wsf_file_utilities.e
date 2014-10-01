note
	description: "Summary description for {TEST_WSF_FILE_UTILITIES}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_WSF_FILE_UTILITIES

inherit
	EQA_TEST_SET

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create, copy
		end

feature -- Tests

	test_temporary_file_0
		do
			test_temporary_file (0)
		end

	test_temporary_file_1_ns
		do
			test_temporary_file (1)
		end

	test_temporary_file_100_ns
		do
			test_temporary_file (100)
		end

	test_temporary_file_1_s
		do
			test_temporary_file (1_000_000_000)
		end

	new_temp_prefix: STRING
		local
			dt: DATE_TIME
		do
			create dt.make_now_utc
			Result := "TEMP_"
			Result.append_integer (dt.date.ordered_compact_date)
			Result.append_character ('_')
			Result.append_integer (dt.time.compact_time)
			Result.append_character ('.')
--			Result.append_integer (dt.time.milli_second)
			Result.append_integer ((dt.time.fractional_second * 1_000_000_000).truncated_to_integer)
		end

	test_temporary_file (a_delay: INTEGER_64)
		local
			f: detachable FILE
			f1,f2: detachable FILE
			fac: WSF_FILE_UTILITIES [RAW_FILE]
			d: DIRECTORY
			logs: STRING_32
			l_prefix: STRING
		do

			create logs.make (0)

			create d.make_with_path ((create {PATH}.make_current).extended ("_tmp_"))
			d.recursive_create_dir

			create fac

			l_prefix := new_temp_prefix
			f := fac.new_temporary_file (d, l_prefix, "l'été est là!")
			if f /= Void then
				create {RAW_FILE}f1.make_with_path (f.path)
				f1.open_write
				f1.close

				logs.append ("f="); logs.append (f.path.name); logs.append ("%N")
				if a_delay > 0 then
						-- Wait `a_delay' in nanoseconds.
					execution_environment.sleep (a_delay)
					l_prefix := new_temp_prefix
				end
				f1 := fac.new_temporary_file (d, l_prefix, "l'été est là!")

				if a_delay > 0 then
						-- Wait `a_delay' in nanoseconds.
					execution_environment.sleep (a_delay)
					l_prefix := new_temp_prefix
				end
				f2 := fac.new_temporary_file (d, l_prefix, "l'été est là!")

				if f1 /= Void then
					logs.append ("f1="); logs.append (f1.path.name); logs.append ("%N")
					f.put_string ("test")
					f1.put_string ("blabla")
					f1.close
				else
					assert ("able to create new file f1", False)
				end
				if f2 /= Void then
					logs.append ("f2="); logs.append (f2.path.name); logs.append ("%N")
					f.put_string ("TEST")
					f2.put_string ("BLABLA")
					f2.close
				else
					assert ("able to create new file f1", False)
				end
				assert ("f1 /= f2", (f1 /= Void and f2 /= Void) and then (not f1.path.is_same_file_as (f2.path)))
				f.close

				assert ("expected content for f", content (f).same_string ("testTEST"))
				assert ("expected content for f1", content (f1).same_string ("blabla"))
				assert ("expected content for f2", content (f2).same_string ("BLABLA"))
			else
				assert ("able to create new file f", False)
			end
				-- Cleaning

			if f /= Void then
				f.delete
			end
			if f1 /= Void then
				f1.delete
			end
			if f2 /= Void then
				f2.delete
			end


		end

	content (f: detachable FILE): STRING
		do
			create Result.make (0)
			if f /= Void then
				from
					f.open_read
					assert (f.path.utf_8_name + " is opened", f.is_open_read)
				until
					f.end_of_file or f.exhausted
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

end

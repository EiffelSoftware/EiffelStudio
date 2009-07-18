note
	description: "[
		No comment yet.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_UPLOADER

inherit
	EQA_TEST_SET
	XS_SHARED_SERVER_CONFIG
	XWA_CONTROLLER

feature -- Test routines

	test_upload_file
			--
		local
			l_f_utils: XU_FILE_UTILITIES
			l_test_filename: STRING
			l_test_filecontent: STRING
			l_test_tmpfilename: STRING
			l_buf: STRING
			l_res: STRING
		do
			l_test_tmpfilename := "test.tmp"
			l_test_filename := "hallo.text"
			l_test_filecontent := "This is a testfile%NAnd this is a new line."

			create l_f_utils
			if attached {PLAIN_TEXT_FILE} l_f_utils.plain_text_file_write (l_test_tmpfilename) as l_tmp then
				l_tmp.put_string ("-----------------------------172158860518773611771834400137")
				l_tmp.new_line
				l_tmp.put_string ("Content-Disposition: form-data; name=%"file%"; filename=%""+l_test_filename+"%"")
				l_tmp.new_line
				l_tmp.put_string ("Content-Type: text/plain")
				l_tmp.new_line
				l_tmp.new_line
				l_tmp.put_string (l_test_filecontent)
				l_tmp.new_line
				l_tmp.new_line
				l_tmp.put_string ("-----------------------------172158860518773611771834400137")
				l_tmp.close



				if not process_upload_single_file (l_test_tmpfilename, create {FILE_NAME}.make_from_string ("")) then
					assert ("Error processing", False)
				end

				if attached {PLAIN_TEXT_FILE} l_f_utils.plain_text_file_read (l_test_filename) as l_target then
					from
						l_buf := ""
					until
						l_target.after
					loop
						l_target.read_line
						l_buf.append (l_target.last_string + "%N")
					end
					l_buf.remove_tail (2)

					assert ("Content is equal", l_buf.is_equal (l_test_filecontent))
					l_target.close
				else
					assert( "Cannot open target file", False)
				end

			else
				assert ("Could not create tmp file", False)
			end

		end




end


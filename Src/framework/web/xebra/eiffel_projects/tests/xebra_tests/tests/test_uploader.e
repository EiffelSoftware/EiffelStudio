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
		select
			default_create
		end

	XS_SHARED_SERVER_CONFIG
		rename
			default_create as ssc_default_create
		end

	XWA_CONTROLLER
		rename
			default_create as c_default_create
		end

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
			i: INTEGER
		do
			l_test_tmpfilename := "test.tmp"
			l_test_filename := "hallo.text"
			l_test_filecontent := "Blabliblu%NBlaBliaBli%N"

			from
				i := 0
			until
				i = 254
			loop
				l_test_filecontent.append_character (i.to_character_8)
				i := i + 1
			end
			l_test_filecontent.append_character ('%N')

			create l_f_utils
			if attached {PLAIN_TEXT_FILE} l_f_utils.plain_text_file_write (l_test_tmpfilename) as l_tmp then
				l_tmp.put_string ("-----------------------------13689473967984000952010704750%R%NContent-Disposition: form-data; name=%"file%"; filename=%"" + l_test_filename + "%"%R%NContent-Type: text/plain%R%N%R%N" + l_test_filecontent + "%R%N-----------------------------13689473967984000952010704750--%R%N")
				l_tmp.close

				if not attached process_uploaded_single_file (create {FILE_NAME}.make_from_string ("")) then
					assert ("Error processing", False)
				end

				if attached {PLAIN_TEXT_FILE} l_f_utils.plain_text_file_read (l_test_filename) as l_target then
					from
						l_buf := ""
						l_target.start
						l_target.read_character
					until
						l_target.after or l_target.last_character.is_equal ( (255).to_character_8)
					loop
						l_buf.append_character (l_target.last_character)
						l_target.read_character
					end

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


note
	description: "Summary description for {PATH_URI_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PATH_URI_TESTS

inherit
	EQA_TEST_SET

feature -- Test routines

	test_path_to_uri
			-- New test routine
		local
			conv: PATH_URI
		do
			if {PLATFORM}.is_windows then
				create conv.make_from_path (create {PATH}.make_from_string ("c:\foo\bar"))
				assert ("c:\foo\bar", conv.string.same_string ("file:///c:/foo/bar"))

				create conv.make_from_path (create {PATH}.make_from_string ("c:\foo\bar\"))
				assert ("c:\foo\bar\", conv.string.same_string ("file:///c:/foo/bar"))

				create conv.make_from_path (create {PATH}.make_from_string ("c:\"))
				assert ("c:\", conv.string.same_string ("file:///c:/"))
			else
				create conv.make_from_path (create {PATH}.make_from_string ("/foo/bar"))
				assert ("/foo/bar", conv.string.same_string ("file:///foo/bar"))

				create conv.make_from_path (create {PATH}.make_from_string ("/foo"))
				assert ("/foo", conv.string.same_string ("file:///foo"))

				create conv.make_from_path (create {PATH}.make_from_string ("/"))
				assert ("/foo", conv.string.same_string ("file:///"))
			end
		end

	test_relative_path_to_uri
			-- New test routine
		local
			conv: PATH_URI
		do
			if {PLATFORM}.is_windows then
				create conv.make_from_path (create {PATH}.make_from_string ("foo\bar"))
				assert ("foo\bar", conv.string.same_string ("file:foo/bar"))

				create conv.make_from_path (create {PATH}.make_from_string (".\foo\bar"))
				assert (".\foo\bar", conv.string.same_string ("file:./foo/bar"))

				create conv.make_from_path (create {PATH}.make_from_string ("c:foo\bar"))
				assert ("c:foo\bar", conv.string.same_string ("file:c:foo/bar"))
			else
					-- Not sure how to express relative file path with URI ...
			end
		end

	test_uri_to_path
			-- New test routine
		local
			conv: PATH_URI
		do
			if {PLATFORM}.is_windows then
				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///c:/foo/bar"))
				assert ("file:///c:/foo/bar", conv.file_path.name.same_string ("c:\foo\bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///c|/foo/bar"))
				assert ("file:///c|/foo/bar", conv.file_path.name.same_string ("c:\foo\bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///c:/"))
				assert ("file:///c:/", conv.file_path.name.same_string ("c:\"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///c|/"))
				assert ("file:///c|/", conv.file_path.name.same_string ("c:\"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///c:"))
				assert ("file:///c:", conv.file_path.name.same_string ("c:"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///c|"))
				assert ("file:///c|", conv.file_path.name.same_string ("c:"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file://localhost/c:/foo/bar"))
				assert ("file://locahost/c:/foo/bar", conv.file_path.name.same_string ("c:\foo\bar"))
				create conv.make_from_file_uri (create {URI}.make_from_string ("file://127.0.0.1/c:/foo/bar"))
				assert ("file://127.0.0.1/c:/foo/bar", conv.file_path.name.same_string ("c:\foo\bar"))
			else
				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///foo/bar"))
				assert ("file:///foo/bar", conv.file_path.name.same_string ("/foo/bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:///"))
				assert ("file:///", conv.file_path.name.same_string ("/"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file://localhost/foo/bar"))
				assert ("file://locahost/foo/bar", conv.file_path.name.same_string ("/foo/bar"))
				create conv.make_from_file_uri (create {URI}.make_from_string ("file://127.0.0.1/foo/bar"))
				assert ("file://127.0.0.1/foo/bar", conv.file_path.name.same_string ("/foo/bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:/foo/bar"))
				assert ("file:/foo/bar", conv.file_path.name.same_string ("/foo/bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:/"))
				assert ("file:/", conv.file_path.name.same_string ("/"))
			end
		end

	test_relative_uri_to_path
			-- New test routine
		local
			conv: PATH_URI
		do
			if {PLATFORM}.is_windows then
				create conv.make_from_file_uri (create {URI}.make_from_string ("file:c|foo/bar"))
				assert ("file:///c|foo/bar", conv.file_path.name.same_string ("c:foo\bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:./foo/bar"))
				assert ("file:./foo/bar", conv.file_path.name.same_string (".\foo\bar"))

				create conv.make_from_file_uri (create {URI}.make_from_string ("file:foo/bar"))
				assert ("file:foo/bar", conv.file_path.name.same_string ("foo\bar"))
			else
					-- Not sure how to express relative file path with URI ...
			end
		end

end



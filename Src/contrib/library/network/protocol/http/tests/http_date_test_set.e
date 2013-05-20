note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	HTTP_DATE_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_http_date
			-- New test routine
		local
			s: STRING
			d: HTTP_DATE
		do
			s := "Sun, 06 Nov 1994 08:49:37 GMT"
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string (s))
			create d.make_from_timestamp (d.timestamp)
			assert ("RFC 1123", not d.has_error and then d.string.same_string (s))

			s := "Sunday, 06-Nov-94 08:49:37 GMT"
			create d.make_from_string (s)
			assert ("RFC 850", not d.has_error and then d.rfc850_string.same_string (s))
			create d.make_from_timestamp (d.timestamp)
			assert ("RFC 850", not d.has_error and then d.rfc850_string.same_string (s))

			s := "Sun, 06 Nov 1994 08:49:37 GMT"
			create d.make_from_string (s)
			assert ("ANSI C format", not d.has_error and then d.ansi_c_string.same_string ("Sun Nov  6 08:49:37 1994"))


			s := "Sun Nov  6 08:49:37 1994"
			create d.make_from_string (s)
			assert ("ANSI C format", not d.has_error and then d.ansi_c_string.same_string (s))

			-- Tolerance ...
			s := "Sun, 06 November 1994 09:49:37 GMT+1"
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Sun, 06 Nov 1994 08:49:37 GMT"))

			s := "Sun, 06 Nov 1994 09:49:37 GMT+1"
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Sun, 06 Nov 1994 08:49:37 GMT"))

			s := "Sun, 06 Nov 1994 07:49:37 GMT-1"
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Sun, 06 Nov 1994 08:49:37 GMT"))


			s := "Sun, 06 Nov 1994 10:19:37 GMT+1:30"
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Sun, 06 Nov 1994 08:49:37 GMT"))

			s := "Sun, 06 Nov 1994 07:19:37 GMT-1:30"
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Sun, 06 Nov 1994 08:49:37 GMT"))

			s := "Thu, 31 Jan 2013 15:35:00 GMT+5:45" -- NPT
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Thu, 31 Jan 2013 09:50:00 GMT"))

			s := "Thu, 31 Jan 2013 05:20:00 GMT-4:30" -- VET
			create d.make_from_string (s)
			assert ("RFC 1123", not d.has_error and then d.string.same_string ("Thu, 31 Jan 2013 09:50:00 GMT"))

		end

end

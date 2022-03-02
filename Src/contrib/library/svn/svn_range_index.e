note
	description: "[
			Objects that will be used to precise a range of commits, for instance
					   -r123:456
					or -r{2015-06-06}:456

		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=svn revision specifiers", "protocol=URI", "src=http://svnbook.red-bean.com/en/1.7/svn.tour.revs.specifiers.html"

class
	SVN_RANGE_INDEX

create
	make,
	make_from_revision,
	make_from_date,
	make_from_date_time

convert
	make ({READABLE_STRING_8, STRING_8}),
	make_from_revision ({INTEGER}),
	make_from_date ({DATE}),
	make_from_date_time ({DATE_TIME}),
	string: {STRING}

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		do
			string := s.to_string_8
		end

	make_from_revision (rev: INTEGER)
			-- Initialize `Current'.
		do
			make (rev.out)
		end

	make_from_date (dt: DATE)
		local
			s: STRING
		do
			create s.make_empty
			s.append_character ('{')
			s.append_integer (dt.year)
			s.append_character ('-')
			if dt.month < 10 then
				s.append_character ('0')
			end
			s.append_integer (dt.month)
			s.append_character ('-')
			if dt.day < 10 then
				s.append_character ('0')
			end
			s.append_integer (dt.day)
			s.append_character ('}')
			make (s)
		end

	make_from_date_time (dt: DATE_TIME)
		local
			s: STRING
		do
			create s.make_empty
			s.append_character ('{')
			s.append_integer (dt.year)
			s.append_character ('-')
			if dt.month < 10 then
				s.append_character ('0')
			end
			s.append_integer (dt.month)
			s.append_character ('-')
			if dt.day < 10 then
				s.append_character ('0')
			end
			s.append_integer (dt.day)
			s.append_character ('T')
			if dt.hour < 10 then
				s.append_character ('0')
			end
			s.append_integer (dt.hour)
			s.append_character (':')
			if dt.minute < 10 then
				s.append_character ('0')
			end
			s.append_integer (dt.minute)
			s.append_character ('Z')
			s.append_character ('}')
			make (s)
		end

feature -- Access

	string: STRING

;note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end

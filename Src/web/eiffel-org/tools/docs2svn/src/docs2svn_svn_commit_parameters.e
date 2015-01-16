note
	description: "Summary description for {DOCS2SVN_SVN_COMMIT_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCS2SVN_SVN_COMMIT_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (d: like date; a: like author; l: like log)
		do
			date := d
			author := a
			log := l
		end

feature -- Access

	date: DATE_TIME

	log: detachable READABLE_STRING_8

	author: detachable READABLE_STRING_8

feature -- Conversion

	commit_log: STRING
		do
			if attached log as l_log then
				create Result.make_from_string (l_log)
				Result.append ("%N%N")
			else
				create Result.make_empty
			end
			if attached author as l_author then
				Result.append ("Author:")
				Result.append (l_author)
				Result.append ("%N")
			end
			Result.append ("Date:")
			Result.append (svn_date (date))
			Result.append ("%N")
		end

	iso_date_string: STRING
		do
			Result := svn_date (date)
		end

	svn_date (d: DATE_TIME): STRING
		do
			create Result.make_empty
			Result.append_integer (d.year)
			Result.append_character ('-')
			Result.append_string (two_digit (d.month))
			Result.append_character ('-')
			Result.append_string (two_digit (d.day))
			Result.append_character ('T')
			Result.append_string (two_digit (d.hour))
			Result.append_character (':')
			Result.append_string (two_digit (d.minute))
			Result.append_character (':')
			Result.append_string (two_digit (d.second))
			Result.append_string (".000000Z")
		end

	two_digit (n: INTEGER): STRING
		do
			create Result.make (2)
			if n <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (n)
		end

end

note
	description: "Summary description for {FEED_HELPERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_HELPERS

feature -- Helpers

	date_time (a_date_string: READABLE_STRING_32): DATE_TIME
			-- "2015-08-14T10:34:13.493740Z"
			-- "Sat, 07 Sep 2002 00:00:01 GMT"
		local
			i,j: INTEGER
			s: READABLE_STRING_GENERAL
			y,m,d,h,min: INTEGER
			sec: REAL_64
			htdate: HTTP_DATE
			str: STRING_32
		do
			if a_date_string.count > 0 and then a_date_string.item (1).is_digit then
				i := a_date_string.index_of ('-', 1)
				if i > 0 then
					s := a_date_string.substring (1, i - 1)
					y := s.to_integer_32 -- Year
					j := i + 1
					i := a_date_string.index_of ('-', j)
					if i > 0 then
						s := a_date_string.substring (j, i - 1)
						m := s.to_integer_32 -- Month
						j := i + 1
						i := a_date_string.index_of ('T', j)
						if i = 0 then
							i := a_date_string.index_of (' ', j)
						end
						if i = 0 then
							i := a_date_string.count + 1
						end
						if i > 0 then
							s := a_date_string.substring (j, i - 1)
							if s.is_integer then
								d := s.to_integer_32 -- Day							
								j := i + 1
								i := a_date_string.index_of (':', j)
								if i > 0 then
									s := a_date_string.substring (j, i - 1)
									h := s.to_integer
									j := i + 1
									i := a_date_string.index_of (':', j)
									if i > 0 then
										s := a_date_string.substring (j, i - 1)
										min := s.to_integer
										j := i + 1
										i := a_date_string.index_of ('Z', j)
										if i = 0 then
											i := a_date_string.count + 1
										end
										s := a_date_string.substring (j, i - 1)
										sec := s.to_double
									end
								end
							end
						end
					end
				end
				create Result.make (y,m,d,h,m,0)
				Result.fine_second_add (sec)
			else
				i := a_date_string.index_of ('+', 1)
				if i > 0 then
					str := a_date_string.substring (1, i - 1)
					str.append (" GMT")
					create htdate.make_from_string (str)
					Result := htdate.date_time
					if a_date_string.substring (i + 1, a_date_string.count).is_case_insensitive_equal ("0000") then

					end
				else
					create htdate.make_from_string (a_date_string)
					Result := htdate.date_time
				end
			end
		end

end

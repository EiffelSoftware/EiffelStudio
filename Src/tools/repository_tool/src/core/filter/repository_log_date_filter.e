note
	description: "Summary description for {REPOSITORY_LOG_AUTHOR_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_DATE_FILTER

inherit
	REPOSITORY_LOG_FILTER

create
	make

feature {NONE} -- Initialization

	make (d1: like lower_date; d2: like upper_date)
		do
			lower_date := d1
			upper_date := d2
		end

feature -- Access

	lower_date: detachable STRING
	upper_date: detachable STRING

feature -- Status report

	matched (a_log: REPOSITORY_LOG): BOOLEAN
		local
			d: like {REPOSITORY_LOG}.date
		do
			d := a_log.date
			Result := True
			if attached lower_date as d1 then
				Result := d1 <= d
			end
			if Result and attached upper_date as d2 then
				Result := d <= d2
			end
		end

	to_string: STRING
		do
			create Result.make_from_string ("dates=")
			if attached lower_date as d1 then
				Result.append_string ("[")
				Result.append_string (d1)
			else
				Result.append_string ("]")
			end
			Result.append_string (",")
			if attached upper_date as d2 then
				Result.append_string (d2)
				Result.append_string ("]")
			else
				Result.append_string ("[")
			end
		end

end

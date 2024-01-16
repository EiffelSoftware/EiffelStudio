note
	description: "Summary description for {DBG_CHRONO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DBG_CHRONO

feature -- Access

	start (id: READABLE_STRING_GENERAL)
		do
			if attached timer (id) as t then
				t.start_time := create {DATE_TIME}.make_now
				t.end_time := Void
			end
		ensure
			class
		end

	stop (id: READABLE_STRING_GENERAL)
		do
			if attached timer (id) as t then
				t.end_time := create {DATE_TIME}.make_now
			else
				check has_timer: False end
			end
		ensure
			class
		end

	report (id: READABLE_STRING_GENERAL): STRING_32
		local
			s,e: DATE_TIME
			d: INTEGER_64
		do
			create Result.make (20)
			Result.append_string_general ("Chrono:")
			Result.append (id)
			if attached timer (id) as t then
				s := t.start_time
				e := t.end_time
				if s = Void then
					Result.append_string_general (" not started")
				else
					if e = Void then
						create e.make_now
						Result.append_string_general (" started")
					end
					d := e.relative_duration (s).seconds_count
					Result.append_character (' ')
					Result.append_string_general (d.out)
					Result.append_string_general (" second")
					if d > 1 then
						Result.append_character ('s')
					end
					if e = Void then
						Result.append_string_general (" ago")
					end
				end
			else
				Result.append_string_general (" None")
			end
		ensure
			class
		end

	report_line (id: READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make (20)
			Result.append (report (id))
			Result.append_character ('%N')
		ensure
			class
		end

	remove (id: READABLE_STRING_GENERAL)
		do
			timers [id] := Void
		ensure
			class
		end

feature {NONE} -- Implementation

	timer (id: READABLE_STRING_GENERAL): TUPLE [start_time, end_time: detachable DATE_TIME]
		do

			Result := timers [id]
			if Result = Void then
				create Result
				timers [id] := Result
			end
		ensure
			class
		end

	timers: STRING_TABLE [TUPLE [start_time, end_time: detachable DATE_TIME]]
		once
			create Result.make_caseless (1)
		ensure
			class
		end

end

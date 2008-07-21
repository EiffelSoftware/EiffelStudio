
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit
	EXCEPTIONS

create
	make

feature

	make (arr: ARRAY [STRING])
			-- Run application.
		local
			l_retr: BOOLEAN
			l_trace : STRING
			l_start: INTEGER
		do
			if not l_retr then
				ocall
			end
		rescue
			l_trace := exception_trace
			l_start := l_trace.substring_index ("make", 1)
			if l_start > 0 then
				l_start := l_trace.substring_index ("make", l_start + 4)
				if l_start > 0 then
					print ("Trace has more than one makes!%N")
					print (l_trace)
					io.put_new_line
				end
			else
				print ("Trace has no make!%N") 
				print (l_trace)
				io.put_new_line
			end
			l_retr := True
			retry
		end

	ocall is
		once
			(create {DEVELOPER_EXCEPTION}).raise
		end

end

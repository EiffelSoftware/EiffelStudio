
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
		local
			l_retr: BOOLEAN
			l_trace : STRING
			l_start: INTEGER
		do
			if status = req then
				status := chec
			else
				status := req
			end
			if status /= test_finished then
				test
			end
		rescue
			l_trace := exception_trace
			l_start := l_trace.substring_index ("Pass", 1)
			if l_start > 0 then
				print ("Trace has Pass!%N") 
				print (l_trace)
				io.put_new_line
			end
			l_retr := True
			retry
		end

	test
			-- Run application.
		require
			(status = req) implies (s.is_empty or (status = req))
		local
			l_retr: BOOLEAN
			l_trace : STRING
			l_start: INTEGER
		do
			check (status = chec) implies (s.is_empty or (status = chec)) end
		ensure
			(status = post) implies (s.is_empty or (status = post))
		rescue
			l_trace := exception_trace
			l_start := l_trace.substring_index ("Pass", 1)
			if l_start > 0 then
				print ("Trace has Pass!%N") 
				print (l_trace)
				io.put_new_line
			end
			l_retr := True
			if status = chec then
				status := post
			elseif status = post then
				status := invar
			elseif status = invar then
				status := test_finished
			end
			retry
		end

	s: STRING
		
	status: INTEGER
	
	req: INTEGER = unique
	chec: INTEGER = unique
	post: INTEGER = unique
	invar: INTEGER = unique
	test_finished: INTEGER = unique
	
invariant
	(status = invar) implies (s.is_empty or (status = invar))

end

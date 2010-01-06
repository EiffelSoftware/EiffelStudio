
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class WORKER
inherit
	THREAD
	EXCEPTIONS
feature

	make (a_depth, a_count: INTEGER a_name: STRING a_wrong_list: LIST [STRING]) is
		do
			depth := a_depth
			count := a_count
			name := a_name
			wrong_names := a_wrong_list
		end;

	execute is
		local
			k: INTEGER
		do
			from
				k := 1
			until
				k > count
			loop
				routine (depth)
				k := k + 1
			end
		end;

	routine (n: INTEGER) is
		local
			tried: BOOLEAN
		do
			if not tried then
				if n > 0 then
					routine (n - 1)
				else
					raise (name)
				end
			end
		rescue
			check_trace (exception_trace)
			tried := True
			retry
		end;

	check_trace (a_trace: STRING)
		do
			from
				wrong_names.start
			until
				wrong_names.after
			loop
				check_one_wrong_name (wrong_names.item, a_trace)
				wrong_names.forth
			end
		end

	check_one_wrong_name (a_name, a_trace: STRING)
		local
			pos: INTEGER
		do
			pos := a_trace.substring_index (a_name, 1)
			if pos > 0 then
				print ("Found " + a_name + " in " + name + "%N")
			end
		end

	depth: INTEGER

	count: INTEGER
	
	name: STRING
	
	wrong_names: LIST [STRING]

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class WORKER
inherit
	THREAD
		rename
			sleep as thread_sleep
		end

	EXECUTION_ENVIRONMENT
		rename
			launch as exec_env_launch
		end

create
	make

feature

	make (n: INTEGER nsecs: INTEGER_64)
		do
			iterations := n
			nanoseconds := nsecs
		end;

	execute is
		local
			k: INTEGER
		do
			from
				k := 1
			until
				k > iterations
			loop
				sleep (nanoseconds)
				k := k + 1
			end
		end;

	iterations: INTEGER

	nanoseconds: INTEGER_64

end

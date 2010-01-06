
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class WORKER
inherit
	THREAD
	MEMORY
create
	make

feature

	make (n: INTEGER) is
		do
			count := n
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
				try
				k := k + 1
			end
		end;

	try
		local
			s: STRING
			list: ARRAYED_LIST [STRING]
			n: INTEGER
		do
			s := "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
			create list.make (1000)
			list.extend (s)
			n := referers (s).count
			if n /= 1 and not {PLATFORM}.is_dotnet then
				print (n.out + " objects refer to string%N")
			end
		end

	count: INTEGER

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
creation
	make
feature
	make is
		do
			try;
		end

	try is
		do
			count := count + 1;
			io.putstring ("In body: count is ");
			io.putint (count); io.new_line;
			if count < 10 then
				raise ("weasels");
			end
		rescue
			io.putstring ("In rescue clause: count is ");
			io.putint (count); io.new_line;
			inspect count
			when 1 then
				try
			when 2 then
				try
			else
				retry;
			end
			retry
		end
	
	count: INTEGER
end

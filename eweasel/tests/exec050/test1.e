
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	SHOW
	TEST2
		rename
			try1 as try,
			try2 as try,
			try3 as try
		end
creation
	make
feature
	make is
		local
			tried: BOOLEAN
		do
			if not tried then
				try
			end
		rescue
			tried := True;
			io.putstring ("In rescue clause%N");
			retry;
		end

	try is
		require else
			assert: show ("Precondition of try in TEST1");
		do
		ensure then
			assert: show ("Postcondition of try in TEST1");
		end

end


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
			try
			io.put_string ("All done%N")
		end;

	try is
		require
			weasel
		do
		end
	
	weasel: BOOLEAN is
		local
			tried: BOOLEAN;
		do
			if not tried then
				raise ("weasels");
			end
			Result := True;
		rescue
			tried := True;
			retry;
		end;

end

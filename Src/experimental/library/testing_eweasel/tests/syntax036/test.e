
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			p: POINTER;
		do
			p := $weasel;
			p := $wimp;
			p := ptr ($weasel);
			p := ptr ($wimp);
		end
	
	ptr (p: POINTER): POINTER is
		do
			Result := p;
		end

	weasel (p: POINTER) is
		do
		end
	
	wimp (p: POINTER) is
		external "C"
		end
end

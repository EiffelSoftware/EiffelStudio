
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature
	
	f, g is
		do
		end

	prefix "+": INTEGER is
		do
		end

	prefix "@weasel": INTEGER is
		do
		end

	prefix "@wuss": INTEGER is
		do
		end

	infix "-" (n: INTEGER): INTEGER is
		do
		end

	infix "@wimp" (n: INTEGER): INTEGER is
		do
		end

	infix "@wuss" (n: INTEGER): INTEGER is
		do
		end

end

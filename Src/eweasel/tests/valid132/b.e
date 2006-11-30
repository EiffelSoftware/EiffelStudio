
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class B
inherit
	A
		redefine f end

feature
		
	f is
		$PRE
		do
		$POST
		end

end

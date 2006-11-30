
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class D
inherit
	C [A]
		rename f as fa select fa end
	C [$B]
		rename f as fb end
end

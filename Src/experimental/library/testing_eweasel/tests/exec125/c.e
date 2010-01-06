
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class C [G -> ANY create default_create end]
feature
	f is
		local
			l: G
		do
			create l
			print (l.generating_type)
		end
end

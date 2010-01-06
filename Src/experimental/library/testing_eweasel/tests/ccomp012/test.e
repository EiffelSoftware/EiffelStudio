
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	full_collect
feature
	full_collect is
			-- Force a full collection cycle if the garbage 
			-- collector is enabled; do nothing otherwise.
		external
			"C use %"eif_garcol.h%""
		alias
			"plsc"
		end;
end

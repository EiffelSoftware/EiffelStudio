
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
feature
	
	value (n: G): G is 
		external "C inline"
		alias 
		"[
#ifndef XXEWEASEL_EIF_REFERENCE
#define XXEWEASEL_EIF_REFERENCE 1
#endif
#ifndef XXEWEASEL_EIF_REAL_64
#define XXEWEASEL_EIF_REAL_64 2
#endif

#if XXEWEASEL_$$_result_type == XXEWEASEL_EIF_REFERENCE
			return eif_access($n);
#else
			return $n;
#endif
		]"
		end


end

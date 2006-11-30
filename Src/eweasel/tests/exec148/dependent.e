
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class
	DEPENDENT [U->SUBJECT, SUB_S->SUBJECT]
	
	-- Strange, if first parameter (U) is removed, the example works

inherit	
	PROTO [SUBJECT, LINEAR[SUB_S]]

	
end -- class DEPENDENT

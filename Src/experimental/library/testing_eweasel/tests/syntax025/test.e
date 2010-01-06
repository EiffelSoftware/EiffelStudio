
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler reports wrong position for
	--	syntax error.  Replace Ctrl-@ with Ctrl-A.  Also
	--	wrong position.

class TEST




$SYNTAX_ERROR
creation
	make
feature

	make is
		do
		end;

end

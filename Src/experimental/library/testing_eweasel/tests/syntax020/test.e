
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Compiler accepts it, although it
	-- should not since all attributes use names which are
	-- reserved words (and therefore not legal identifiers).

class TEST


creation
	make
feature

	make is
		do
		end;

	$VAR_NAME:	INTEGER;

end

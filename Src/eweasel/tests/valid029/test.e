
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Deferred root class accepted, but should
	--	not be.  (Note: Ace must specify no creation procedure).

deferred class 
	TEST
feature
	deferred_feature is
		deferred
		end;
end

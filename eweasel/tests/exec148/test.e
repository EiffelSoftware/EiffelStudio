
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation make

feature {NONE} -- Initialization
	make is 
	local
		dep: DEPENDENT [SUBJECT, SUBJECT]
	do
	  create dep
	  dep.set_func (agent {SUBJECT}.theFunction)
	end

end

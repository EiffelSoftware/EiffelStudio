
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
		l_func: MY_FUNCTION [SUBJECT, TUPLE [SUBJECT], LINKED_LIST [SUBJECT]]
	do
	  create dep
	  create l_func
	  dep.set_func (l_func)
	end

end

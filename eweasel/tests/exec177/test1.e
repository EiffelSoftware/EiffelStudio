
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2]

create
	make

feature
	make is
		do
			try
		end

	try is
		local
			f: FUNCTION [G, TUPLE [G], BOOLEAN]
		do
			print ((agent {G}.is_stopable).generating_type);
			io.new_line
			f ?= agent {G}.is_stopable
			print (f /= Void);
			io.new_line
		end


end

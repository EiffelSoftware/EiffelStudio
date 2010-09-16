
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G]
feature
	weasel is
		local
			b: G;
		do
			print (generator_of (b)); io.new_line;
		end

feature {NONE} -- Helper

	generator_of (v: G): STRING
		require
			v_attached: v /= Void
		do
			Result := v.generator
		ensure
			result_attached: Result /= Void
		end
		
end

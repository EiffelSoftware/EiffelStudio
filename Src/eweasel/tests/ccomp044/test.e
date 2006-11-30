
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create make
feature
	make is
		local
			f: FAKE [STRING]
			g: IMPLEMENTED
			a: ANY
		do
			create g
--			a := agent f.f
--			a := agent f.g
			a := agent g.f
			a := agent g.g
		end
end


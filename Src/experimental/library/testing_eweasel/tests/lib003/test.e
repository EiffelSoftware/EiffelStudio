
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation 
	make
feature
        make is
		local
			f, g: PLAIN_TEXT_FILE
        	do
			create f.make_open_read ("input")
			create g.make_open_write ("output")
			f.read_stream (10000)
			f.copy_to (g)
			f.close
			g.close
        	end
	
end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation 
	make
feature 
	make is
		do
			io.put_integer (try.capacity); io.new_line
  		end
	
	try: STRING is
		do
			Result := create {SEQ_STRING} .make (47)
  		end
	
end

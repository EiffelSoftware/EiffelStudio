
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> ANY create default_create end]

feature
        weasel
                do
			create x
			print (x.generator); io.new_line
                end

        x: G

end

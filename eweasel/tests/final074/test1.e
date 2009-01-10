
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1

feature
        try
                do
			create t
                        t.disable_sensitive
                        try2 (<< "Weasel", "Stoat" >>)
                end

        try2 (a: ARRAY [STRING])
                do
                        print (a.count); io.new_line
                        print (a.item (1)); io.new_line
                        print (a.item (2)); io.new_line
                end

	t: TEST2

        weasel: STRING

        stoat: STRING

end

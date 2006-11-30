
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
                        b, c, l_match: BOOLEAN
                do
                        if b then
                        else
                                if c then
                                        l_match := l_match and False
                                end
                        end
                        l_match := True
                end;

end

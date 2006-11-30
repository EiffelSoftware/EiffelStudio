
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
			t: like n
		do
			t := n
			print (try (t)); io.new_line
		end

	try (t: like n): like t is
		do
			Result := t
		end

	$ANCHOR
end

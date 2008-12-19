
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

$EXPANDED
class TEST

create
	make
	$DEFAULT_CREATE
feature

	make is
		do
			try
		end

	try is
		do
			print (x); io.new_line
		end

	x: TEST
		do
		end

end

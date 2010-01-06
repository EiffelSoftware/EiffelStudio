
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS

creation
	make

feature
	make is
		do
			try
		end

	try is
		require
			pre1: show_value ("Evaluating pre1")
		local
			tried: BOOLEAN
		do
			if not tried then
				try2
			end
		rescue
			tried := True
			print ("Retrying") io.new_line
			retry
		end

	try2 is
		do
			raise ("Abort")
		end

	show_value (s: STRING): BOOLEAN is
		do
			io.put_string (s);
			io.new_line
			Result := True
		end

end


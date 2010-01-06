
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make (args: ARRAY [STRING]) is
		local
			f: PLAIN_TEXT_FILE
			arg: INTEGER
		do
			arg := args.item (1).to_integer
			print ("Weasels%N")
			if arg = 1 then
				create f.make (profinfo_name)
				if not f.exists then
					print ("File " + profinfo_name + " not found%N")
				end
			end
		end

	profinfo_name: STRING is "$PROFINFO_NAME"

end

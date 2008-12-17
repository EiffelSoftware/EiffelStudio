
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST

create
	make

feature

	make is
		local
			s: STRING
		do
			s := out
			if s.substring_index ("WEASEL", 1) > 0 then
				print ("WEASEL%N")
			end
			if s.substring_index ("STOAT", 1) > 0 then
				print ("STOAT%N")
			end
		end

	a: $CLASS_NAME

end

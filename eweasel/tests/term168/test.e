
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.



class TEST

create
	make

feature

	make is
		do
			print ((agent : STRING attribute Result := "weasel" end).item ([])); io.new_line
		end

end

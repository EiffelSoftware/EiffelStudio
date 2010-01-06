
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST

create
	make

feature

	make is
		do
			print (s.generating_type); io.new_line
		end

	s: like Current
		attribute
			Result := Current
		end
end

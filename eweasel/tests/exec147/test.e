
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create make
feature
	make is
		local
			l_toto: ARRAY [CLASS_A]
			l_class_a: CLASS_A
			l_tata: COMPOSITE_CLASS
			l_titi: expanded COMPOSITE_CLASS
			l_any: ANY
		do
			l_any := <<l_class_a, l_class_a>>
			l_titi.default_create
			create l_tata
			create l_toto.make (1, 5)
			print (l_toto.area.item (3).a_value)
			io.new_line;
			l_toto.force (l_class_a, 10)
			print (l_toto.area.count)
			io.new_line;
			print (l_toto.area.item (7).a_value)
			io.new_line;
		end

end


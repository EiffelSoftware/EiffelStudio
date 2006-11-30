
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2]

create
	make

feature
	make (x: G) is
		do
			value := x
			process_select_stopable
		end

	process_select_stopable is
		do
			process_select_rows_filtered (agent {G}.is_stopable)
		end

	process_select_rows_filtered (filter: FUNCTION [G, TUPLE [G], BOOLEAN]) is
		do
			print (filter.item ([value]));
			io.new_line
		end

	value: G
end

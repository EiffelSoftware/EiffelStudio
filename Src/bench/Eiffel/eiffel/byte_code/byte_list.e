-- List used in the byte code generation.
-- Defines some of the commonly used iterations.

class BYTE_LIST [T -> BYTE_NODE] 

inherit

	BYTE_NODE
		undefine
			twin
		redefine
			enlarge_tree, analyze, generate, make_byte_code
		end;
	FIXED_LIST [T]

creation

	make

feature 

	analyze is
			-- Loop over `list' and analyze each item
		do
			from
				start;
			until
				offright
			loop
				item.analyze;
				forth;
			end;
		end;

	generate is
			-- Loop over `list' and generate each item
		do
			from
				start;
			until
				offright
			loop
				item.generate;
				forth;
			end;
		end;

	enlarge_tree is
			-- Loop ovet `list' and enlarges each item
		do
			from
				start;
			until
				offright
			loop
				if item.need_enlarging then
					put (item.enlarged);
				else
					item.enlarge_tree;
				end;
				forth;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generates byte code for element in the list
		do
			from
				start
			until
				offright
			loop
				item.make_byte_code (ba);
				forth;
			end;
		end;

end

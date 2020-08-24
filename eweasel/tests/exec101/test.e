
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature

	make (args: ARRAY [STRING])
		local
			k, count: INTEGER;
			str: STRING;
		do
			count := args.item (1).to_integer ;
			create list.make;
			list.extend (Void);
			from
				k := 1;
			until
				k > count
			loop
				str := strip_error (strip ());
				if str /= Void then
					io.putstring ("Iteration ");
					io.putint (k);
					io.putstring (": ");
					io.putstring (str);
					io.new_line;
				end
				k := k + 1;
			end
		end
	
	list: LINKED_LIST [STRING];

	strip_error (a: ARRAY [ANY]): STRING
		local
			the_list: LINKED_LIST [STRING];
		do
			Result := Void;
			if a.count /= 1 then
				Result := "Not exactly one item in strip array";
			elseif a.lower /= 1 then
				Result := "Lower bound of strip array is not 1";
			else
				the_list ?= a.item (1);
				if the_list = Void then
					Result := "First element of strip does not conform to LINKED_LIST [STRING]";
					-- print (a.item (1));
				elseif the_list.count /= 1 then
					Result := "Not exactly one element in LINKED_LIST [STRING]";
				elseif the_list.i_th (1) /= Void then
					Result := "First item in LINKED_LIST [STRING] is not Void";
				end
			end
		end	
	
end

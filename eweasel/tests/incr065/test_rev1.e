
--| Copyright (c) 1993-2021 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		local
			s: STRING;
		do
			s := Current #index 3;
			print (s);
			s := Current #Index 3;
			print (s);
			s := Current #INDEX 3;
			print (s);
		end;
	
	g alias "#index" (a: INTEGER): STRING is
		do
			io.putstring ("In lowercase index%N");
			Result := "1";
		end;

	h alias "#INdex" (a: INTEGER): STRING is
		do
			io.putstring ("In uppercase Index%N");
			Result := "2";
		end;

	i alias "#INDEX" (a: INTEGER): STRING is
		do
			io.putstring ("In uppercase INDEX%N");
			Result := "3";
		end;

end 

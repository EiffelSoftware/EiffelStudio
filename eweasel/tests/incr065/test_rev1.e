
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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
			s := Current @index 3;
			print (s);
			s := Current @Index 3;
			print (s);
			s := Current @INDEX 3;
			print (s);
		end;
	
	infix "@index" (a: INTEGER): STRING is
		do
			io.putstring ("In lowercase index%N");
			Result := "1";
		end;

	infix "@INdex" (a: INTEGER): STRING is
		do
			io.putstring ("In uppercase Index%N");
			Result := "2";
		end;

	infix "@INDEX" (a: INTEGER): STRING is
		do
			io.putstring ("In uppercase INDEX%N");
			Result := "3";
		end;

end 

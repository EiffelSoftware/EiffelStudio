
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test'.
	-- Binary free operators should have higher precedence in
	--	each case, but they don't.

class TEST

	
creation
	make
feature

	make is
		do
			print ($EXPRESSION); io.new_line;
		end;

	infix "#" (n: INTEGER): BOOLEAN is
		do
			io.putstring ("Argument to infix %"#%" is ");
			io.putint (n); io.new_line;
			Result := True;
		end;

	infix "##" (n: BOOLEAN): BOOLEAN is
		do
			io.putstring ("Argument to infix %"##%" is ");
			io.putbool (n); io.new_line;
			Result := True;
		end;

	infix "###" (n: BOOLEAN): INTEGER is
		do
			io.putstring ("Argument to infix %"###%" is ");
			io.putbool (n); io.new_line;
			Result := 0;
		end;

end


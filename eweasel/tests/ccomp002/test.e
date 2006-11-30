
	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  
	--	The generated C file for this class won't compile.

class 
	TEST
creation
	make
feature

	make is
		do
			print (Current #123" 2);
		end;

	infix "#123%"" (arg: INTEGER): INTEGER is
		do
			Result := arg + 47;
		end;

end



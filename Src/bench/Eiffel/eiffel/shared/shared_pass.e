class SHARED_PASS
	
feature {NONE}

	pass1_controler: PASS1 is
			-- Controler for pass 1
		once
			!!Result.make
		end;

	pass2_controler: PASS2 is
			-- Controler for pass 2
		once
			!!Result.make
		end;

	pass3_controler: PASS3 is
			-- Controler for pass 3
		once
			!!Result.make
		end;

	pass4_controler: PASS4 is
			-- Controler for pass 4
		once
			!!Result.make
		end;

end

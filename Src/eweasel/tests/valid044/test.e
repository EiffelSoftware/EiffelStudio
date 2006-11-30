
	-- To reproduce error:
	-- Compile class as is.  Reports violation of VQMC, even though
	--	`1B' is a bit constant and `BIT 5' is a bit type.

class 
	TEST
creation
	make
feature

	make is
		do
		end;

	s: BIT 5 is 1B;

end



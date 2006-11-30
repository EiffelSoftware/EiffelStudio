class
	TEST1

feature -- Access
	make
		do
			interface (<<agent f, agent g>>,  << pid($f), pid($g) >>)
		end

	interface (b: ARRAY [FUNCTION [ANY, TUPLE, INTEGER]]; a: ARRAY [POINTER]) is
			--
		do

		end


	f: INTEGER is
		do
		end

	g: INTEGER is
		do
		end

	pid (p: POINTER): POINTER is
			--
		do
			Result := p
		end

end

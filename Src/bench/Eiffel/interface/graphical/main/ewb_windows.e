
class EWB_WINDOWS

inherit
	EWB
		redefine
			init_toolkit
		end

creation
	make

feature {NONE}

	init_toolkit: WINDOWS is once !!Result.make ("ewb") end;

feature 

	create_handler is
		do
			io.error.putstring ("NOT IMPLEMENTED!!!!%N");
		end;

end

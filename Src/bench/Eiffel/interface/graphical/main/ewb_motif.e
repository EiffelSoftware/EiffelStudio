class EWB_MOTIF

inherit
	EWB_UNIX
		redefine
			init_toolkit
		end

creation
	make

feature {NONE}

	init_toolkit: MOTIF is once !!Result.make ("ewb") end;

end

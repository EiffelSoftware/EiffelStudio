class EBUILD_MSWIN

inherit

	EBUILD
		redefine
			init_toolkit
		end

creation

	make

feature {NONE}		

	init_toolkit: MS_WINDOWS is 
		once 
			!! Result.make (application_name) 
		end

end

class EBUILD_MOTIF

inherit

	EBUILD_UNIX
		redefine
			init_toolkit
		end

creation

	make

feature {NONE}

	XeiffelBuild: STRING is "XeiffelBuild";

	init_toolkit: MOTIF is 
		once 
			!! Result.make (XeiffelBuild) 
		end

end

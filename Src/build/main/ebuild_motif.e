class EBUILD_MOTIF

inherit

	EBUILD_UNIX
		redefine
			init_toolkit
		end

creation

	make

feature {NONE}

	X_resources_file_name: STRING is "ebuild";
			-- X resources file name for Eiffel build			

	init_toolkit: MOTIF is 
		once 
			!! Result.make (X_resources_file_name) 
		end

end

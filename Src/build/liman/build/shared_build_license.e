indexing
	description: "License controlling for EiffelBuild";
	date: "$Date$";
	revision: "$Revision$"

class 
	SHARED_BUILD_LICENSE

inherit
	SHARED_LICENSE
		redefine
			new_license
		end
	
feature {NONE}
	
	new_license: LICENSE is
		do
			!BUILD_LICENSE!Result.make
		end


end -- class SHARED_BUILD_LICENSE

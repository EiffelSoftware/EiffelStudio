indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	SHARED_CASE_LICENCE

inherit 
	SHARED_LICENSE
		redefine
			new_license
		end

feature

	new_license: LICENSE is
		do
			! CASE_LICENCE ! Result.make
		end	


end -- class SHARED_CASE_LICENCE

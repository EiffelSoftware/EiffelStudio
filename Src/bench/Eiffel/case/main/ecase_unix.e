indexing

	description: 
		"Ancestor of root class for Unix platforms which%
		%has the license manager";
	date: "$Date$";
	revision: "$Revision $"

class ECASE_UNIX

inherit

	ECASE
		redefine
			new_license
		end

feature {NONE} -- Implementation

	new_license: CASE_LICENCE is
			-- New licence specifically for EiffelCase
		do	
			--!CASE_LICENCE! Result.make (Environment.eiffel3_directory);
			!CASE_LICENCE! Result.make
		end;

end -- class ECASE_UNIX

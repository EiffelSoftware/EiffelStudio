indexing

	description: 
		"Root class for eiffelcase using the MOTIF toolkit%
		%with the license manager enabled.";
	date: "$Date$";
	revision: "$Revision $"

class ECASE_MOTIF

inherit

	ECASE_BASIC_MOTIF
		undefine
			new_license
		end;
	ECASE_UNIX
		undefine
			init_toolkit
		end

creation

	make

end -- class ECASE_MOTIF

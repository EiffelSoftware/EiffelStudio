indexing

	description: 
		"Command to store Eiffelcase readable format of system.";
	date: "$Date$";
	revision: "$Revision $"

class E_STORE_CASE_INFO 

inherit

	E_CMD

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			format_storage: FORMAT_CASE_STORAGE
		do
			!! format_storage;
			format_storage.execute
		end;

end -- class E_STORE_CASE_INFO 

indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	S_SYSTEM_DATA_DUMMY

inherit

	COMPILER_EXPORTER

creation
	make

feature
	
	make is do end

	class_id ( i : CLASS_ID ): INTEGER is
		do
			Result := i.id
		end 

end -- class S_SYSTEM_DATA_DUMMY

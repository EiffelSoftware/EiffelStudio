indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GET_INFO

inherit
	
	CONSTANTS


feature --infos

	printer : STRING is 
	do
		Result := clone( Resources.printer_command )
	end

end -- class GET_INFO

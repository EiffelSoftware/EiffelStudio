indexing
	description: "Objects that ..."
	author: "Mark Howard, Axa-Rosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_COMPILE

creation
	make

feature 
	make (a_arguments: ARRAY[STRING]) is
		do
			if a_arguments.count > 1 then
				create top_directory.make(a_arguments.item(1))
				top_directory.convert
			end
		end

	top_directory : EIFFEL_F_CODE_DIRECTORY

end
   

indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Stringtable_resource -> "STRINGTABLE" Stringtable_options "BEGIN" Strings_list "END"

class STRINGTABLE_RESOURCE

inherit
	S_STRINGTABLE_RESOURCE
		redefine 
			pre_action
		end

	TABLE_OF_SYMBOLS

creation
	make

feature 

	pre_action is
		local
			stringtable: TDS_STRINGTABLE
		do     
			!! stringtable.make

			tds.insert_resource (stringtable)
			tds.set_current_resource (stringtable)
		end

end -- class STRINGTABLE_RESOURCE

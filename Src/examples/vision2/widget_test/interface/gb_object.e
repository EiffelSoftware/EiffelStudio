indexing
	description: "An empty class to ensures files from Build compile."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT
	
feature

	output_name: STRING
	
	name: STRING
	
	type: STRING
	
	children: ARRAYED_LIST [GB_OBJECT]

end -- class GB_OBJECT

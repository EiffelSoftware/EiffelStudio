indexing
	description: "All information about the wizard ... This class is inherited in each state "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

Creation
	make

feature  -- Initialization
	make is
		do
		
		end

feature -- Setting

	set_location (s: STRING) is
		do
			location:= s
		end

	set_l_to_precompile (l: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]) is
		do
			l_to_precompile:= l
		end

	set_l_precompilable (l: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]) is
		do
			l_precompilable:= l
		end

	set_es4_location (s: STRING) is
		do
			es4_location:= s
		end

feature -- Access

	location: STRING
		-- location of the project

	l_to_precompile: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- list of library to precompile

	l_precompilable: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- list of library that can be precompile

	es4_location: STRING
		-- es4 location

end -- class WIZARD_INFORMATION

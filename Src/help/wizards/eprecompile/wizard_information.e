indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize.
		do
		end

feature -- Access

	location: STRING
		-- location of the project

	l_to_precompile: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- list of library to precompile

	l_precompilable: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- list of library that can be precompile

feature -- Element change

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

end -- class WIZARD_INFORMATION

note
	description: "Summary description for {PE_STRUCTURE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_STRUCTURE_ITEM

inherit
	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (lab: like label)
		do
			label := lab
		end

feature -- Access

	label: READABLE_STRING_8

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		deferred
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
		do
			Result := label
		end


end

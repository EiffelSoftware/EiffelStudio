indexing
	description: "Action performed when we press OK on the filesd"
	date: "$Date$"
	revision: "$Revision$"

class
	OK_BROWSE_IMPORT

inherit
	
	EV_COMMAND

creation
	make

feature -- Initialization

	make ( i : IMPORT_GLOSSARY ) is
			-- Creation routine
		do
		 	callb := i
		ensure
			callback_put : callb = i
		end

feature {NONE} -- Implementation

callb : IMPORT_GLOSSARY

execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	require else
		callb_void :callb/=Void
	do
		callb.exec
	end				 

end -- class OK_BROWSE_IMPORT

indexing
	description: "Object that can popup a message dialog."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class POPUPER 
	
feature 

	Messages: MESSAGE_CONSTANTS is
		do
			!! Result
		end

	popuper_parent: EV_CONTAINER is
		deferred
		end 

end -- class POPUPER


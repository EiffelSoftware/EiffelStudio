indexing
	description: "Message from dotnet debugger Eiffel implementation"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFNET_DEBUGGER_MESSAGE_INFO


feature -- Access

	init is
		do
			create {LINKED_LIST[STRING]} messages.make
		end
		
	reset is
			-- 
		do
			messages.wipe_out
		end

feature {EIFNET_DEBUGGER_INFO_ACCESSOR}

	messages: LIST [STRING]

end -- class EIFNET_DEBUGGER_MESSAGE_INFO

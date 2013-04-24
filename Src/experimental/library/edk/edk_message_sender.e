note
	description: "Summary description for {EDK_MESSAGE_SENDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_MESSAGE_SENDER

inherit
	EDK_OBJECT_I

feature -- Access

	message_manager: EDK_MESSAGE_MANAGER
		require
			message_manager_available: message_manager_available
		local
			l_result: detachable EDK_MESSAGE_MANAGER
		do
			l_result := message_manager_cell.item
			check l_result /= Void end
			Result := l_result
		end

	message_manager_available: BOOLEAN
			-- Is the message manager available?
		do
			Result := message_manager_cell.item /= Void
		end

feature {NONE} -- Implementation

	message_manager_cell: CELL [detachable EDK_MESSAGE_MANAGER]
		note
			once_status: global
		once
			Result := create {CELL [detachable EDK_MESSAGE_MANAGER]}.put (Void)
		end

end

indexing
	description: "Information about message Wm_notify which informs the %
		%parent window of a control that an event has occurred in the %
		%control or that the control requires some kind of information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NOTIFY_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	id: INTEGER is
			-- Identifier of the control sending the message
		do
			Result := w_param.to_integer_32
		end

	nmhdr: WEL_NMHDR is
			-- Information about the notification
		do
			create Result.make_by_pointer (l_param)
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_NOTIFY_MESSAGE


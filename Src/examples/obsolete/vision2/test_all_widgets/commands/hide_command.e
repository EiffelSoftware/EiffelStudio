indexing
	description: 
		"HIDE_COMMAND, hides a widget. Belongs to EiffelVision%
		% example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	HIDE_COMMAND

inherit
	EV_COMMAND

feature -- Command execution

	execute (argument: EV_ARGUMENT1[EV_WIDGET]; data: EV_EVENT_DATA) is
		do
			argument.first.hide
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


end -- class HIDE_COMMAND


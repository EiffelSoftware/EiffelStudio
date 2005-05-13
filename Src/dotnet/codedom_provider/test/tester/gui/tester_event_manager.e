indexing
	description: "Tester event manager"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_EVENT_MANAGER

feature -- Initialization

	set_output_displayer (a_displayer: like output_displayer) is
			-- Set `output_displayer' with `a_displayer'
		do
			output_displayer := a_displayer
		ensure
			set: output_displayer = a_displayer
		end

feature -- Access

	output_displayer: ROUTINE [ANY, TUPLE [STRING]]
			-- Text displayer routine

feature -- Basic Operation

	raise_event (a_event: TESTER_EVENT) is
			-- Raise `a_event', display appropriate output by calling `output_displayer'.
		require
			non_void_event: a_event /= Void
			non_void_output_displayer: output_displayer /= Void
		do
			if a_event.is_error then
				output_displayer.call ([error_header + a_event.message])
			else
				output_displayer.call ([message_header + a_event.message])
			end
		end

feature {NONE} -- Private Access

	message_header: STRING is
			-- Message header
		local
			l_now: STRING
		do
			l_now := {SYSTEM_DATE_TIME}.Now.to_string
			create Result.make (l_now.count + 3)
			Result.append ("%N%N")
			Result.append (l_now)
			Result.append_character ('%N')
		end
	
	error_header: STRING is
			-- Error header
		local
			l_header: STRING
		do
			l_header := message_header
			create Result.make (l_header.count + 12) -- "** ERROR **%N".count = 12
			Result.append (l_header)
			Result.append ("** ERROR **%N")
		end

end -- class TESTER_EVENT_MANAGER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
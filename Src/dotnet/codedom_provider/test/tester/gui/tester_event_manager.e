indexing
	description: "Tester event manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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
indexing
	description: "Code generation manager."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_REPORT

create
	make

feature {NONE} -- Initialization

	make (a_event_raiser: like event_raiser) is
			-- Set `event_raiser' with `a_event_raiser'.
		require
			non_void_event_raiser: a_event_raiser /= Void
		do
			event_raiser := a_event_raiser
		ensure
			event_raiser_set: event_raiser = a_event_raiser
		end

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		require
			non_void_title: a_title /= Void
			valid_title: not a_title.is_empty
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Title, a_title)])
		end

	set_range (a_range: INTEGER) is
			-- Set `range' with `a_range'.
		require
			valid_range: a_range >= 0
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Set_range, a_range)])
		end

	step is
			-- Increment progress.
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Step, Void)])
		end

feature -- Basic Operations

	start is
			-- Start report (i.e. activate dialog).
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Start, Void)])
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		do
			event_raiser.call ([create {WIZARD_PROGRESS_EVENT}.make (feature {WIZARD_PROGRESS_EVENT_ID}.Finish, Void)])
		end

feature {NONE} -- Implementation

	event_raiser: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]];
			-- Event raiser

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
end -- class WIZARD_PROGRESS_REPORT

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

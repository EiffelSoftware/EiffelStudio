indexing
	description: "Event that occured during file splitting"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_EVENT

inherit
	EV_THREAD_EVENT
		rename
			make as ev_make
		end

create
	make

feature {NONE} -- Implementation

	make (a_message, a_title: STRING; a_severity: INTEGER) is
			-- Initialize instance.
		require
			non_void_message: a_message /= Void
			non_void_title: a_title /= Void
			valid_severity: is_valid_severity (a_severity)
		do
			message := a_message
			title := a_title
			severity := a_severity
		ensure
			message_set: message = a_message
			title_set: title = a_title
			severity_set: severity = a_severity
		end

feature -- Access

	message: STRING
			-- Event message
	
	title: STRING;
			-- Event title

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_ES_EVENT

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
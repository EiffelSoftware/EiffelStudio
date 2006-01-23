indexing
	description: "Events happening during CodeDom manipulation, can be error, warning or informational"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENT

inherit
	CODE_EVENTS

create
	make

feature {NONE} -- Initialization

	make (an_id: INTEGER; a_context: like context) is
			-- Create error event with name `an_id' and context `a_context'.
		require
			valid_id: events.has (an_id)
			valid_context: is_valid_context (an_id, a_context)
		do
			id := an_id
			context := a_context
		ensure
			id_set: id = an_id
			context_set: context = a_context
		end
	
feature -- Access

	id: INTEGER
			-- Event identifier
	
	context: TUPLE
			-- Event contextual information

feature -- Status Report

	is_error: BOOLEAN is
			-- Is event an error?
		do
			Result := event_severity (id) = Error
		end
	
	is_warning: BOOLEAN is
			-- Is event a warning?
		do
			Result := event_severity (id) = Warning
		end
		
	message: STRING is
			-- Message associated with event
		local
			i, l_index: INTEGER
			l_marker: STRING
			l_header, l_body: STRING
			l_severity: INTEGER
		do
			create l_header.make (64)
			l_severity := event_severity (id)
			inspect
				l_severity
			when Error then
				l_header.append ("Error: `")
			when Warning then
				l_header.append ("Warning: `")
			else
				l_header.append ("Information: `")
			end
			l_header.append (event_name (id))
			l_header.append ("' from `")
			l_header.append (event_source (id))
			l_header.append_character ('%'')
			l_body := event_message (id).twin
			from
				i := 1
			until
				i > context.count
			loop
				l_marker := event_message_marker (i)
				l_index := l_body.substring_index (l_marker, l_index + 1)
				check
					valid_context: l_index > 0
				end
				l_body.replace_substring (context.item (i).out, l_index, l_index + l_marker.count - 1)
				i := i + 1
			end
			create Result.make (l_header.count + l_body.count + 1)
			Result.append (l_header)
			Result.append_character ('%N')
			Result.append (l_body)
		ensure
			has_message: Result /= Void
		end

invariant
	valid_id: is_event_id (id)
	non_void_context: context /= Void
	valid_context: is_valid_context (id, context)
	error_or_warning: (is_error implies not is_warning) and (is_warning implies not is_error)
	
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


end -- class CODE_EVENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
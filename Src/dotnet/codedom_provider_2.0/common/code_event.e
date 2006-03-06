indexing
	description: "Events happening during CodeDom manipulation, can be error, warning or informational"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENT

inherit
	CODE_EVENTS

	CODE_SHARED_GENERATION_CONSTANTS
		export
			{NONE} all
		end

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
			Result.append (Line_return)
			Result.append (l_body)
		ensure
			has_message: Result /= Void
		end

invariant
	valid_id: is_event_id (id)
	non_void_context: context /= Void
	valid_context: is_valid_context (id, context)
	error_or_warning: (is_error implies not is_warning) and (is_warning implies not is_error)
	
end -- class CODE_EVENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
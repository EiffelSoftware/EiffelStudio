indexing
	description: "Output event raised by manager, handled by GUI"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_EVENT

inherit
	EV_THREAD_EVENT
		rename
			make as thread_make
		end

	WIZARD_OUTPUT_EVENT_ID

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_text: STRING) is
			-- Initialize instance.
		require
			valid_id: is_valid_output_event_id (a_id)
		do
			thread_make (a_id, severity_from_id (a_id), a_text)
		ensure
			id_set: id = a_id
			text_set: text = a_text
		end

feature -- Access

	text: STRING is
			-- Associated text if any
		do
			Result ?= data
			check
				valid_instance: data /= Void implies Result /= Void
			end
		end

feature {NONE} -- Implementation

	severity_from_id (a_id: INTEGER): INTEGER is
			-- Event severity
		do
			inspect
				a_id
			when Display_warning then
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Warning
			when Display_error then
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Error
			else
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Information
			end
		end
		
invariant
	valid_id: is_valid_output_event_id (id)

end -- class WIZARD_OUTPUT_EVENT

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

indexing
	description: "Progress event raised by manager, handled by GUI"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_EVENT

inherit
	EV_THREAD_EVENT
		rename
			make as thread_make
		end

	WIZARD_PROGRESS_EVENT_ID

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_value: ANY) is
			-- Initialize instance.
		require
			valid_id: is_valid_progress_event_id (a_id)
		do
			thread_make (a_id, severity_from_id (a_id), a_value)
		ensure
			id_set: id = a_id
			value_set: data = a_value
		end

feature -- Access

	value: INTEGER is
			-- Associated value if any
		local
			l_ref: INTEGER_REF
		do
			l_ref ?= data
			if l_ref /= Void then
				Result := l_ref.item
			end
		end

	text_value: STRING is
			-- Associated text value if any
		do
			Result ?= data
		end

feature {NONE} -- Implementation

	severity_from_id (a_id: INTEGER): INTEGER is
			-- Event severity
		do
			if a_id = Finish then
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Stop
			else
				Result := feature {EV_THREAD_SEVERITY_CONSTANTS}.Information
			end
		end
		
invariant
	valid_id: is_valid_progress_event_id (id)

end -- class WIZARD_PROGRESS_EVENT

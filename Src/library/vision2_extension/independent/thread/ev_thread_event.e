indexing
	description: "Events posted by worker thread to GUI thread."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_THREAD_EVENT

inherit
	EV_THREAD_SEVERITY_CONSTANTS

create
	make

feature {NONE} -- Implementation

	make (a_id, a_severity: INTEGER; a_data: like data) is
			-- Initialize instance.
		require
			valid_severity: is_valid_severity (a_severity)
		do
			id := a_id
			severity := a_severity
			data := a_data
		ensure
			id_set: id = a_id
			severity_set: severity = a_severity
			data_set: data = a_data
		end

feature -- Access

	id: INTEGER
			-- Event identifier

	severity: INTEGER
			-- Event severity
			-- See class {EV_THREAD_SEVERITY_CONSTANTS} for possible values.
	
	data: ANY
			-- Data associated with event

invariant
	valid_severity: is_valid_severity (severity)

end -- class EV_THREAD_EVENT
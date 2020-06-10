note
	description: "[
				Object that reprent a status
				The status of a problem can be one of the following:

			Open The initial state of a Problem Report. This means the PR has been filed and the responsible person(s) notified.
			Analyzed The responsible person has analyzed the problem. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and resources necessary to solve the problem. It should also suggest possible workarounds.
			Closed A Problem Report is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution
			Suspended Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.
			Won't fix Won't fix problem report.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_STATUS

inherit
	REPORT_FIELD

	REPORT_SELECTABLE

create
	make

feature {NONE} -- Initialization

	make (a_id:INTEGER; a_synop: READABLE_STRING_32)
			-- Create an object instance
			-- Set `id' to `a_id'
			-- Set `synopsis' to `a_synopsis'.
		do
			id := a_id
			synopsis := a_synop
		ensure
			id_set: id = a_id
			synopsis_set: synopsis = a_synop
		end

feature -- Access

	id: INTEGER
		-- Unique id.

	synopsis: READABLE_STRING_32
		-- Short description.

feature --Change Element

	set_id (a_id: INTEGER)
			-- <Precursor>
		do
			id := a_id
		end

	set_synopsis (a_synopsis: like synopsis)
			-- <Precursor>
		do
			synopsis := a_synopsis
		end

feature -- Output

	string: READABLE_STRING_8
			-- String representation.
		do
			Result := id.out + " | " + synopsis.string.to_string_8
		end

end

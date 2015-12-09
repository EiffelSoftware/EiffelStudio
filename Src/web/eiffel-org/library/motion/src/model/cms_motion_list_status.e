note
	description: "[
				Object that reprent a status
				The status of a motion can be one of the following:

			Open The initial state of a Motion. This means the PR has been filed and the responsible person(s) notified.
			Analyzed The responsible person has analyzed the motion. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and resources necessary to solve the problem. It should also suggest possible workarounds.
			Closed A motion is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution
			Suspended Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.
			Won't fix Won't fix problem report.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_STATUS

inherit

	CMS_SELECTABLE

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			id := 0
			set_synopsis ("")
		end

	make (a_id:INTEGER_64; a_synop: READABLE_STRING_32)
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

	id: INTEGER_64
		-- Unique id.

	synopsis: READABLE_STRING_32
		-- Short description.

feature --Change Element

	set_id (a_id: INTEGER_64)
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
			Result := id.out + " | " + synopsis.string
		end

end

indexing
	description: "Progress events IDs"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_EVENT_ID

feature -- Access

	Step: INTEGER is 1
			-- Increment progress by one
	
	Set_range: INTEGER is 2
			-- Set progress range
	
	Start: INTEGER is 4
			-- Start progress update

	Finish: INTEGER is 5
			-- Finish progress update

	Title: INTEGER is 6
			-- Set total progress title

feature -- Status Report

	is_valid_progress_event_id (a_id: INTEGER): BOOLEAN is
			-- Is `a_id' a valid progress event id?
		do
			Result := a_id = Step or a_id = Set_range or
				a_id = Start or a_id = Finish or
				a_id = Title
		ensure
			definition: Result = (a_id = Step or a_id = Set_range or
				a_id = Start or a_id = Finish or
				a_id = Title)
		end

invariant
	step_is_valid: is_valid_progress_event_id (Step)
	set_range_is_valid: is_valid_progress_event_id (Set_range)
	start_is_valid: is_valid_progress_event_id (Start)
	finish_is_valid: is_valid_progress_event_id (Finish)
	title_is_valid: is_valid_progress_event_id (Title)

end -- class WIZARD_PROGRESS_EVENT_ID

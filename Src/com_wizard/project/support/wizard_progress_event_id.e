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
	
	Set_task_range: INTEGER is 3
			-- Set progress range
	
	Start: INTEGER is 4
			-- Start progress update

	Finish: INTEGER is 5
			-- Finish progress update

	Title: INTEGER is 6
			-- Set total progress title

	Task_title: INTEGER is 7
			-- Set task title

feature -- Status Report

	is_valid_progress_event_id (a_id: INTEGER): BOOLEAN is
			-- Is `a_id' a valid progress event id?
		do
			Result := a_id = Step or a_id = Set_range or
				a_id = Start or a_id = Finish or
				a_id = Title or a_id = Set_task_range or
				a_id = Task_title
		ensure
			definition: Result = (a_id = Step or a_id = Set_range or
				a_id = Start or a_id = Finish or
				a_id = Title or a_id = Set_task_range or
				a_id = Task_title)
		end

invariant
	step_is_valid: is_valid_progress_event_id (Step)
	set_range_is_valid: is_valid_progress_event_id (Set_range)
	start_is_valid: is_valid_progress_event_id (Start)
	finish_is_valid: is_valid_progress_event_id (Finish)
	set_task_range_is_valid: is_valid_progress_event_id (Set_task_range)
	title_is_valid: is_valid_progress_event_id (Title)
	task_title_is_valid: is_valid_progress_event_id (Task_title)

end -- class WIZARD_PROGRESS_EVENT_ID

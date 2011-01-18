note
	description	: "Representation of a hall"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	HALL

feature {ACTOR} -- Access

	judge_present: BOOLEAN
			-- Is judge present?

feature {JUDGE} -- Judge operations

	immigrants_ready: BOOLEAN
			-- Are immigrants ready?
		do
			Result := immigrants = ready_immigrants
		end

	immigrants_swear_done: BOOLEAN
			-- Did all of immigrants swear
		do
			Result := sweared_immigrants = ready_immigrants
		end

	judge_enterance_ready: BOOLEAN
			-- Did all the sweared immigrants leave the hall
		do
			Result := sweared_immigrants = 0
		end

	immigrants: INTEGER
			-- How many immigrants are present?

	set_judge (a_bool: BOOLEAN)
			-- Set judge status.
		do
			judge_present := a_bool
		ensure
			judge_present_set: judge_present = a_bool
		end

	sit_judge
			-- Sit judge.
		do
			judge_ready := True
		ensure
			judge_ready: judge_ready
		end

	confirm
			-- Confirm immigrants.
		do
			judge_ready := False
			ready_immigrants := 0
		ensure
			not_judge_ready: not judge_ready
		end

feature {IMMIGRANT} -- Immigrants operations

	judge_ready: BOOLEAN
			-- Is judge ready?

	enter_immigrant
			-- Enter immigrant.
		do
			immigrants := immigrants + 1
		ensure
			immigrants_incremented: immigrants = old immigrants + 1
		end

	check_in
			-- Check in.
			-- Update ready immigrants.
		do
			ready_immigrants := ready_immigrants + 1
		ensure
			ready_immigrants_incremented: ready_immigrants = old ready_immigrants + 1
		end

	swear
			-- Swear infront of Judge.
		do
			sweared_immigrants := sweared_immigrants + 1
		ensure
			sweared_immigrants_incremented: sweared_immigrants = old sweared_immigrants + 1
		end

	leave_immigrant
			-- Leave immigrant.
		do
			immigrants := immigrants - 1
			sweared_immigrants := sweared_immigrants - 1
		ensure
			immigrants_decremented: immigrants = old immigrants - 1
			sweared_immigrants = old sweared_immigrants - 1
		end

feature {NONE} -- Implementation

	ready_immigrants: INTEGER
			-- Ready immigrants

	sweared_immigrants: INTEGER
			-- Immigrants who did their swear

invariant

	ready_immigrants_bounds: ready_immigrants >= 0 and ready_immigrants <= immigrants

	immigrants_ready: immigrants_ready = (immigrants = ready_immigrants)

	judge_present: judge_present implies immigrants > 0

end

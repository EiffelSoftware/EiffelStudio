note
	description	: "Representation of a hall"
	author		: "Martino Trosi & Matteo Cortonesi"
	date		: "Spring 2009"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	HALL

feature  -- Status report

	judge_present: BOOLEAN
			-- Is judge present?

feature {JUDGE} -- Status report

	immigrants_ready: BOOLEAN
			-- Are immigrants ready?
		do
			Result := present_immigrant_count = ready_immigrant_count
		end

	all_immigrants_sworn: BOOLEAN
			-- Have all immigrants taken oath?
		do
			Result := sworn_immigrant_count = ready_immigrant_count
		end

	has_sworn_immigrants: BOOLEAN
			-- Have any immigrants present already taken oath?
		do
			Result := sworn_immigrant_count > 0
		end

feature -- Access

	expected_immigrant_count: INTEGER
			-- Total immigrants expected for today.

	present_immigrant_count: INTEGER
			-- Immigrants currently in hall for swearing in.

feature {JUDGE} -- Status setting

	set_judge_presence (a_bool: BOOLEAN)
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
			ready_immigrant_count := 0
		ensure
			not_judge_ready: not judge_ready
		end

feature {IMMIGRANT} -- Status report

	judge_ready: BOOLEAN
			-- Is judge ready?

feature -- Basic operations

	set_expected_immigrant_count (a_count: INTEGER)
			-- Set expected immigrant count to `a_count'.
		do
			expected_immigrant_count := a_count
		end

	enter_immigrant
			-- Enter immigrant.
		do
			present_immigrant_count := present_immigrant_count + 1
		ensure
			immigrants_incremented: present_immigrant_count = old present_immigrant_count + 1
		end

	check_in
			-- Check in.
		do
			ready_immigrant_count := ready_immigrant_count + 1
		ensure
			ready_immigrants_incremented: ready_immigrant_count = old ready_immigrant_count + 1
		end

	take_oath
			-- Take oath in front of Judge.
		do
			sworn_immigrant_count := sworn_immigrant_count + 1
		ensure
			sweared_immigrants_incremented: sworn_immigrant_count = old sworn_immigrant_count + 1
		end

	leave_immigrant
			-- Leave immigrant.
		do
			present_immigrant_count := present_immigrant_count - 1
			sworn_immigrant_count := sworn_immigrant_count - 1
		ensure
			immigrants_decremented: present_immigrant_count = old present_immigrant_count - 1
			sworn_immigrant_count = old sworn_immigrant_count - 1
		end

feature {NONE} -- Implementation

	ready_immigrant_count: INTEGER
			-- How many immigrants are checked in and ready for oath?

	sworn_immigrant_count: INTEGER
			-- How many immigrants have taken oath?

invariant

	ready_immigrants_bounds: ready_immigrant_count >= 0 and ready_immigrant_count <= present_immigrant_count
	immigrants_ready: immigrants_ready = (present_immigrant_count = ready_immigrant_count)
	judge_present: judge_present implies present_immigrant_count > 0

end

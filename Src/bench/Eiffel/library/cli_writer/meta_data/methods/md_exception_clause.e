indexing
	description: "Description of an exception clause"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EXCEPTION_CLAUSE

create
	make
	
feature -- Reset

	make, reset is
			-- Restore default values.
		do
			start_position := -1
			catch_position := -1
			type_token := -1
			end_position := -1
			state := Start_state
		ensure
			start_position_set: start_position = -1
			catch_position_set: catch_position = -1
			type_token_set: type_token = -1
			end_position_set: end_position = -1
			state_set: not is_defined
		end

feature -- Status report

	is_defined: BOOLEAN is
			-- Is current a fully described exception clause?
		do
			Result := state = Frozen_state	
		end
		
feature -- Access

	start_position: INTEGER
			-- Starting index of `try-catch' clause in associated MD_METHOD_BODY.
	
	catch_position: INTEGER
			-- Index of where `catch' starts.

	type_token: INTEGER
			-- Token type on which catch clause will stop.
			-- Usually token for System.Exception.
		
	end_position: INTEGER
			-- Ending index of `try-catch' clause in associated MD_METHOD_BODY.
		
feature -- Settings

	set_start_position (p: INTEGER) is
			-- Set `start_position' to `p'.
		require
			valid_p: p >= 0
			valid_state: state = Start_state
		do
			start_position := p
			state := Catch_state
		ensure
			start_position_set: start_position = p
			state_set: state = Catch_state
		end

	set_catch_position (p: INTEGER) is
			-- Set `catch_position' to `p'.
		require
			valid_p: p >= 0
			valid_state: state = Catch_state
		do
			catch_position := p
			state := Type_state
		ensure
			catch_position_set: catch_position = p
			state_set: state = Type_state
		end
		
	set_type_token (p: INTEGER) is
			-- Set `type_token' to `p'.
		require
			valid_p: p >= 0
			valid_state: state = Type_state
		do
			type_token := p
			state := End_state
		ensure
			type_token_set: type_token = p
			state_set: state = End_state
		end

	set_end_position (p: INTEGER) is
			-- Set `end_position' to `p'.
		require
			valid_p: p >= 0
			valid_state: state = End_state
		do
			end_position := p
			state := Frozen_state
		ensure
			end_position_set: end_position = p
			state_set: state = Frozen_state
		end

feature -- Implementation

	state: INTEGER
			-- Is current exception block ready for new settings?

	start_state: INTEGER is 1
	catch_state: INTEGER is 2
	type_state: INTEGER is 3
	end_state: INTEGER is 4
	frozen_state: INTEGER is 5
			-- Possible state of current object.

end -- class MD_EXCEPTION_CLAUSE

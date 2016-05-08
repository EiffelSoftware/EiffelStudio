note

	description:

		"Shift/reduce conflicts"

	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class PR_CONFLICT

create

	make

feature {NONE} -- Initialization

	make (a_state: like state; a_rule: like rule; a_token: like token; a_resolution: like resolution)
			-- Create a new shift/reduce conflict in `a_state'
			-- between `a_rule' and `a_token' resolved as
			-- `a_resolution'.
		require
			a_state_not_void: a_state /= Void
			a_rule_not_void: a_rule /= Void
			a_token_not_void: a_token /= Void
			a_resultion_not_void: a_resolution /= Void
		do
			state := a_state
			rule := a_rule
			token := a_token
			resolution := a_resolution
		ensure
			state_set: state = a_state
			rule_set: rule = a_rule
			token_set: token = a_token
			resolution_set: resolution = a_resolution
		end

feature -- Access

	state: PR_STATE
			-- State where current conflict occurs

	rule: PR_RULE
			-- Rule involved in current conflict

	token: PR_TOKEN
			-- Token involved in current conflict

	resolution: STRING
			-- How current conflict has been resolved

feature -- Output

	print_conflict (a_file: KI_TEXT_OUTPUT_STREAM)
			-- Print textual representation of
			-- current conflict to `a_file.
		require
			a_file_not_void: a_file /= Void
			a_file_open_write: a_file.is_open_write
		do
			a_file.put_string ("Conflict in state ")
			a_file.put_integer (state.id)
			a_file.put_string (" between rule ")
			a_file.put_integer (rule.id)
			a_file.put_string (" and token ")
			a_file.put_integer (token.token_id)
			a_file.put_string (" (")
			a_file.put_string (token.name)
			a_file.put_string (") resolved as ")
			a_file.put_string (resolution)
			a_file.put_string (".%N")
		end

invariant

	state_not_void: state /= Void
	rule_not_void: rule /= Void
	token_not_void: token /= Void
	resultion_not_void: resolution /= Void

end

class S_FEATURE_DATA

creation

	make

feature

	name: STRING;
			-- Feature's name

	class_key: S_CLASS_KEY;
			-- Class that contains the feature

	arguments: FIXED_LIST [S_ARGUMENT_DATA];
			-- Arguments if routine

	result_type: S_RESULT_DATA;
			-- Result type if function of attribute

	comments: S_FREE_TEXT_DATA;
			-- Comment associated to the feature

	preconditions: FIXED_LIST [S_ASSERTION_DATA];
			-- Pre-conditions

	postconditions: FIXED_LIST [S_ASSERTION_DATA];
			-- Post-conditions

	is_deferred: BOOLEAN;
			-- Is Current feature deferred?

	is_effective: BOOLEAN;
			-- Is Current feature effecting an inherited feature?

	is_redefined: BOOLEAN;
			-- Is Current feature redefine?

	rename_clause: S_RENAME_DATA;
			-- String representing where feature comes from

feature -- Setting values

	make (s: STRING; key: like class_key) is
			-- Set id to `s' and set
			-- class_key to `key'.
		require
			valid_s: s /= Void;
			valid_key: key /= Void
		do
			name := s;
			class_key := key
		ensure
			name_set: name = s;
			class_key_set: class_key = key;
		end;

	set_booleans (is_d, is_e, is_r: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_deferred := is_d;
			is_effective := is_e;
			is_redefined := is_r;
		ensure
			booleans_are_set: is_deferred = is_d and then
								is_effective = is_e and then
								is_redefined = is_r
		end;

	set_arguments (l: like arguments) is
			-- Set arguments to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			arguments := l
		ensure
			arguments_set: arguments = l
		end;

	set_comments (l: like comments) is
			-- Set commentss to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			comments := l
		ensure
			comments_set: comments = l
		end;

	set_preconditions (l: like preconditions) is
			-- Set preconditions to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			preconditions := l
		ensure
			preconditions_set: preconditions = l
		end;

	set_postconditions (l: like postconditions) is
			-- Set postconditions to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			postconditions := l
		ensure
			postconditions_set: postconditions = l
		end;

	set_rename_clause (clause: like rename_clause) is
			-- Set rename_clause to `clause'.
		require
			valid_clause: clause /= Void
		do
			rename_clause := clause
		ensure
			rename_clause_set: rename_clause = clause
		end;

	set_result_type (type: like result_type) is
			-- Set result_type to `type'.
		require
			valid_type: type /= Void
		do
			result_type := type
		ensure
			result_type_set: result_type = type
		end;

end

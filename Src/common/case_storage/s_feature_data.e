class S_FEATURE_DATA

creation

	make

feature

	name: STRING;
			-- Feature's name

	arguments: FIXED_LIST [S_ARGUMENT_DATA];
			-- Arguments if routine

	result_type: S_RESULT_DATA;
			-- Result type if function of attribute

	comments: S_FREE_TEXT_DATA;
			-- Comment associated to the feature

	preconditions: FIXED_LIST [S_TAG_DATA];
			-- Pre-conditions

	postconditions: FIXED_LIST [S_TAG_DATA];
			-- Post-conditions

	is_attribute: BOOLEAN;
			-- Is Current feature an attribute?

	is_deferred: BOOLEAN;
			-- Is Current feature deferred?

	is_effective: BOOLEAN;
			-- Is Current feature effecting an inherited feature?

	is_redefined: BOOLEAN;
			-- Is Current feature redefine?

	rename_clause: S_RENAME_DATA;
			-- String representing where feature comes from

feature -- Setting values

	make (s: STRING) is
			-- Set id to `s' 
		require
			valid_s: s /= Void;
		do
			name := s;
		ensure
			name_set: name = s;
		end;

	set_booleans (is_d, is_e, is_r, is_att: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_deferred := is_d;
			is_effective := is_e;
			is_redefined := is_r;
			is_attribute := is_att
		ensure
			booleans_are_set: is_deferred = is_d and then
								is_effective = is_e and then
								is_attribute = is_att and then
								is_redefined = is_r
		end;

	set_is_deferred is
			-- Set is_deferred to `True'.
		require
			not_effective: not is_effective;
			not_redefined: not is_redefined;
		do
			is_deferred := True
		ensure
			is_deferred: is_deferred
		end;

	set_is_attribute is
			-- Set is_attribute to `True'.
		do
			is_attribute := True
		ensure
			is_attribute: is_attribute
		end;

	set_is_redefined is
			-- Set is_deferred to `True'.
		do
			is_redefined := True;
			is_effective := False;
		ensure
			is_redefined: is_redefined;
			not_effective: not is_effective;
		end;

	set_is_effective is
			-- Set is_effective to `True'.
		require
			not_deferred: not is_deferred
		do
			is_effective := True;
			is_redefined := False;
		ensure
			is_effective: is_effective;
			not_redefined: not is_redefined
		end;

	set_arguments (l: like arguments) is
			-- Set arguments to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			arguments := l
		ensure
			arguments_set: arguments = l
		end;

	set_comments (l: like comments) is
			-- Set commentss to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
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

indexing

	description: 
		"Data representation of feature information.";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_DATA

feature -- Properties

	name: STRING;
			-- Feature's name

	arguments: FIXED_LIST [S_ARGUMENT_DATA];
			-- Arguments if routine

	result_type: S_RESULT_DATA;
			-- Result type if function of attribute

	body: S_FEATURE_BODY

	comments: S_FREE_TEXT_DATA;
			-- Comment associated to the feature

	preconditions: FIXED_LIST [S_TAG_DATA];
			-- Pre-conditions

	postconditions: FIXED_LIST [S_TAG_DATA];
			-- Post-conditions

	is_attribute: BOOLEAN;
			-- Is Current feature an attribute?

	is_constant: BOOLEAN is
			-- Is Current feature a constant attribute ?
		do
		end

	is_deferred: BOOLEAN;
			-- Is Current feature deferred?

	is_effective: BOOLEAN;
			-- Is Current feature effecting an inherited feature?

	is_once: BOOLEAN is
			-- Is Current feature a once?
		do
		end
	
	is_expanded: BOOLEAN
	-- FOR NEXT VERSION ...
			-- Is current feature expanded ?

	is_redefined: BOOLEAN;
			-- Is Current feature redefine?

	rename_clause: S_RENAME_DATA;
			-- String representing where feature comes from

feature -- Modification Properties

	is_new_since_last_re: BOOLEAN is
			-- Is current feature new since last reverse engineering ?
		do
		end;

	is_deleted_since_last_re: BOOLEAN is
			-- Is current feature deleted since last reverse engineering ?
		do
		end;

	is_reversed_engineered: BOOLEAN is
			-- Is Current class reversed engineered?
		do
		end;

feature -- Setting 

	make (s: STRING) is
			-- Set id to `s' 
		require
			valid_s: s /= Void;
		do
			name := s;
		ensure
			name_set: name = s;
		end;

	set_is_attribute is
			-- Set is_attribute to `True'.
		do
			is_attribute := True
		ensure
			is_attribute: is_attribute
		end;

	set_body (b: FEATURE_BODY_DATA) is
			-- Set `body' to `l'.
		require
			body_exists: b /= Void;
			body_not_empty: not b.empty;
		do
		end;

	set_booleans (is_d, is_e, is_r, is_att, is_ex: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_deferred := is_d;
			is_effective := is_e;
			is_redefined := is_r;
			is_attribute := is_att
			is_expanded := is_ex
		ensure
			booleans_are_set: is_deferred = is_d and then
								is_effective = is_e and then
								is_attribute = is_att and then
								is_redefined = is_r
								is_expanded = is_ex
		end;

	set_is_expanded is
			--Set is_expanded to 'True'
		do
			is_expanded := True
		ensure
			is_expanded = True
	end

	set_is_deferred(b:BOOLEAN) is
			-- Set is_deferred to `True'.
		do
			is_deferred := True
		ensure
			is_deferred: is_deferred
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

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do

		ensure
			is_reversed_engineered: is_reversed_engineered
		end

invariant
	attribute_no_precondition: is_attribute implies 
			(preconditions = Void or else preconditions.empty) 
	attribute_no_postcondition: is_attribute implies 
			(postconditions = Void or else postconditions.empty) 
	attribute_no_argument: is_attribute implies 
			(arguments = Void or else arguments.empty) 
	constant_is_attribute: is_constant implies is_attribute
	deferred_is_routine: is_deferred implies (not is_attribute)
	once_is_routine: is_once implies (not is_attribute)
	effective_not_deferred: is_effective implies (not is_deferred)
	deferred_not_effective: is_deferred implies (not is_effective)

end -- class S_FEATURE_DATA

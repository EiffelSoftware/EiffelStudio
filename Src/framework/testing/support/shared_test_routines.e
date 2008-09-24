indexing
	description: "[
		Objects containing test related helper routines.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TEST_ROUTINES

inherit
	SHARED_TEST_CONSTANTS

feature -- Query

	is_valid_feature (a_feature_as: !FEATURE_AS): BOOLEAN is
			-- Is `a_feature_as' the syntax of a valid test routine?
		do
			Result := (a_feature_as.body.arguments = Void or else a_feature_as.body.arguments.is_empty) and
				not a_feature_as.is_function and (test_routine_name (a_feature_as) /= Void)
		end

	is_valid_class_as (a_class: !CLASS_AS): BOOLEAN
			-- Can `a_class' be a syntactical representation of a class containing tests?
		do
			Result := not a_class.is_deferred and then
				(a_class.creators = Void or else a_class.creators.is_empty)
		end

	is_valid_feature_clause (a_clause_as: !FEATURE_CLAUSE_AS): BOOLEAN is
			-- Is `a_clause_as' exported to ANY?
		require
			a_clause_as_not_void: a_clause_as /= Void
		local
			l_list: CLASS_LIST_AS
			l_old_cs: CURSOR
		do
			if a_clause_as.clients /= Void then
				l_list := a_clause_as.clients.clients
				from
					l_old_cs := l_list.cursor
					l_list.start
				until
					Result or l_list.after
				loop
					Result := l_list.item.name.is_case_insensitive_equal ("ANY") or
						l_list.item.name.is_case_insensitive_equal ("TESTER")
					l_list.forth
				end
				l_list.go_to (l_old_cs)
			else
				Result := True
			end
		end

	is_valid_routine_name (a_name: !STRING): BOOLEAN is
			-- Is `a_name' a valid test routine name?
		do
			Result := routine_name_regex.matches (a_name)
		end

	class_name (a_class: !CLASS_I): !STRING is
			-- Name of `a_class' in upper case.
		do
			Result ?= a_class.name.as_upper
		ensure
			result_not_empty: not Result.is_empty

		end

	test_routine_name (a_feature: !FEATURE_AS): ?STRING is
			-- First valid test routine name in `a_feature', Void if there are none
		local
			l_name: !STRING
			l_names: EIFFEL_LIST [FEATURE_NAME]
			l_cs: CURSOR
		do
			l_names := a_feature.feature_names
			from
				l_cs := l_names.cursor
				l_names.start
			until
				l_names.after or Result /= Void
			loop
				l_name ?= l_names.item.internal_name.name.as_lower
				if is_valid_routine_name (l_name) then
					Result := l_name
				else
					l_names.forth
				end
			end
			l_names.go_to (l_cs)
		ensure
			result_attached_implies_valid: (Result /= Void) implies
				is_valid_routine_name ({!STRING} #? Result)
		end

	valid_features (a_class: !CLASS_AS): !DS_HASH_TABLE [!FEATURE_AS, !STRING] is
			-- Hash table with test routines of `a_class' where the key
			-- is the name of the feature
		local
			l_fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_fl: EIFFEL_LIST [FEATURE_AS]
			l_old_fcl, l_old_fl: CURSOR
		do
			create Result.make_default
			if a_class.features /= Void then
				from
					l_fcl := a_class.features
					l_old_fcl := l_fcl.cursor
					l_fcl.start
				until
					l_fcl.after
				loop
					if is_valid_feature_clause ({!FEATURE_CLAUSE_AS} #? l_fcl.item) then
						from
							l_fl := l_fcl.item.features
							l_old_fl := l_fl.cursor
							l_fl.start
						until
							l_fl.after
						loop
							if {l_f: !FEATURE_AS} l_fl.item and then is_valid_feature (l_f) then
								Result.force (l_f, create {!STRING}.make_from_string (test_routine_name (l_f)))
							end
							l_fl.forth
						end
						l_fl.go_to (l_old_fl)
					end
					l_fcl.forth
				end
				l_fcl.go_to (l_old_fcl)
			end
		ensure
			result_has_valid_items: Result.keys.for_all (
				agent (k: !STRING; t: like valid_features): BOOLEAN
					local
						l_item: !FEATURE_AS
					do
						l_item := t.item (k)
						Result := is_valid_routine_name (k) and then
							test_routine_name (l_item).is_equal (k) and then
							is_valid_feature (l_item)
					end (?, Result))
		end


feature {NONE} -- Implementation

	routine_name_regex: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for determing whether a routine name is valid
		once
			create Result.make
			Result.compile ("^" + test_routine_prefix)
		end

end

indexing
	description: "Objects that provide code completion possibilities for a code completable"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMPLETION_POSSIBILITIES_PROVIDER

feature -- Access

	code_completable: CODE_COMPLETABLE
			-- A code completable.

	completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	class_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	insertion: STRING is
			-- Strings to be partially completed : the first one is the dot or tilda if there is one
			-- the second one is the feature name to be completed
		require
			is_prepared : is_prepared
		deferred
		end

	insertion_remainder: INTEGER is
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		require
			is_prepared : is_prepared
		deferred
		end

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion is
			-- Prepare completion possibilities.
		require
			code_completable_attached: code_completable /= Void
		do
			is_prepared := true
			provide_features := code_completable.completing_feature
			provide_classes := not code_completable.completing_feature
		ensure
			is_prepared: is_prepared
		end

feature -- Status report

	provide_features: BOOLEAN
			-- Provide `completion_possibilities'?

	provide_classes: BOOLEAN
			-- Provide `class_completion_possibilities'?

	is_prepared: BOOLEAN
			-- Is completion possibilities prepared?

	completion_possible: BOOLEAN is
			-- Is completion possible?
		do
			if
				(provide_features implies (completion_possibilities /= Void and then not completion_possibilities.is_empty)) and
				(provide_classes implies (class_completion_possibilities /= Void and then not class_completion_possibilities.is_empty))
			then
				Result := true
			end
		end

feature -- Element Change

	set_code_completable (a_completable: CODE_COMPLETABLE) is
			-- Set `code_completable' with `a_completable'.
		require
			a_completable_attached: a_completable /= Void
		do
			code_completable := a_completable
			is_prepared := false
		ensure
			code_completable_not_void: code_completable /= Void
		end

	set_provide_features (a_provide: BOOLEAN) is
			-- Set `provide_features' with `a_provide'.
		do
			provide_features := a_provide
			is_prepared := false
		ensure
			provide_features_set: provide_features = a_provide
		end

	set_provide_classes (a_provide: BOOLEAN) is
			-- Set `provide_classes' with `a_provide'.
		do
			provide_classes := a_provide
			is_prepared := false
		ensure
			provide_classes_set: provide_classes = a_provide
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end

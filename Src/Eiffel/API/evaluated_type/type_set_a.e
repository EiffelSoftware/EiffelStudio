note
	description: "[
					 Set of types. This class encapsulates features to handle conformance and feature lookup on a set of types .
					 Refactoring:
					 TODO: This class could be made generic constrained to TYPE_A. 
					 The issue is that the agent conformance does not allow it because some features become invalid.
					 TODO: feature_i_* and e_feature_* are very similar. Maybe get rid of e_feature_*?
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_SET_A

inherit
	TYPE_A
		rename
			conform_to as conform_to_type
		undefine
			copy, is_equal
		redefine
			as_attached_type,
			as_detachable_type,
			as_implicitly_attached,
			as_implicitly_detachable,
			as_marks_free,
			formal_instantiation_in,
			has_expanded,
			has_formal_generic,
			instantiation_in,
			formal_instantiated_in,
			instantiated_in,
			internal_is_valid_for_class,
			is_attached,
			is_class_valid,
			is_loose,
			is_separate,
			is_expanded,
			is_type_set,
			to_other_attachment,
			to_other_immediate_attachment,
			to_type_set,
			same_as,
			generated_id
		end

	ARRAYED_LIST [RENAMED_TYPE_A [TYPE_A]]
		rename
			duplicate as list_duplicate
		redefine
			make
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			is_equal, copy
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			is_equal, copy
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal, copy
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER_32)
			-- <Precursor>
		do
			Precursor (n)
			compare_objects
		end

feature -- Commands

	merge (a_other_type_set: like Current)
			-- Merge `a_other_type_set' into current.
		do
			append (a_other_type_set)
		end

feature -- Access

	formal_instantiation_in (type: TYPE_A; constraint: TYPE_A; written_id: INTEGER): TYPE_SET_A
			-- <Precursor>
		local
			l_instantiated_type: TYPE_A
			l_item_type: TYPE_A
		do
			create Result.make (count)
			from
				start
			until
				after
			loop
				l_item_type := item.type
				l_instantiated_type := l_item_type.formal_instantiation_in (type, constraint, written_id)
				if l_instantiated_type /= Void then
					Result.extend (create {RENAMED_TYPE_A [TYPE_A]}.make (l_instantiated_type, item.renaming))
				end
				forth
			end
		end

	instantiation_in (a_type: TYPE_A; a_written_id: INTEGER_32): TYPE_SET_A
		local
			l_instantiated_type: TYPE_A
			l_item_type: TYPE_A
		do
			create Result.make (count)
			from
				start
			until
				after
			loop
				l_item_type := item.type
				l_instantiated_type := l_item_type.instantiation_in (a_type, a_written_id)
				if l_instantiated_type /= Void then
					Result.extend (create {RENAMED_TYPE_A [TYPE_A]}.make (l_instantiated_type, item.renaming))
				end
				forth
			end
		end

	formal_instantiated_in (class_type: TYPE_A): TYPE_SET_A
		local
			l_instantiated_type, l_item_type: TYPE_A
			i: INTEGER
		do
			from
				start
				i := lower
			until
				after
			loop
				l_item_type := item.type
				l_instantiated_type := l_item_type.formal_instantiated_in (class_type)
				if l_instantiated_type /= l_item_type then
					if Result = Void then
						Result := twin
					end
					Result.put_i_th (create {RENAMED_TYPE_A [TYPE_A]}.make (l_instantiated_type, item.renaming), i)
				end
				i := i + 1
				forth
			end
			if Result = Void then
				Result := Current
			end
		end

	instantiated_in (class_type: TYPE_A): TYPE_SET_A
		local
			l_instantiated_type, l_item_type: TYPE_A
			i: INTEGER
		do
			from
				start
				i := lower
			until
				after
			loop
				l_item_type := item.type
				l_instantiated_type := l_item_type.instantiated_in (class_type)
				if l_instantiated_type /= l_item_type then
					if Result = Void then
						Result := twin
					end
					Result.put_i_th (create {RENAMED_TYPE_A [TYPE_A]}.make (l_instantiated_type, item.renaming), i)
				end
				i := i + 1
				forth
			end
			if Result = Void then
				Result := Current
			end
		end

	feature_i_state (a_name: ID_AS): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A;  features_found_count: INTEGER]
			-- Compute feature state.
			--
			-- `a_name' is the id of the feature.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			a_name_not_void: a_name /= Void
			not_has_formal: not has_formal
		do
			Result := feature_i_state_by_name_id (a_name.name_id)
		ensure
			result_not_void: Result /= Void
			e_feature_relation: e_feature_state (a_name).features_found_count = Result.features_found_count and then
								e_feature_state (a_name).class_type_of_feature.same_as (Result.class_type_of_feature)
		end

	feature_i_state_by_name_id (a_name_id: INTEGER): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			-- Compute feature state.
			--
			-- `a_name_id': This is the `names_heap'-id of the feature name string.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_last_feature, l_feature: FEATURE_I
			l_class_type: CL_TYPE_A
			l_last_class_type: CL_TYPE_A
			l_features_found_count: INTEGER
			l_renaming: RENAMING_A
			l_constraint_position: INTEGER
			l_feature_table: FEATURE_TABLE
			l_item: RENAMED_TYPE_A [TYPE_A]
		do
			from
				start
			until
				after
			loop
				l_renaming := item.renaming
				-- Example for comments: rename f as g end
				-- `l_name_id' is the name id of `g'
				l_item := item
				if l_item.has_associated_class and then l_item.associated_class.has_feature_table then
					l_feature_table := l_item.associated_class.feature_table
					if l_renaming /= Void then
						l_feature_table.search_id_under_renaming (a_name_id, l_renaming)
					else
						l_feature_table.search_id (a_name_id)
					end

					l_feature :=  l_feature_table.found_item
						-- Duplicated code. Occurs also in `feature_i_state_by_rout_id'.
					if
						l_feature /= Void
					then
						l_class_type ?= l_item.type
							-- This check is guaranteed by the precondition.
						check l_class_type_not_void: l_class_type /= Void end
							-- A "new" feature is found and we "count up" if...
						if
								-- we have not found anything so far,
							l_last_class_type = Void or else
								-- the class providing the feature changed or
							not l_last_class_type.same_as (l_class_type) or else
								-- the feature changed
							not l_last_feature.equiv (l_feature)
						then
								-- Only if we found a true new static type we update our information.
							l_last_class_type := l_class_type
							l_constraint_position := cursor.index
							l_last_feature  :=  l_feature
							l_features_found_count := l_features_found_count + 1
						else
							-- If it was the same static type that is ok because it does not change anything
							-- regarding the dynamic binding.
							-- G -> {COMPARABLE, COMPARABLE} is an example for such code.
							-- There are more complex examples which lead to the same effect where it makes
							-- more sense than this given example.
						end
					end

				end
				forth
			end
			if l_features_found_count  >  1  then
				l_last_feature := Void
				l_last_class_type := Void
			end
			Result := [l_last_feature, l_last_class_type, l_features_found_count, l_constraint_position]
		ensure
				-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantic_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantic_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
			e_feature_relation: e_feature_state_by_name_id (a_name_id).features_found_count = Result.features_found_count
		end

	feature_i_state_by_rout_id (a_routine_id: INTEGER): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			-- Compute feature state.
			--
			-- `a_routine_id': This is the routine id of the feature we're looking for.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_last_feature, l_feature: FEATURE_I
			l_class_type: CL_TYPE_A
			l_last_class_type: CL_TYPE_A
			l_features_found_count: INTEGER
			l_constraint_position: INTEGER
			l_item: RENAMED_TYPE_A [TYPE_A]
		do
			from
				start
			until
				after
			loop
				l_item := item
				check has_assocaited_class: l_item.has_associated_class end

				l_feature :=  l_item.type.associated_class.feature_of_rout_id (a_routine_id)

					-- Duplicated code. Occurs also in `feature_i_state_by_name_id'.
				if
					l_feature /= Void
				then
					l_constraint_position := cursor.index
					l_last_feature  :=  l_feature
					l_class_type ?= l_item.type
						-- This check is guaranteed by the precondition.
					check l_class_type_not_void: l_class_type /= Void end
						-- See comments in `feature_i_state_by_name_id'
							-- A "new" feature is found and we "count up" if...
					if
							-- we have not found anything so far,
						l_last_class_type = Void or else
							-- the class providing the feature changed or
						not l_last_class_type.same_as (l_class_type) or else
							-- the feature changed
						not l_last_feature.equiv (l_feature)
					then

						l_features_found_count := l_features_found_count + 1
					end
					l_last_class_type := l_class_type
				end
				forth
			end
			if l_features_found_count  >  1  then
				l_last_feature := Void
				l_last_class_type := Void
			end
			Result := [l_last_feature, l_last_class_type, l_features_found_count, l_constraint_position]
		ensure
					-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantic_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantic_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
			e_feature_relation: e_feature_state_by_rout_id (a_routine_id).features_found_count = Result.features_found_count
		end

	any_feature_i_by_routine_id (a_routine_id: INTEGER): TUPLE [feature_item: FEATURE_I; class_type: RENAMED_TYPE_A [TYPE_A]]
			-- Returns the first matching feature and its class type
			--
			-- `a_routine_id' is a routine id for which we query all types in the type set.
			--| An assignment attempt is needed.
		require
			not_has_formal: not has_formal
		local
			l_class: CLASS_C
			l_feat: FEATURE_I
			l_item: RENAMED_TYPE_A [TYPE_A]
		do
			from
				start
			until
				after or Result /= Void
			loop
				l_item := item
					-- implied by precondition: not_loose
				check has_associated_class: l_item.has_associated_class end
				l_class := l_item.associated_class
				l_feat := l_class.feature_of_rout_id (a_routine_id)
				if l_feat /= Void then
					Result := [l_feat, l_item]
				end
				forth
			end
		end

	feature_i_list_by_rout_id (a_routine_id: INTEGER): ARRAYED_LIST [TUPLE[feature_item: FEATURE_I; class_type: RENAMED_TYPE_A [TYPE_A]]]
			-- Builds a list of pairs of FEATURE_I and RENAMED_TYPE_A [TYPE_A] which all have a feature with routine id `a_routine_id'.
			--
			-- `a_routine_id' is the routine ID of the routine for which the list is built.
			--| If you are just interested in any feature for a given routine id use `first_feature_i'
		require
			not_has_formal: not has_formal
		local
			l_class: CLASS_C
			l_feat: FEATURE_I
			l_item: RENAMED_TYPE_A [TYPE_A]
		do
			create Result.make (3)
			from
				start
			until
				after
			loop
				l_item := item
					-- implied by precondition: not_loose
				check has_associated_class: l_item.has_associated_class end
				l_class := l_item.associated_class
				l_feat := l_class.feature_of_rout_id (a_routine_id)
				if l_feat /= Void then
					Result.extend ([l_feat, l_item])
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	feature_i_state_by_alias_name_id (an_alias_name_id: INTEGER): like feature_i_state_by_alias_name
			-- Compute feature state.
			--
			-- `an_alias' is a feature alias for which the state is computed.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_last_feature, l_feature: FEATURE_I
			l_class_c: CLASS_C
			l_class_type, l_last_class_type: CL_TYPE_A
			l_constraint_position: INTEGER
				-- The Position at which the constraint where the feature was selected from is written.
			l_features_found_count: INTEGER
			l_item: RENAMED_TYPE_A [TYPE_A]
			l_renaming: RENAMING_A
			l_name_id: INTEGER
		do
			from
				start
			until
				after
			loop
				l_item := item
				if l_item.has_associated_class then
					l_renaming := l_item.renaming
					l_class_c := l_item.associated_class
					if l_renaming = Void then
						l_feature :=  l_class_c.feature_table.item_alias_id (an_alias_name_id)
					else
						l_name_id := l_renaming.renamed (an_alias_name_id)
						if l_name_id > 0 then
							if l_name_id = an_alias_name_id then
								l_feature := l_class_c.feature_table.item_alias_id (l_name_id)
							else
								l_feature :=  l_class_c.feature_table.item_id (l_name_id)
							end
						else
							l_feature := Void
						end
					end

					if l_feature /= Void then
						l_class_type ?= l_item.type
								-- Precondition should ensure this.
						check class_type_not_void: l_class_type /= Void end
							-- A "new" feature is found and we "count up" if...
						if
								-- we have not found anything so far,
							l_last_class_type = Void or else
								-- the class providing the feature changed or
							not l_last_class_type.same_as (l_class_type) or else
								-- the feature changed
							not l_last_feature.equiv (l_feature)
						then
							l_constraint_position := cursor.index
							l_last_feature  :=  l_feature
							l_last_class_type := l_class_type
							l_features_found_count := l_features_found_count + 1
						else
								-- See `feature_i_state_by_name_id' for more comments.
						end

					end
				end
				forth
			end
			if l_features_found_count  >  1  then
				l_last_feature := Void
				l_last_class_type := Void
			end
			Result := [l_last_feature, l_last_class_type, l_features_found_count, l_constraint_position]
		ensure
			-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantic_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantic_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
		end

	e_feature_state (a_name: ID_AS): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A;  features_found_count: INTEGER]
			-- Compute feature state.
			--
			-- `a_name' is a feature id for which the state is computed.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			a_name_not_void: a_name /= Void
		do
			Result := e_feature_state_by_name_id (a_name.name_id)
		ensure
			result_not_void: Result /= Void
			feature_i_relation: feature_i_state (a_name).features_found_count = Result.features_found_count
		end

	e_feature_state_by_name_32  (a_name: STRING_32): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			-- Compute feature state.	
			--
			-- `a_name' is the name of the feature.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			a_name_not_void: a_name /= Void
			not_has_formal: not has_formal
		do
			Result := e_feature_state_by_name (encoding_converter.utf32_to_utf8 (a_name))
		ensure
			feature_i_relation: feature_i_state_by_name_id (names_heap.id_of (encoding_converter.utf32_to_utf8 (a_name))).features_found_count = Result.features_found_count
		end

	e_feature_state_by_name_id (a_name_id: INTEGER): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			-- Compute feature state.	
			--
			-- `a_name_id': It is the `names_heap'-id of the feature name string.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_item: TYPE_A
			l_last_feature: E_FEATURE
			l_feature, l_last_feature_i: FEATURE_I
			l_last_class_type: CL_TYPE_A
			l_class_c: CLASS_C
			l_features_found_count: INTEGER
			l_renaming: RENAMING_A
			l_constraint_position: INTEGER
			l_feature_table: FEATURE_TABLE
			l_class_type: CL_TYPE_A
		do
			from
				start
			until
				after
			loop
				l_item := item
				l_renaming := l_item.renaming
				-- Example for comments: rename f as g end
				-- `l_name_id' is the name id of `g'
				if l_item.has_associated_class then
					l_class_c := l_item.associated_class
					if l_class_c.has_feature_table then
						l_feature_table := l_class_c.feature_table
						if l_renaming /= Void then
							l_feature_table.search_id_under_renaming (a_name_id, l_renaming)
						else
							l_feature_table.search_id (a_name_id)
						end

						l_feature :=  l_feature_table.found_item

						if
							l_feature /= Void
						then
							l_class_type ?= item.type
								-- This check is guaranteed by the precondition.
							check l_class_type_not_void: l_class_type /= Void end
							-- A "new" feature is found and we "count up" if...
							if
									-- we have not found anything so far,
								l_last_class_type = Void or else
									-- the class providing the feature changed or
								not l_last_class_type.same_as (l_class_type) or else
									-- the feature changed
								not l_last_feature_i.equiv (l_feature)
							then
								l_constraint_position := cursor.index
								l_last_feature_i := l_feature
								l_last_feature  :=  l_feature.api_feature (l_class_c.class_id)
								l_last_class_type := l_class_type
								l_features_found_count := l_features_found_count + 1
							end
						end
					end
				end
			forth
			end
			if l_features_found_count  /=  1  then
				l_last_feature := Void
				l_last_class_type := Void
			end
			Result := [l_last_feature, l_last_class_type, l_features_found_count, l_constraint_position]
		ensure
				-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantic_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantic_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
			feature_i_relation: feature_i_state_by_name_id (a_name_id).features_found_count = Result.features_found_count
		end

	e_feature_state_by_rout_id (a_routine_id: INTEGER): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			-- Compute feature state for `a_routine_id'			
			--
			-- `a_routine_id' is the first entry in the routine id set of the queried routine.
			-- Returns Void for `feature_item' and `class_type_of_feature' if the feature cannot be found in the type set or if there are multiple found features.
			-- `features_found_count' will tell you how many features were found.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_last_feature, l_feature: E_FEATURE
			l_last_class_type: CL_TYPE_A
			l_features_found_count: INTEGER
			l_constraint_position: INTEGER
			l_item: TYPE_A
		do
			from
				start
			until
				after
			loop
				l_item := item
				if l_item.has_associated_class then
					l_feature := l_item.associated_class.feature_with_rout_id (a_routine_id)

					if
						l_feature /= Void
					then
						l_constraint_position := cursor.index
						l_last_feature  :=  l_feature
						l_last_class_type ?= item.type
							-- This check is guaranteed by the precondition.
						check l_last_class_type_not_void: l_last_class_type /= Void end
						l_features_found_count := l_features_found_count + 1
					end
				end
				forth
			end
			if l_features_found_count  >  1  then
				l_last_feature := Void
				l_last_class_type := Void
			end
			Result := [l_last_feature, l_last_class_type, l_features_found_count, l_constraint_position]
		ensure
				-- It states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantic_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantic_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
			feature_i_relation: feature_i_state_by_rout_id (a_routine_id).features_found_count = Result.features_found_count
		end

	any_e_feature_by_routine_id (a_routine_id: INTEGER): TUPLE [feature_item: E_FEATURE; class_type: RENAMED_TYPE_A [TYPE_A]]
			-- Returns the first matching feature and its class type
			--
			-- `a_routine_id' is a routine id for which we query all types in the type set.
			--| An assignment attempt is needed.
		require
			not_has_formal: not has_formal
		local
			l_class: CLASS_C
			l_feat: E_FEATURE
			l_item: RENAMED_TYPE_A [TYPE_A]
		do
			from
				start
			until
				after or Result /= Void
			loop
				l_item := item
					-- implied by precondition: not_loose
				check has_associated_class: l_item.has_associated_class end
				l_class := l_item.associated_class
				l_feat := l_class.feature_with_rout_id (a_routine_id)
				if l_feat /= Void then
					Result := [l_feat, l_item]
				end
				forth
			end
		end

	e_feature_list_by_rout_id (a_routine_id: INTEGER): ARRAYED_LIST[TUPLE[feature_item: E_FEATURE; class_type: RENAMED_TYPE_A [TYPE_A]]]
			--
		require
			not_has_formal: not has_formal
		local
			l_class: CLASS_C
			l_feat: E_FEATURE
			l_item: RENAMED_TYPE_A [TYPE_A]
		do
			create Result.make (3)
			from
				start
			until
				after
			loop
				l_item := item
					-- implied by precondition: not_loose
				check has_associated_class: l_item.has_associated_class end
				l_class := l_item.associated_class
				l_feat := l_class.feature_with_rout_id (a_routine_id)
				if l_feat /= Void then
					Result.extend ([l_feat, l_item])
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

		associated_classes: LIST[CLASS_C]
				-- All associated classes of the current type set.
			do
				create {LINKED_LIST[CLASS_C]} Result.make
				do_all (agent (a_class_list: LIST[CLASS_C]; a_type: RENAMED_TYPE_A [TYPE_A])
							do
								if a_type.has_associated_class then
									a_class_list.extend (a_type.associated_class)
								end
							end (Result, ?))
			end


feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	feature_i_state_by_alias_name (an_alias_name: STRING): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER;  constraint_position: INTEGER]
			-- Compute feature state.
			--
			-- `an_alias_name': A feature alias for which the state is computed.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			an_alias_name_not_void: an_alias_name /= Void
			not_has_formal: not has_formal
		do
			Result := feature_i_state_by_alias_name_id (names_heap.id_of (an_alias_name))
		ensure
				-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantic_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantic_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
		end

	e_feature_state_by_name  (a_name: STRING): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]
			-- Compute feature state.	
			--
			-- `a_name' is the name of the feature.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			a_name_not_void: a_name /= Void
			not_has_formal: not has_formal
		do
			Result := e_feature_state_by_name_id (names_heap.id_of (a_name))
		ensure
			feature_i_relation: feature_i_state_by_name_id (names_heap.id_of (a_name)).features_found_count = Result.features_found_count
		end

feature -- Access for Error handling

	info_about_feature (a_id: ID_AS; a_formal_position: INTEGER; a_context_class: CLASS_C): MC_FEATURE_INFO
			-- Gathers information  about a feature.
			--
			-- `a_id' is the ID for the feature for which information is gatherd.
		require
			a_id_not_void: a_id /= Void
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		do
			Result := info_about_feature_by_name_id (a_id.name_id, a_formal_position, a_context_class)
		ensure
			Result_not_void: Result /= Void
		end

	info_about_feature_by_name_id (a_name_id: INTEGER; a_formal_position: INTEGER; a_context_class: CLASS_C): like info_about_feature
			-- Gathers information  about a feature.
			--
			-- `a_name_id' is the name ID of the feature for which information is gatherd.
			-- `a_formal_position' position of the formal to which this typeset belongs.
			-- `a_context_class' is the class where the formal (denoted by `a_formal_position') has been defined.
		require
			a_name_id_valid: a_name_id > 0
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION [ANY, TUPLE [RENAMED_TYPE_A [TYPE_A]], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_name_id: INTEGER; a_ext_type: RENAMED_TYPE_A [TYPE_A]): TUPLE [E_FEATURE,FEATURE_I]
					local
						l_renamed_id: INTEGER
						l_class: CLASS_C
					do
						if a_ext_type.has_associated_class then
							l_class := a_ext_type.associated_class
							if l_class.has_feature_table then
								if a_ext_type.has_renaming then
									l_renamed_id := a_ext_type.renaming.renamed (g_name_id)
								else
									l_renamed_id := g_name_id
								end
								if l_renamed_id > 0 then
									Result := [	l_class.feature_with_name_id (l_renamed_id),
												l_class.feature_of_name_id (l_renamed_id)]
								end
							end
						end
					end (a_name_id, ?)
			Result := info_about_feature_by_agent (l_feature_agent, a_formal_position, a_context_class, create {SEARCH_TABLE [INTEGER]}.make (3))
			Result.set_data (names_heap.item (a_name_id), a_formal_position, a_context_class)
		ensure
			Result_not_void: Result /= Void
		end

	info_about_feature_by_alias_name_id (a_name_id: INTEGER; a_formal_position: INTEGER; a_context_class: CLASS_C): like info_about_feature
			-- Gathers information  about a feature.
			--
			-- `a_name_id' is the name ID of the feature for which information is gatherd.
			-- `a_formal_position' position of the formal to which this typeset belongs.
			-- `a_context_class' is the class where the formal (denoted by `a_formal_position') has been defined.
		require
			a_name_id_valid: a_name_id > 0
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION [ANY, TUPLE [RENAMED_TYPE_A [TYPE_A]], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_name_id: INTEGER; a_ext_type: RENAMED_TYPE_A [TYPE_A]): TUPLE [E_FEATURE,FEATURE_I]
					local
						l_renamed_id: INTEGER
						l_class: CLASS_C
						l_feature: FEATURE_I
					do
						if a_ext_type.has_associated_class then
							l_class := a_ext_type.associated_class
							if l_class.has_feature_table then
								if a_ext_type.has_renaming then
									l_renamed_id := a_ext_type.renaming.renamed (g_name_id)
									if l_renamed_id > 0 then
										if l_renamed_id = g_name_id then
											l_feature := l_class.feature_table.item_alias_id (l_renamed_id)
										else
											l_feature := l_class.feature_table.item_id (l_renamed_id)
										end
									end
								else
									l_feature := l_class.feature_table.item_alias_id (g_name_id)
								end
								if l_feature /= Void then
									Result := [l_feature.api_feature (l_class.class_id), l_feature]
								end
							end
						end
					end (a_name_id, ?)
			Result := info_about_feature_by_agent (l_feature_agent, a_formal_position, a_context_class, create {SEARCH_TABLE [INTEGER]}.make (3))
			Result.set_data (names_heap.item (a_name_id), a_formal_position, a_context_class)
		ensure
			Result_not_void: Result /= Void
		end

	info_about_feature_by_rout_id (a_routine_id: INTEGER; a_formal_position: INTEGER;  a_context_class: CLASS_C): like info_about_feature
			-- Gathers information about a feature.
			--
			-- `a_routine_id' is the ID for the feature for which information is gatherd.
			-- `a_formal_position' is used together with `a_context_class' to query the constraint list.
			-- `a_context_class' is used together with `a_formal_position' to query the constraint list.
		require
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION[ANY,TUPLE [RENAMED_TYPE_A [TYPE_A]], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_routine_id: INTEGER; l_ext_type: RENAMED_TYPE_A [TYPE_A]): TUPLE [E_FEATURE,FEATURE_I]
						-- Note that `g_renaming' is not used for routine id.
					local
						l_class: CLASS_C
					do
							-- If somehow possible try to find the feature.
						if l_ext_type.has_associated_class then
							l_class := l_ext_type.associated_class
							if l_class.has_feature_table then
								Result := [	l_class.feature_with_rout_id (g_routine_id),
											l_class.feature_of_rout_id (g_routine_id)]
							else
								-- Result := Void
							end
						end
					end (a_routine_id, ?)
			Result := info_about_feature_by_agent (l_feature_agent, a_formal_position, a_context_class, create {SEARCH_TABLE [INTEGER]}.make (3))
			Result.set_data (Void, a_formal_position, a_context_class)
		ensure
			Result_not_void: Result /= Void
		end

	check_renaming
			-- Checks the renaming of the whole type set.
			--| Are there any features which are renamed twice?
			--| Are there any two features which are renamed to the same name?
		do
			-- Martins 2/27/2007: this is done on a per call basis currently.
			-- If one doesnt call a feature which actually is in conflict state
			-- there won't be an error.
			-- One could of course still tell the programmer that he introduced a conflict by
			-- renaming.
		end

feature {TYPE_SET_A} -- Access implementation

	info_about_feature_by_agent (a_feature: FUNCTION [ANY, TUPLE [RENAMED_TYPE_A [TYPE_A]], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]; a_formal_position: INTEGER; a_context_class: CLASS_C; a_visited_formals: SEARCH_TABLE [INTEGER]): like info_about_feature_by_rout_id
			-- Gather information about feature
			-- 			
			-- `a_feature' is an agent which returns information about a feature given a `CLASS_C' instance.			
			-- `a_formal_position' is the position of the formal to which this typeset belongs.
			-- `a_context_class' is the context class where the formals are defined.
			-- `a_visited_formals' used to break recursion. Simply pass an empty one if your start the recursion.
		require
			a_feature_not_void: a_feature /= Void
			a_visited_formals_not_void: has_formal implies a_visited_formals /= Void
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_item: RENAMED_TYPE_A [TYPE_A]
			l_item_type: TYPE_A
			l_formal: FORMAL_A
			l_formal_position: INTEGER
			l_query_result: TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]
			l_constraint_position: INTEGER
		do
			create Result.make

			from
				start
			until
				after
			loop
				l_item := item
				l_item_type := l_item.type
				if l_item_type.is_formal then
					l_formal ?= l_item_type
						-- The precondition ensures this:
					check a_context_class_not_void: a_context_class /= Void end
						-- Recursion
					l_formal_position := l_formal.position
					if not a_visited_formals.has (l_formal_position) then
						a_visited_formals.put (l_formal_position)
						Result.merge_right (l_formal.constraints (a_context_class).info_about_feature_by_agent(a_feature, l_formal_position, a_context_class, a_visited_formals))
					end
				else
					if l_item.has_associated_class then
						l_query_result := a_feature.item ([l_item])
							-- Check whether we found at least something useful and then insert an entry.
						if l_query_result /= Void and then (l_query_result.e_feature /= Void or l_query_result.feature_i /= Void) then
							l_constraint_position := cursor.index
							Result.extend([l_query_result.feature_i, l_query_result.e_feature, l_item, a_formal_position, l_constraint_position])
						end
					end
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Conversion

	to_type_set: TYPE_SET_A
			-- Create a type set containing one element which is `Current'.
		do
			Result := Current
		end

	substitude_formals (a_generic_context_type: GEN_TYPE_A)
			-- Replaces (!) formal types with their generic derivation.
			--
			-- `a_generic_context_type' is the supplier of the actual generics
		require
			a_generic_context_type_not_void: a_generic_context_type /= Void
		local
			l_formal: FORMAL_A
			l_gen_type: GEN_TYPE_A
			l_item_type: TYPE_A
		do
			from
				start
			until
				after
			loop
				l_item_type := item.type
				l_formal ?= l_item_type
				if l_formal /= Void then
					item.set_type (a_generic_context_type.generics [l_formal.position])
				else
					l_gen_type ?= l_item_type
					if l_gen_type /= Void then
						l_gen_type.substitute (a_generic_context_type.generics)
					end
				end
				forth
			end
		end

feature -- Comparison

	conform_to (a_context_class: CLASS_C; a_other: like Current): BOOLEAN
			-- Is `Current' conform to `a_other' in `a_context_class'?
			-- `a_other' will be modified. Elements will be removed.
			-- So pass a copy if you still need it after this call.
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			a_other_not_void: a_other /= Void
		do
			-- Each element in `Current' must be conform to each other element in `a_other'
			from
				start
			until
				after or a_other.is_empty
			loop
				from
					a_other.start
				until
					a_other.after
				loop
					if item.type.conform_to (a_context_class, a_other.item.type) then
						a_other.remove
					elseif not a_other.after then
						a_other.forth
					end
				end
				forth
			end

			if a_other.is_empty then
				Result := True
			end
			a_other.wipe_out
				-- This is not necessary but will hopefully prevent further usage
		end

	conform_to_type (a_context_class: CLASS_C; a_type: TYPE_A): BOOLEAN
			-- Is `Current' conform to `a_type' in `a_context_class'?
		local
			l_type_set: TYPE_SET_A
		do
			l_type_set ?= a_type
			if l_type_set /= Void then
				Result := conform_to (a_context_class, l_type_set.twin)
			else
					-- If at least one element of `Current' conforms to `a_type' then the type set conforms to the type.
				Result := False
				from
					start
				until
					after or Result
				loop
					Result := item.type.conform_to (a_context_class, a_type.conformance_type)
					last_type_checked := item
					forth
				end
			end
		end

	is_conforming_type (a_context_class: CLASS_C; a_type: TYPE_A): BOOLEAN
			-- Conforms `a_type' to the type set in `a_context_class'?
		require
			a_context_class_not_void: a_context_class /= Void
			a_context_class_valid: a_context_class.is_valid
			a_context_valid_for_current: is_valid_for_class (a_context_class)
			is_valid: is_valid
			a_type_not_void: a_type /= Void
			a_type_is_valid: a_type.is_valid
		do
				-- If `a_type' is not conform to at least one element of the type set then `a_type' is not conform to the type set.
			Result := True
			from
				start
			until
				after or not Result
			loop
				Result := a_type.conform_to (a_context_class, item.type)
				last_type_checked := item
				forth
			end
		end

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		local
			s1,s2: like Current
		do
			create s1.make (count)
			s1.copy (Current)
			create s2.make (other.count)
			s2.copy (other)
		end

	same_as (other: TYPE_A): BOOLEAN
			-- <Precursor>
		do
			if attached {like Current} other as l_other_set and then l_other_set.count = count then
				from
					start
					l_other_set.start
					Result := True
				until
					after or else not Result
				loop
					Result := item.type.same_as (l_other_set.item.type)
					forth
					l_other_set.forth
				end
			end
		end

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C)
			-- Append `Current' to `text'.
			-- `c' is used to retreive the generic type or argument name as string.	
		do
			check first /= Void  end
			if count > 1 then
				a_text_formatter.add ("{" )
			end
			first.type.ext_append_to (a_text_formatter,c)
			from
				start
				forth
			until
				after
			loop
				a_text_formatter.add ("," )
				item.type.ext_append_to (a_text_formatter,c)
				forth
			end
			if count > 1 then
				a_text_formatter.add ("}" )
			end
		end

	dump: STRING
			-- Dumped trace
		do
			create Result.make (50)
			check first /= Void  end
			if count > 1 then
				Result.append ("{" )
			end
			Result.append (first.dump)
			from
				start
				forth
			until
				after
			loop
				Result.append ("," )
				Result.append (item.dump)
				forth
			end
			if count > 1 then
				Result.append ("}" )
			end
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Id of a `like xxx'.
		do
			Result := {SHARED_GEN_CONF_LEVEL}.detachable_none_type
			check
				generated_id_not_implemented: False
			end
		end


feature -- Status

	has_expanded: BOOLEAN
			-- Does the current type set contain the NONE type?
		do
			Result := there_exists (agent(a_renamed_type: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						do
							Result := a_renamed_type.type.is_expanded
						end)
		end

	has_none: BOOLEAN
			-- Does the current type set contain the NONE type?
		do
			Result := there_exists (agent(a_renamed_type: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						do
							Result := a_renamed_type.type.is_none
						end)
		end

	has_void: BOOLEAN
			-- Does the current type set contain the NONE type?
		do
			Result := there_exists (agent(a_renamed_type: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						do
							Result := a_renamed_type.type.is_void
						end)
		end

	has_overloaded (a_feature_name_id: INTEGER): BOOLEAN
			-- Does Current have `a_feature_name' as an overloaded routine?
		local
			l_type: TYPE_A
			l_feature_table: FEATURE_TABLE
			l_class: CLASS_C
			l_overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
		do
			from
				start
			until
				after or Result
			loop
				l_type := item.type
				check l_type /= Void  end
				if l_type.has_associated_class then
					l_class := l_type.associated_class
					check l_class /= Void  end
					l_feature_table := l_class.feature_table
					l_overloaded_names := l_feature_table.overloaded_names
					if l_class.is_true_external and l_overloaded_names /= Void then
						if a_feature_name_id > 0 then
							Result := l_overloaded_names.has (a_feature_name_id)
						end
					end
				end
				forth
			end
		end

	has_renamings: BOOLEAN
			-- Has the `current' any renamings?
		do
			Result := there_exists (agent(a_renamed_type: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						do
							Result := a_renamed_type.type.has_renaming
						end)
		end

	has_formal_generic: BOOLEAN
			-- Has current type set any formal genrics?
		do
			Result := there_exists (agent(a_renamed_type: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						do
							Result := a_renamed_type.type.has_formal_generic
						end)
		end

	is_class_valid: BOOLEAN
			-- Is the type set valid, meaning that all items are valid items?
		do
			Result := for_all (agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						do
							Result := a_item.type.is_class_valid
						end)
		end

	is_type_set: BOOLEAN
			-- Is `Current' an instance of `TYPE_SET_A'?
		do
			Result := True
		end

	is_loose: BOOLEAN
			-- Is at least one of the types om the type set a loose type (`is_loose')?
		do
			Result := there_exists (agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						 do
						 	Result := a_item.type.is_loose
						 end)
		end

	has_formal: BOOLEAN
			-- Does the current set contain a formal type?
			--| A generic (GEN_TYPE_A) which has a formal type parameter is not counted.
		do
			Result := there_exists (agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						 do
						 	Result := a_item.type.is_formal
						 end)
		end

	has_deferred: BOOLEAN
			-- Does the current set contain a deferred class?
		do
			Result := there_exists (agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
						 do
						 	if a_item.has_associated_class then
						 		Result := a_item.associated_class.is_deferred
						 	end
						 end)
		end

	is_attached: BOOLEAN
			-- <Precursor>
		do
			Result := there_exists (
				agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
					do
						Result := a_item.type.is_attached
					end
				)
		end

	is_separate: BOOLEAN
			-- <Precursor>
		do
			Result := for_all (
				agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
					do
						Result := a_item.type.is_separate
					end
				)
		end

	is_expanded: BOOLEAN
			-- Is the current actual type an expanded one ?
		do
			Result := for_all (agent (a_item: RENAMED_TYPE_A [TYPE_A]): BOOLEAN
				do
					Result := a_item.type.is_expanded
				end)
		end

feature -- Access

	hash_code: INTEGER_32
			-- Hash code value.
		local
			l_rotate, l_bytes, i: INTEGER_32
		do
			Result := {SHARED_HASH_CODE}.other_code
			from
				start
				i := count
			until
				after
			loop
				l_rotate := item.hash_code
				l_bytes := 4 * (1 + i \\ 8)
				l_rotate := (l_rotate |<< l_bytes) | (l_rotate |>> (32 - l_bytes))
				Result := Result.bit_xor (item.hash_code)
				i := i - 1
				forth
			end
			Result := Result.hash_code
		end

	expanded_representative: RENAMED_TYPE_A [TYPE_A]
			-- Expanded item is returned.
			--| Such a case can be treated like a normal type because there's no other class which can satisfy the constraint but the expanded itself.
			--| If you write code like G-> {COMPARABLE,INTEGER_REF,INTEGER} (which is non-sense)
			--| this code would return INTEGER.
			--| If you write something like G->{DOUBLE,INTEGER} this code will return whatever it finds first.
			--| This error will be caught by the trial of a generic derivation, because no class can satisfy the constraint.
		require
			has_expanded: has_expanded
		local
			l_renamed_type: RENAMED_TYPE_A [TYPE_A]
		do
			from
				start
			until
					-- Precondition ensures that we find something
				Result /= Void
			loop
				check
					not_after: not after
				end
				l_renamed_type := item
				if l_renamed_type.type.is_expanded	then
					Result := l_renamed_type
				end
				forth
			end
		ensure
			result_not_void: Result /= Void
			result_is_expaned: Result.type.is_expanded
		end

	constraining_types (a_context_class: CLASS_C): TYPE_SET_A
			-- Constraining types of `a_type'.
			--| A generic (GEN_TYPE_A) which has a formal type parameter is not counted, but all chains of formals like [G->H, H->I,I->STRING] are resolved.
			--| Recursive formals fall back to ANY.
			--| This feature cannot be used straight forward for any kind of conformance checking, but certainly is well suited  for things like looking up a feature.
			--| You may run into troubles because we loose information if we delete the resursive chain like [G->H,H->G] we loose the fact that G and H actually are identical.
		require
			a_context_classt_not_void: a_context_class /= Void
		local
			l_type_set_item: TYPE_A
			l_formal_type: FORMAL_A
		do
			if	has_formal then
				create Result.make (count +2)
				from
					start
				until
					after
				loop
					l_type_set_item := item.type

						-- We have to get rid of all formals occuring somwhere (be it a generic type or a typeset)				
						-- `has_generic' is more expensive forTYPE_SET_A
					if l_type_set_item.is_formal then
							l_formal_type ?= l_type_set_item
								-- An Item which has already been asked for but has not been resolved so far is a circle
								-- We want to avoid inifinite recursion, therefore we break here and
								-- fall back to ANY, which is the proper solution for a cycle in the constraints like [G->G],  [G->H, H->G], ...
								-- If we have something like G-> {G, STRING}, STRING will be returned as the constraint.
							if not formal_resolution_stack.has (l_formal_type.position) then
									-- Push the current item
								formal_resolution_stack.put (l_formal_type.position)
								Result.merge (l_formal_type.constraints (a_context_class).constraining_types  (a_context_class))
									-- Pop the current item
								formal_resolution_stack.remove
							end
					else
						Result.extend (item)
					end
					forth
				end
				if Result.is_empty and formal_resolution_stack.is_empty then
						-- if formal_resolution_stack.is_empty we are at the end of computation.
					Result.extend (create {RENAMED_TYPE_A [TYPE_A]}.make (create {CL_TYPE_A}.make (system.any_id), Void))
				end
			--| Martins 1/23/07:
			--| We do not remove duplicates as one can rename features differently.
			--| G -> {H rename f as f_h1 end, H rename f as f_h2 end}
				--| Martins 2/19/07:
				--| There are no duplicates because it's not allowed anymore. This is ensured by special check feature.
			else
				Result := Current
			end
		ensure
			result_not_void: Result /= Void
			only_changed_if_necessary: not old has_formal implies Result = Current
			not_has_formal: not Result.has_formal
		end

	constraining_types_if_possible (a_context_class: CLASS_C): TYPE_SET_A
			-- Fault tolerant constraining types of `a_type'.
			-- Use it for feature lookups in faulty systems.
			--
			-- `a_context_class' is the context in which the formals are evaluated.
			--| A generic (GEN_TYPE_A) which has a formal type parameter is not counted, but all chains of formals like [G->H, H->I,I->STRING] are resolved.
			--| Recursive formals fall back to ANY.
			--| This feature cannot be used straight forward for any kind of conformance checking, but certainly is well suited  for things like looking up a feature.
			--| You may run into troubles because we loose information if we delete the resursive chain like [G->H,H->G] we loose the fact that G and H actually are identical.
		require
			a_context_classt_not_void: a_context_class /= Void
		local
			l_type_set_item: TYPE_A
			l_formal_type: FORMAL_A
		do
			if	has_formal then
				create Result.make (count +2)
				from
					start
				until
					after
				loop
					l_type_set_item := item.type

						-- We have to get rid of all formals occuring somwhere (be it a generic type or a typeset)				
						-- `has_generic' is more expensive for TYPE_SET_A
					if l_type_set_item.is_formal then
							l_formal_type ?= l_type_set_item
								-- An Item which has already been asked for but has not been resolved so far is a circle
								-- We want to avoid inifinite recursion, therefore we break here and
								-- fall back to ANY, which is the proper solution for a cycle in the constraints like [G->G],  [G->H, H->G], ...
								-- If we have something like G-> {G, STRING}, STRING will be returned as the constraint.
							if not formal_resolution_stack.has (l_formal_type.position) then
									-- Push the current item
								formal_resolution_stack.put (l_formal_type.position)
								Result.merge (l_formal_type.constraints_if_possible (a_context_class).constraining_types_if_possible  (a_context_class))
									-- Pop the current item
								formal_resolution_stack.remove
							end
					end
					forth
				end
				if Result.is_empty and formal_resolution_stack.is_empty then
						-- if formal_resolution_stack.is_empty we are at the end of computation.
					Result.extend (create {RENAMED_TYPE_A [TYPE_A]}.make (create {CL_TYPE_A}.make (system.any_id), Void))
				end
			--| Martins 1/23/07:
			--| We do not remove duplicates as one can rename features differently.
			--| G -> {H rename f as f_h1 end, H rename f as f_h2 end}
				--| Martins 2/19/07:
				--| There are no duplicates because it's not allowed anymore. This is ensured by a special check feature.
			else
				Result := Current
			end
		ensure
			result_not_void: Result /= Void
			only_changed_if_necessary: not old has_formal implies Result = Current
			not_has_formal: not Result.has_formal
		end

	overloaded_items (an_id: INTEGER): LIST [FEATURE_I]
			-- List of features matching overloaded name `an_id'.
		local
			l_feature_table_set: ARRAYED_LIST[FEATURE_TABLE]
			l_feature_table: FEATURE_TABLE
			l_names: ARRAYED_LIST [INTEGER_32]
			l_total_names_count: INTEGER
			l_item: TYPE_A
		do
			create l_feature_table_set.make (count)
			from start until after loop
				l_item := item
				if l_item.has_associated_class then
					l_feature_table := l_item.associated_class.feature_table
					l_feature_table_set.extend (l_feature_table)
					l_total_names_count := l_total_names_count +l_feature_table.overloaded_names.count
				end
				forth
			end
			create {ARRAYED_LIST [FEATURE_I]} Result.make (l_total_names_count)
			from
				l_feature_table_set.start
			until
				l_feature_table_set.after
			loop
				l_feature_table := l_feature_table_set.item
				l_names := l_feature_table.overloaded_names.item (an_id)
				from
					l_names.start
				until
					l_names.after
				loop
					Result.extend (l_feature_table.item_id (l_names.item))
					l_names.forth
				end
				l_feature_table_set.forth
			end
		end

	last_type_checked: RENAMED_TYPE_A [TYPE_A]
		-- Last type checked.
		-- Use this feature for error reporting.

feature -- Attachment properties

	as_attached_type: like Current
			-- Attached variant of the current type
		local
			i: INTEGER
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
		do
			Result := Precursor
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
				if not t.is_attached then
					r := r.duplicate
					r.set_type (t.as_attached_type)
					Result [i] := r
				end
				i := i - 1
			end
		end

	as_implicitly_attached: like Current
			-- Implicitly attached type
		local
			i: INTEGER
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
		do
			Result := Precursor
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
				if not t.is_attached and then not t.is_implicitly_attached then
					r := r.duplicate
					r.set_type (t.as_implicitly_attached)
					Result [i] := r
				end
				i := i - 1
			end
		end

	as_implicitly_detachable: like Current
			-- Implicitly detachable type
		local
			i: INTEGER
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
		do
			Result := Precursor
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
				if is_implicitly_attached then
					r := r.duplicate
					r.set_type (t.as_implicitly_detachable)
					Result [i] := r
				end
				i := i - 1
			end
		end

	as_detachable_type: like Current
			-- detachable type
		local
			i: INTEGER
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
		do
			Result := Precursor
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
--				if r.has_detachable_mark then
					r := r.duplicate
					r.set_type (t.as_detachable_type)
					Result [i] := r
--				end
				i := i - 1
			end
		end

	as_marks_free: like Current
			-- Same as Current but without any attachment and separate marks
		local
			i: like count
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
			q: TYPE_A
		do
			Result := Precursor
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
				q := t.as_marks_free
				if q /= t then
					r := r.duplicate
					r.set_type (q)
					Result [i] := r
				end
				i := i - 1
			end
		end

	to_other_attachment (other: ATTACHABLE_TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
		local
			i: INTEGER
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
			a: TYPE_A
		do
			Result := Current
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
				a := t.to_other_attachment (other)
				if a /= t then
						-- The type is different from what we have in the current one.
					r := r.duplicate
					r.set_type (a)
					if Result = Current then
							-- Avoid changing current type descriptor.
						Result := duplicate
					end
					Result [i] := r
				end
				i := i - 1
			end
		end

	to_other_immediate_attachment (other: ATTACHABLE_TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
			-- without taking into consideration attachment status of an anchor (if any)
		local
			i: INTEGER
			r: RENAMED_TYPE_A [TYPE_A]
			t: TYPE_A
			a: TYPE_A
		do
			Result := Current
			from
				i := count
			until
				i <= 0
			loop
				r := Result [i]
				t := r.type
				a := t.to_other_immediate_attachment (other)
				if a /= t then
						-- The type is different from what we have in the current one.
					r := r.duplicate
					r.set_type (a)
					if Result = Current then
							-- Avoid changing current type descriptor.
						Result := duplicate
					end
					Result [i] := r
				end
				i := i - 1
			end
		end

feature -- Not anymore applicable: a type set has most likley not one, but many associated classes.

	associated_class: CLASS_C
			-- Class associated to the current type.
		do
				-- We are not able to return a CLASS_C object so easily.
				-- One could maybe introduce something like that which would enable more transparency at some places (like providing a merged feature table of all types in the typeset).
				-- For now it is a dead feature.
			check false end
		end

feature {COMPILER_EXPORTER} -- Access

	create_info: CREATE_FORMAL_TYPE
			-- Create formal type info.
		do
				-- TYPE_SET_A does not support this feature.
			check false end
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
				-- Martins 12/19/06: Right now it would most likely be a bug if we arrive here.
			check false end
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is the type set valid, meaning that all items are valid items?
		do
			Result := for_all (agent (a_item: RENAMED_TYPE_A [TYPE_A]; a_context_class: CLASS_C): BOOLEAN
						do
							Result := a_item.type.internal_is_valid_for_class (a_context_class)
						end (?, a_class))
		end

feature {NONE} -- Implementation

	formal_resolution_stack: STACK[INTEGER]
			-- A stack which is used to prohibit inifinite recursion while resolving a formal type to its constraining type set.
		once
			create {ARRAYED_STACK[INTEGER]} Result.make (3)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

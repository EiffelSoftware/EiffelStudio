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
	INTERNAL_COMPILER_STRING_EXPORTER
		redefine
			copy, is_equal
		end

	ITERABLE [RENAMED_TYPE_A]
		redefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		redefine
			copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		redefine
			copy, is_equal
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		redefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		redefine
			copy, is_equal
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		redefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER_32)
			-- <Precursor>
		do
			create types.make (n)
			types.compare_objects
		end

feature -- Access

	deferred_classes: ARRAYED_LIST [CLASS_C]
			-- List of all classes that are deferred in the set.
		do
			create Result.make (types.count)
			across types as l_renamed_type loop
				if
					attached l_renamed_type.item.base_class as l_class and then
					l_class.is_deferred
				then
					Result.extend (l_class)
				end
			end
		end

	new_cursor: INDEXABLE_ITERATION_CURSOR [RENAMED_TYPE_A]
			-- Fresh cursor associated with current structure
		do
			Result := types.new_cursor
		end

	instantiated_in (class_type: TYPE_A): TYPE_SET_A
		local
			l_instantiated_type, l_item_type: TYPE_A
			i: INTEGER
		do
			from
				start
				i := 1
			until
				after
			loop
				l_item_type := item.type
				l_instantiated_type := l_item_type.instantiated_in (class_type)
				if l_instantiated_type /= l_item_type then
					if Result = Void then
						Result := twin
					end
					Result.put_i_th (create {RENAMED_TYPE_A}.make (l_instantiated_type, item.renaming), i)
				end
				i := i + 1
				forth
			end
			if Result = Void then
				Result := Current
			end
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
			l_constraint_position, i: INTEGER
			l_feature_table: FEATURE_TABLE
			l_item: RENAMED_TYPE_A
		do
			from
				start
				i := 1
			until
				after
			loop
				l_renaming := item.renaming
				-- Example for comments: rename f as g end
				-- `l_name_id' is the name id of `g'
				l_item := item
				if l_item.has_associated_class and then l_item.base_class.has_feature_table then
					l_feature_table := l_item.base_class.feature_table
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
							l_constraint_position := i
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
				i := i + 1
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

	feature_i_list_by_rout_id (a_routine_id: INTEGER): ARRAYED_LIST [TUPLE[feature_item: FEATURE_I; class_type: RENAMED_TYPE_A]]
			-- Builds a list of pairs of FEATURE_I and RENAMED_TYPE_A which all have a feature with routine id `a_routine_id'.
			--
			-- `a_routine_id' is the routine ID of the routine for which the list is built.
			--| If you are just interested in any feature for a given routine id use `first_feature_i'
		require
			not_has_formal: not has_formal
		local
			l_class: CLASS_C
			l_feat: FEATURE_I
			l_item: RENAMED_TYPE_A
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
				l_class := l_item.base_class
				l_feat := l_class.feature_of_rout_id (a_routine_id)
				if l_feat /= Void then
					Result.extend ([l_feat, l_item])
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	feature_i_state_by_alias_name_id (an_alias_name_id: INTEGER): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER;  constraint_position: INTEGER]
			-- Compute feature state.
			--
			-- `an_alias' is a feature alias ID for which the state is computed.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not has_formal
			{OPERATOR_KIND}.is_alias_id (an_alias_name_id)
			{OPERATOR_KIND}.is_fixed_alias_id (an_alias_name_id)
		local
			l_last_feature, l_feature: FEATURE_I
			l_class_c: CLASS_C
			l_class_type, l_last_class_type: CL_TYPE_A
			l_constraint_position, i: INTEGER
				-- The Position at which the constraint where the feature was selected from is written.
			l_features_found_count: INTEGER
			l_item: RENAMED_TYPE_A
			l_renaming: RENAMING_A
			l_name_id: INTEGER
		do
			from
				start
				i := 1
			until
				after
			loop
				l_item := item
				if l_item.has_associated_class then
					l_renaming := l_item.renaming
					l_class_c := l_item.base_class
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
							l_constraint_position := i
							l_last_feature  :=  l_feature
							l_last_class_type := l_class_type
							l_features_found_count := l_features_found_count + 1
						else
								-- See `feature_i_state_by_name_id' for more comments.
						end

					end
				end
				forth
				i := i + 1
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
			Result := e_feature_state_by_name_id (names_heap.id_of (encoding_converter.utf32_to_utf8 (a_name)))
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
			l_item: RENAMED_TYPE_A
			l_last_feature: E_FEATURE
			l_feature, l_last_feature_i: FEATURE_I
			l_last_class_type: CL_TYPE_A
			l_class_c: CLASS_C
			l_features_found_count: INTEGER
			l_renaming: RENAMING_A
			l_constraint_position, i: INTEGER
			l_feature_table: FEATURE_TABLE
			l_class_type: CL_TYPE_A
		do
			from
				start
				i := 1
			until
				after
			loop
				l_item := item
				l_renaming := l_item.renaming
				-- Example for comments: rename f as g end
				-- `l_name_id' is the name id of `g'
				if l_item.has_associated_class then
					l_class_c := l_item.base_class
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
								l_constraint_position := i
								l_last_feature_i := l_feature
								l_last_feature  :=  l_feature.api_feature (l_class_c.class_id)
								l_last_class_type := l_class_type
								l_features_found_count := l_features_found_count + 1
							end
						end
					end
				end
				forth
				i := i + 1
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

	e_feature_list_by_rout_id (a_routine_id: INTEGER): ARRAYED_LIST[TUPLE[feature_item: E_FEATURE; class_type: RENAMED_TYPE_A]]
			--
		require
			not_has_formal: not has_formal
		local
			l_class: CLASS_C
			l_feat: E_FEATURE
			l_item: RENAMED_TYPE_A
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
				l_class := l_item.base_class
				l_feat := l_class.feature_with_rout_id (a_routine_id)
				if l_feat /= Void then
					Result.extend ([l_feat, l_item])
				end
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

	associated_classes: ARRAYED_LIST [CLASS_C]
			-- All associated classes of the current type set.
		do
			create Result.make (types.count)
			across types as l_renamed_type loop
				if l_renamed_type.item.has_associated_class then
					Result.extend (l_renamed_type.item.base_class)
				end
			end
		end

feature -- Access for Error handling

	info_about_feature_by_name_id (a_name_id: INTEGER; a_formal_position: INTEGER; a_context_class: CLASS_C): MC_FEATURE_INFO
			-- Gathers information  about a feature.
			--
			-- `a_name_id' is the name ID of the feature for which information is gatherd.
			-- `a_formal_position' position of the formal to which this typeset belongs.
			-- `a_context_class' is the class where the formal (denoted by `a_formal_position') has been defined.
		require
			a_name_id_valid: a_name_id > 0
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION [RENAMED_TYPE_A, TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_name_id: INTEGER; a_ext_type: RENAMED_TYPE_A): TUPLE [E_FEATURE,FEATURE_I]
					local
						l_renamed_id: INTEGER
						l_class: CLASS_C
					do
						if a_ext_type.has_associated_class then
							l_class := a_ext_type.base_class
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

	info_about_feature_by_alias_name_id (a_name_id: INTEGER; a_formal_position: INTEGER; a_context_class: CLASS_C): MC_FEATURE_INFO
			-- Gathers information  about a feature.
			--
			-- `a_name_id' is the alias ID of the feature for which information is gatherd.
			-- `a_formal_position' position of the formal to which this typeset belongs.
			-- `a_context_class' is the class where the formal (denoted by `a_formal_position') has been defined.
		require
			{OPERATOR_KIND}.is_alias_id (a_name_id)
			{OPERATOR_KIND}.is_fixed_alias_id (a_name_id)
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION [RENAMED_TYPE_A, TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_name_id: INTEGER; a_ext_type: RENAMED_TYPE_A): TUPLE [E_FEATURE,FEATURE_I]
					local
						l_renamed_id: INTEGER
						l_class: CLASS_C
						l_feature: FEATURE_I
					do
						if a_ext_type.has_associated_class then
							l_class := a_ext_type.base_class
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
			Result.set_data (names_heap.item ({OPERATOR_KIND}.name_id_of_alias_id (a_name_id)), a_formal_position, a_context_class)
		ensure
			Result_not_void: Result /= Void
		end

	info_about_feature_by_rout_id (a_routine_id: INTEGER; a_formal_position: INTEGER;  a_context_class: CLASS_C): MC_FEATURE_INFO
			-- Gathers information about a feature.
			--
			-- `a_routine_id' is the ID for the feature for which information is gatherd.
			-- `a_formal_position' is used together with `a_context_class' to query the constraint list.
			-- `a_context_class' is used together with `a_formal_position' to query the constraint list.
		require
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION[RENAMED_TYPE_A, TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_routine_id: INTEGER; l_ext_type: RENAMED_TYPE_A): TUPLE [E_FEATURE,FEATURE_I]
						-- Note that `g_renaming' is not used for routine id.
					local
						l_class: CLASS_C
					do
							-- If somehow possible try to find the feature.
						if l_ext_type.has_associated_class then
							l_class := l_ext_type.base_class
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

feature {TYPE_SET_A} -- Access implementation

	info_about_feature_by_agent (a_feature: FUNCTION [RENAMED_TYPE_A, TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]; a_formal_position: INTEGER; a_context_class: CLASS_C; a_visited_formals: SEARCH_TABLE [INTEGER]): like info_about_feature_by_rout_id
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
			l_item: RENAMED_TYPE_A
			l_item_type: TYPE_A
			l_formal: FORMAL_A
			l_formal_position: INTEGER
			l_query_result: TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]
			i: INTEGER
		do
			create Result.make

			from
				start
				i := 1
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
							Result.extend([l_query_result.feature_i, l_query_result.e_feature, l_item, a_formal_position, i])
						end
					end
				end
				i := i + 1
				forth
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Conversion

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

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				if types = Void or else types = other.types then
					types := other.types.twin
				else
					types.wipe_out
					types.append (other.types)
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := types.is_equal (other.types)
		end

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

	conform_to_type (a_context_class: CLASS_C; a_type: TYPE_SET_A): BOOLEAN
			-- Is `Current' conform to `a_type' in `a_context_class'?
		local
			l_type: TYPE_A
		do
			if a_type.count > 1 then
				Result := conform_to (a_context_class, a_type.twin)
			else
					-- If at least one element of `Current' conforms to `a_type' then the type set conforms to the type.
				Result := False
				l_type := a_type.first.type
				from
					start
				until
					after or Result
				loop
					Result := item.type.conform_to (a_context_class, l_type.conformance_type)
					forth
				end
			end
		end

feature -- Output

	frozen append_to (a_text_formatter: TEXT_FORMATTER)
			-- Append `Current' to `text'.
		do
			ext_append_to (a_text_formatter, Void)
		end

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C)
			-- Append `Current' to `text'.
			-- `c' is used to retreive the generic type or argument name as string.	
		do
			check first /= Void  end
			if count > 1 then
				a_text_formatter.add ("{" )
			end
			first.ext_append_to (a_text_formatter,c)
			from
				start
				forth
			until
				after
			loop
				a_text_formatter.add ("," )
				item.ext_append_to (a_text_formatter,c)
				forth
			end
			if count > 1 then
				a_text_formatter.add ("}" )
			end
		end

feature -- Status

	has_expanded: BOOLEAN
			-- Does the current type set contain the NONE type?
		do
			Result := across types as l_renamed_type some l_renamed_type.item.type.is_expanded end
		end

	has_none: BOOLEAN
			-- Does the current type set contain the NONE type?
		do
			Result := across types as l_renamed_type some l_renamed_type.item.type.is_none end
		end

	is_class_valid: BOOLEAN
			-- Is the type set valid, meaning that all items are valid items?
		do
			Result := across types as l_renamed_type all l_renamed_type.item.type.is_class_valid end
		end

	is_loose: BOOLEAN
			-- Is at least one of the types om the type set a loose type (`is_loose')?
		do
			Result := across types as l_renamed_type some l_renamed_type.item.type.is_loose end
		end

	has_formal: BOOLEAN
			-- Does the current set contain a formal type?
			--| A generic (GEN_TYPE_A) which has a formal type parameter is not counted.
		do
			Result := across types as l_renamed_type some l_renamed_type.item.type.is_formal end
		end

	has_deferred: BOOLEAN
			-- Does the current set contain a deferred class?
		do
			Result := across types as l_renamed_type some l_renamed_type.item.has_associated_class and then l_renamed_type.item.base_class.is_deferred end
		end

	is_attached: BOOLEAN
			-- <Precursor>
		do
			Result := across types as l_renamed_type some l_renamed_type.item.type.is_attached end
		end

	is_expanded: BOOLEAN
			-- Is the current actual type an expanded one ?
		do
			Result := across types as l_renamed_type all l_renamed_type.item.type.is_expanded end
		end

	frozen is_valid: BOOLEAN
			-- Is current a valid declaration by itself?
		do
			Result := across types as l_renamed_type all l_renamed_type.item.type.is_valid end
		ensure
			true_implication: is_valid implies is_class_valid
			false_implication: not is_class_valid implies not is_valid
		end

	frozen is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- Is current valid for a declaration in `a_class'?
		require
			a_class_not_void: a_class /= Void
			a_class_valid: a_class.is_valid
		do
			Result := across types as l_renamed_type all l_renamed_type.item.type.is_valid_for_class (a_class) end
		end

feature -- Access

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

						-- We have to get rid of all formals occurring somewhere (be it a generic type or a typeset)				
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
								Result.types.append (l_formal_type.constraints (a_context_class).constraining_types  (a_context_class).types)
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
					Result.extend (create {RENAMED_TYPE_A}.make (create {CL_TYPE_A}.make (system.any_id), Void))
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

						-- We have to get rid of all formals occurring somewhere (be it a generic type or a typeset)				
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
								Result.types.append (l_formal_type.constraints_if_possible (a_context_class).constraining_types_if_possible  (a_context_class).types)
									-- Pop the current item
								formal_resolution_stack.remove
							end
					end
					forth
				end
				if Result.is_empty and formal_resolution_stack.is_empty then
						-- if formal_resolution_stack.is_empty we are at the end of computation.
					Result.extend (create {RENAMED_TYPE_A}.make (create {CL_TYPE_A}.make (system.any_id), Void))
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

feature -- Attachment and separateness properties

	to_other_attachment (other: TYPE_A): like Current
			-- Current type to which attachment status of `other' is applied
		local
			i: INTEGER
			r: RENAMED_TYPE_A
			t: TYPE_A
			a: TYPE_A
		do
			Result := Current
			from
				i := count
			until
				i <= 0
			loop
				r := types.i_th (i)
				t := r.type
				a := t.to_other_attachment (other)
				if a /= t then
						-- The type is different from what we have in the current one.
					r := r.twin
					r.set_type (a)
					if Result = Current then
							-- Avoid changing current type descriptor.
						Result := twin
					end
					Result.types.put_i_th (r, i)
				end
				i := i - 1
			end
		end

	to_other_separateness (other: TYPE_A): like Current
			-- Current type to which separateness status of `other' is applied.
		local
			i: INTEGER
			r: RENAMED_TYPE_A
			t: TYPE_A
			a: TYPE_A
		do
			Result := Current
			from
				i := count
			until
				i <= 0
			loop
				r := types.i_th (i)
				t := r.type
				a := t.to_other_separateness (other)
				if a /= t then
						-- The type is different from what we have in the current one.
					r := r.twin
					r.set_type (a)
					if Result = Current then
							-- Avoid changing current type descriptor.
						Result := twin
					end
					Result.types.put_i_th (r, i)
				end
				i := i - 1
			end
		end

	to_other_variant (other: TYPE_A): like Current
			-- Current type to which separateness status of `other' is applied.
		local
			i: INTEGER
			r: RENAMED_TYPE_A
			t: TYPE_A
			a: TYPE_A
		do
			Result := Current
			from
				i := count
			until
				i <= 0
			loop
				r := types.i_th (i)
				t := r.type
				a := t.to_other_variant (other)
				if a /= t then
						-- The type is different from what we have in the current one.
					r := r.twin
					r.set_type (a)
					if Result = Current then
							-- Avoid changing current type descriptor.
						Result := twin
					end
					Result.types.put_i_th (r, i)
				end
				i := i - 1
			end
		end

feature {NONE} -- Implementation

	formal_resolution_stack: ARRAYED_STACK [INTEGER]
			-- A stack which is used to prohibit inifinite recursion while resolving a formal type to its constraining type set.
		once
			create Result.make (3)
		end

feature -- Convenience to be removed later

	types: ARRAYED_LIST [RENAMED_TYPE_A]

	renamed_types: ARRAYED_LIST [TYPE_A]
		do
			create Result.make (types.count)
			across types as l_renamed_type loop
				Result.extend (l_renamed_type.item.type)
			end
		end
	count: INTEGER
		do
			Result := types.count
		end

	start
		do
			types.start
		end

	after: BOOLEAN
		do
			Result := types.after
		end

	forth
		do
			types.forth
		end

	item: RENAMED_TYPE_A
		do
			Result := types.item
		end

	extend (v: like item)
		do
			types.extend (v)
		end

	is_empty: BOOLEAN
		do
			Result := types.is_empty
		end

	first: like item
		do
			Result := types.first
		end

	wipe_out
		do
			types.wipe_out
		end

	i_th (i: INTEGER): like item
		do
			Result := types.i_th (i)
		end

	put_i_th (v: like item; i: INTEGER)
		do
			types.put_i_th (v, i)
		end

	remove
		do
			types.remove
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

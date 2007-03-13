indexing
	description: "Objects that ..."
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
			has_expanded,
			has_formal_generic,
			instantiation_in,
			is_loose,
			is_valid
		end

	ARRAYED_LIST[EXTENDED_TYPE_A]
	rename
		duplicate as list_duplicate
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

--	SHARED_AST_CONTEXT
--		export
--			{NONE} all
--		undefine
--			is_equal, copy
--		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			is_equal, copy
		end



create
	make, make_filled, make_from_array

feature -- Commands

	merge (a_other_type_set: like Current) is
			-- Merge `a_other_type_set' into current.
		do
			merge_right (a_other_type_set)
		end

feature -- Access

	instantiation_in (a_type: TYPE_A; a_written_id: INTEGER_32): TYPE_A
			--
		local
			l_instantiated_type: TYPE_A
		do
			from
				start
			until
				after
			loop
				l_instantiated_type := item.type.instantiation_in (a_type, a_written_id)
				if l_instantiated_type /= Void then
					item.set_type (l_instantiated_type)
				end
				forth
			end
		end

	feature_i_state (a_name: ID_AS): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A;  features_found_count: INTEGER]  is
			-- Compute feature state.
			--
			-- `a_name' is the id of the feature.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			a_name_not_void: a_name /= Void
		do
			Result := feature_i_state_by_name_id (a_name.name_id)
		ensure
			result_not_void: Result /= Void
		end

	feature_i_state_by_name_id (a_name_id: INTEGER): TUPLE [feature_item: FEATURE_I; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]  is
			-- Compute feature state.
			--
			-- `a_name_id' is the `names_heap'-id of the feature name string.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_last_feature, l_feature: FEATURE_I
			l_last_class_type: CL_TYPE_A
			l_features_found_count: INTEGER
			l_renaming: RENAMING_A
			l_constraint_position: INTEGER
			l_feature_table: FEATURE_TABLE
			l_item: TYPE_A
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
				if l_item.has_associated_class then
					l_feature_table := l_item.associated_class.feature_table
					if l_renaming /= Void then
						l_feature_table.search_id_under_renaming (a_name_id, l_renaming)
					else
						l_feature_table.search_id (a_name_id)
					end

					l_feature :=  l_feature_table.found_item

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
				-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantik_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantik_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
		end

	feature_i_state_by_alias (an_alias: STRING): TUPLE [feature_item: FEATURE_I; class_of_feature: CLASS_C; features_found_count: INTEGER;  constraint_position: INTEGER]  is
			-- Compute feature state.
			--
			-- `an_alias' is a feature alias for which the state is computed.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			an_alias_not_void: an_alias /= Void
		local
			l_last_feature, l_feature: FEATURE_I
			l_class_c, l_last_class: CLASS_C
			l_constraint_position: INTEGER
					-- The Position at which the constraint where the feature was selected from is written.
			l_features_found_count: INTEGER
			l_item: TYPE_A
		do
			from
				start
			until
				after
			loop
				l_item := item
				if l_item.has_associated_class then
					l_class_c := l_item.associated_class
					l_feature :=  l_class_c.feature_table.alias_item (an_alias)
					if
						l_feature /= Void
					then
						l_constraint_position := cursor.index
						l_last_feature  :=  l_feature
						l_last_class := l_class_c
						l_features_found_count := l_features_found_count + 1
					end
				end
				forth
			end
			if l_features_found_count  >  1  then
				l_last_feature := Void
				l_last_class := Void
			end
			Result := [l_last_feature, l_last_class, l_features_found_count, l_constraint_position]
		ensure
			-- It basically states that if there is exactly one feature you get the result, otherwise feature_item and class_of_feature are void.
			result_not_void: Result /= Void
			result_semantik_correct: Result.feature_item = Void implies (Result.class_of_feature = Void and Result.features_found_count /= 1)
			result_semantik_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_of_feature = Void)
		end

	e_feature_state (a_name: ID_AS): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A;  features_found_count: INTEGER]  is
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
		end

	e_feature_state_by_name_id (a_name_id: INTEGER): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]  is
			-- Compute feature state.	
			--
			-- `a_name_id' is the `names_heap'-id of the feature name string.
			-- Returns `feature_item' void if the feature cannot be found in the type set.
			-- If there are multiple features found use `features_found_count' from the result tuple to find out how many.
			-- Use features from the family `info_about_feature*' to get detailed information.
		require
			not_has_formal: not has_formal
		local
			l_item: TYPE_A
			l_last_feature: E_FEATURE
			l_feature: FEATURE_I
			l_last_class_type: CL_TYPE_A
			l_class_c: CLASS_C
			l_features_found_count: INTEGER
			l_renaming: RENAMING_A
			l_constraint_position: INTEGER
			l_feature_table: FEATURE_TABLE
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
						l_constraint_position := cursor.index
						l_last_feature  :=  l_feature.api_feature (l_class_c.class_id)
						l_last_class_type ?= item.type
							-- This check is guaranteed by the precondition.
						check l_last_class_type_not_void: l_last_class_type /= Void end
						l_features_found_count := l_features_found_count + 1
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
			result_semantik_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantik_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
		end

	e_feature_state_by_id (a_routine_id: INTEGER): TUPLE [feature_item: E_FEATURE; class_type_of_feature: CL_TYPE_A; features_found_count: INTEGER; constraint_position: INTEGER]  is
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
			result_semantik_correct: Result.feature_item = Void implies (Result.class_type_of_feature = Void and Result.features_found_count /= 1)
			result_semantik_correct: Result.features_found_count > 1  implies (Result.feature_item = Void and Result.class_type_of_feature = Void)
		end

		associated_classes: LIST[CLASS_C]
				-- All associated classes of the current type set.
			do
				create {LINKED_LIST[CLASS_C]} Result.make
				do_all (agent (a_class_list: LIST[CLASS_C]; a_type: EXTENDED_TYPE_A)
							do
								if a_type.has_associated_class then
									a_class_list.extend (a_type.associated_class)
								end
							end (Result, ?))
			end

feature -- Access for Error handling

	info_about_feature (a_id: ID_AS; a_formal_position: INTEGER; a_context_class: CLASS_C): MC_ERROR_REPORT is
			-- Gathers information  about a feature.
			--
			-- `a_id' is the ID for the feature for which information is gatherd.
		require
			a_id_not_void: a_id /= Void
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		do
			Result := info_about_feature_by_name_id (a_id.name_id, a_formal_position, a_context_class)
		end

	info_about_feature_by_name_id (a_name_id: INTEGER; a_formal_position: INTEGER; a_context_class: CLASS_C): like info_about_feature
			-- Gathers information  about a feature.
			--
			-- `a_name_id' is the name ID of the feature for which information is gatherd.
			-- `a_formal_position' position of the formal to which this typeset belongs.
			-- `a_context_class' is the class where the formal (denoted by `a_formal_position') has been defined.
		require
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION [ANY, TUPLE [EXTENDED_TYPE_A], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_name_id: INTEGER; a_ext_type: EXTENDED_TYPE_A): TUPLE [E_FEATURE,FEATURE_I]
					local
						l_renamed_id: INTEGER
						l_class: CLASS_C
						l_renaming: RENAMING_A
					do
						if a_ext_type.has_associated_class then
							l_class := a_ext_type.associated_class
							if l_class.has_feature_table then
								if a_ext_type.has_renaming then
										-- After this call l_renamed_id can be -1!
									l_renamed_id := a_ext_type.renaming.renamed (g_name_id)
								else
									l_renamed_id := g_name_id
								end
								Result := [	l_class.feature_with_name_id (l_renamed_id),
											l_class.feature_of_name_id (l_renamed_id)]
							end
						end
					end (a_name_id, ?)
			Result := info_about_feature_by_agent (l_feature_agent, a_formal_position, a_context_class, create {SEARCH_TABLE [INTEGER]}.make (3))
			Result.set_data (names_heap.item (a_name_id), a_formal_position, a_context_class)
		end

	info_about_feature_by_id (a_routine_id: INTEGER; a_formal_position: INTEGER;  a_context_class: CLASS_C): like info_about_feature
			-- Gathers information about a feature.
			--
			-- `a_routine_id' is the ID for the feature for which information is gatherd.
		require
			a_context_class_not_void_if_needed: has_formal implies a_context_class /= Void
		local
			l_feature_agent: FUNCTION[ANY,TUPLE [EXTENDED_TYPE_A], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]
		do
			l_feature_agent :=
				agent (g_routine_id: INTEGER; l_ext_type: EXTENDED_TYPE_A): TUPLE [E_FEATURE,FEATURE_I]
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
							end
						end
					end (a_routine_id, ?)
			Result := info_about_feature_by_agent (l_feature_agent, a_formal_position, a_context_class, create {SEARCH_TABLE [INTEGER]}.make (3))
			Result.set_data (Void, a_formal_position, a_context_class)
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

	info_about_feature_by_agent (a_feature: FUNCTION [ANY, TUPLE [EXTENDED_TYPE_A], TUPLE [e_feature: E_FEATURE; feature_i: FEATURE_I]]; a_formal_position: INTEGER; a_context_class: CLASS_C; a_visited_formals: SEARCH_TABLE [INTEGER]): like info_about_feature_by_id
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
			l_item: EXTENDED_TYPE_A
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
							-- Check whether we found at least something yousfull and then insert an entry.
						if l_query_result /= Void and then (l_query_result.e_feature /= Void or l_query_result.feature_i /= Void) then
							l_constraint_position := cursor.index
							Result.extend([l_query_result.feature_i, l_query_result.e_feature, l_item, a_formal_position, l_constraint_position])
						end
					end
				end
				forth
			end
		end

feature -- Comparison

	conform_to (a_other: like Current): BOOLEAN is
			-- Is `Current' conform to `a_other'?
			-- `a_other' will be modified. Elements will be removed.
			-- So pass a copy if you still need it after this call.
		require
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
					if item.type.conform_to (a_other.item.type) then
						a_other.remove
					end
					if not a_other.after then
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

	conform_to_type (a_type: TYPE_A): BOOLEAN is
			-- Is `Current' conform to `a_type'?
		do
			-- If at least one element of `Current' conforms to `a_type' then the type set conforms to the type.
			Result := False
			from
				start
			until
				after or Result
			loop
				Result := item.type.conform_to (a_type)
				last_type_checked := item
				forth
			end
		end

	is_conforming_type (a_type: TYPE_A): BOOLEAN is
			-- Conforms `a_type' to the type set?
		do
			-- If `a_type' is not conform to at least one element of the type set then `a_type' is not conform to the type set.
			Result := True
			from
				start
			until
				after or not Result
			loop
				Result := a_type.conform_to (item.type)
				last_type_checked := item
				forth
			end
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object?
		local
			s1,s2: like Current
		do
			create s1.make (count)
			s1.copy (Current)
			create s2.make (other.count)
			s2.copy (other)

		end

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER; c: CLASS_C) is
			-- Append `Current' to `text'.
			-- `f' is used to retreive the generic type or argument name as string.	
			-- MTNASK: f? why not a class... why a feature?	(only LIKE_ARGUMENT uses f really... what to do?)
			-- MTN Other solution: Use append_to if not possible ext can handle void...
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

	dump: STRING is
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

feature -- Status

	has_expanded: BOOLEAN is
			-- Does the current type set contain the NONE type?
		do
			Result := there_exists (agent(a_extended_type: EXTENDED_TYPE_A): BOOLEAN
						do
							Result := a_extended_type.type.is_expanded
						end)
		end

	has_none: BOOLEAN is
			-- Does the current type set contain the NONE type?
		do
			Result := there_exists (agent(a_extended_type: EXTENDED_TYPE_A): BOOLEAN
						do
							Result := a_extended_type.type.is_none
						end)
		end


	has_void: BOOLEAN is
			-- Does the current type set contain the NONE type?
		do
			Result := there_exists (agent(a_extended_type: EXTENDED_TYPE_A): BOOLEAN
						do
							Result := a_extended_type.type.is_void
						end)
		end

	has_overloaded (a_feature_name_id: INTEGER): BOOLEAN is
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

	has_renamings: BOOLEAN is
			-- Has the `current' any renamings?
		do
			Result := there_exists (agent(a_extended_type: EXTENDED_TYPE_A): BOOLEAN
						do
							Result := a_extended_type.type.has_renaming
						end)
		end

	has_formal_generic: BOOLEAN is
			-- Has current type set any formal genrics?
		do
			Result := there_exists (agent(a_extended_type: EXTENDED_TYPE_A): BOOLEAN
						do
							Result := a_extended_type.type.has_formal_generic
						end)
		end


	is_valid: BOOLEAN is
			-- Is the type set valid, meaning that all items are valid items?
		do
			Result := for_all (agent (a_item: EXTENDED_TYPE_A): BOOLEAN
						do
							Result := a_item.type.is_valid
						end)
		end

	is_loose: BOOLEAN is
			-- Is at least one of the types om the type set a loose type (`is_loose')?
		do
			Result := there_exists (agent (a_item: EXTENDED_TYPE_A): BOOLEAN
						 do
						 	Result := a_item.type.is_loose
						 end)
		end

	has_formal: BOOLEAN is
			-- Does the current set contain a formal type?
			--| A generic (GEN_TYPE_A) which has a formal type parameter is not counted.
		do
			Result := there_exists (agent (a_item: EXTENDED_TYPE_A): BOOLEAN
						 do
						 	Result := a_item.type.is_formal
						 end)
		end

	has_deferred: BOOLEAN is
			-- Does the current set contain a deferred class?
		do
			Result := there_exists (agent (a_item: EXTENDED_TYPE_A): BOOLEAN
						 do
						 	Result := a_item.associated_class.is_deferred
						 end)
		end

feature -- Setters

feature -- Access

	expanded_representative: EXTENDED_TYPE_A is
			-- Expanded item is returned.
			--| Such a case can be treated like a normal type because there's no other class which can satisfy the constraint but the expanded itself.
			--| If you write code like G-> {COMPARABLE,INTEGER_REF,INTEGER} (which is non-sense)
			--| this code would return INTEGER.
			--| If you write something like G->{DOUBLE,INTEGER} this code will return whatever it finds first.
			--| This error will be caught by the trial of a generic derivation, because no class can satisfy the constraint.
		require
			has_expanded: has_expanded
		local
			l_extended_type: EXTENDED_TYPE_A
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
				l_extended_type := item
				if l_extended_type.type.is_expanded	then
					Result := l_extended_type
				end
				forth
			end
		ensure
			result_not_void: Result /= Void
			result_is_expaned: Result.type.is_expanded
		end


	associated_class: CLASS_C is
			-- Class associated to the current type.
		do
				-- We are not able to return a CLASS_C object so easily.
				-- One could maybe introduce something like that which would enable more transparency at some places (like providing a merged feature table of all types in the typeset).
				-- For now it is a dead feature.
			check false end

		end



	constraining_types (a_context_class: CLASS_C): TYPE_SET_A is
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
					Result.extend (create {EXTENDED_TYPE_A}.make (create {CL_TYPE_A}.make (system.any_id), Void))
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

	constraining_types_if_possible (a_context_class: CLASS_C): TYPE_SET_A is
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
								Result.merge (l_formal_type.constraints_if_possible (a_context_class).constraining_types_if_possible  (a_context_class))
									-- Pop the current item
								formal_resolution_stack.remove
							end
					end
					forth
				end
				if Result.is_empty and formal_resolution_stack.is_empty then
						-- if formal_resolution_stack.is_empty we are at the end of computation.
					Result.extend (create {EXTENDED_TYPE_A}.make (create {CL_TYPE_A}.make (system.any_id), Void))
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


	overloaded_items (an_id: INTEGER): LIST [FEATURE_I] is
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

	last_type_checked: EXTENDED_TYPE_A
		-- Last type checked.
		-- Use this feature for error reporting.

feature {COMPILER_EXPORTER} -- Access

	type_i: TYPE_I is
			-- C type
		do
				-- TYPE_SET_A does not support this feature.
			check false end
		end

	create_info: CREATE_FORMAL_TYPE is
			-- Create formal type info.
		do
				-- TYPE_SET_A does not support this feature.
			check false end
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
				-- Martins 12/19/06: Right now it would most likely be a bug if we arrive here.
			check false end
		end

feature {NONE} -- Implementation


	formal_resolution_stack: STACK[INTEGER] is
			-- A stack which is used to prohibit inifinite recursion while resolving a formal type to its constraining type set.
		once
			create {ARRAYED_STACK[INTEGER]} Result.make (3)
		end

end

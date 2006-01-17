indexing
	description: "Initialize and check validity of convert clauses in instances of CLASS_C."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	FIXME: "Because the validity rules are not yet completely specified, I'm just generating %
		%errors of type VNCP with a simple error message. When they will be specified, the %
		%code will have to be updated and adjusted accordingly."
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERTIBILITY_CHECKER

inherit
	COMPILER_EXPORTER

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	KL_EQUALITY_TESTER [NAMED_TYPE_A]
		export
			{NONE} all
		redefine
			test
		end

feature -- Initialization/Checking

	init_and_check_convert_tables (
			a_class: CLASS_C;
			a_feat_tbl: FEATURE_TABLE;
			a_convertors: EIFFEL_LIST [CONVERT_FEAT_AS])
		is
			-- Initialize `convert_to' and `convert_from' of `a_class' using `a_convertors'.
			-- Performs also basic checking on `a_convertors'.
			-- Update `Error_handler' if any error is found.
		require
			a_class_not_void: a_class /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
			matching_class_and_feat_tbl: a_class = a_feat_tbl.associated_class
		local
			l_feat: CONVERT_FEAT_AS
			l_type: TYPE_AS
			l_named_type: NAMED_TYPE_A
			l_convert_to, l_convert_from: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A]
			l_name_id: INTEGER
			l_processed: SEARCH_TABLE [INTEGER]
			l_vtug: VTUG
			l_vncp: VNCP
		do
				-- Reset error flag
			has_error := False

			if a_convertors /= Void then
					-- Check it is valid to have a convert clause in Current.
				check_class_validity (a_class)

					-- Check convert clause content and initialize `a_class'.
					-- We simply iterate through all conversion feature mentionned
					-- and check their type, we stop checking as soon as an error is found.
				from
					l_convert_to := new_convert_table
					l_convert_from := new_convert_table
					create l_processed.make (10)
					a_convertors.start
				until
					a_convertors.after or has_error
				loop
					l_feat := a_convertors.item
					l_name_id := l_feat.feature_name.internal_name_id
					if l_processed.has (l_name_id) then
							-- Routine specified twice in Convert_clause.
						create l_vncp.make ("Routine specified twice in Convert_clause.")
						l_vncp.set_class (a_class)
						l_vncp.set_location (l_feat.feature_name.start_location)
						Error_handler.insert_error (l_vncp)
						has_error := True
					else
							-- Mark current routine processed.
						l_processed.put (l_name_id)

							-- Check `l_feat' to ensure it is a valid feature from current
							-- class with a correct signature for a conversion routine.
						check_feature_basic_validity (a_class, a_feat_tbl, l_feat)

						if not has_error then
								-- Iterate through all specified type to ensure their correctness
								-- and that they match conversion routines specification.
							from
								l_feat.conversion_types.start
							until
								l_feat.conversion_types.after or has_error
							loop
								l_type := l_feat.conversion_types.item
								l_named_type ?= l_type.actual_type
								if
									l_named_type = Void or else
									not l_named_type.is_full_named_type
								then
										-- Not a valid type.
									create l_vncp.make ("Invalid type: use of anchors.")
									l_vncp.set_class (a_class)
									l_vncp.set_location (l_feat.conversion_types.item.start_location)
									Error_handler.insert_error (l_vncp)
									has_error := True
								else
										-- Check type has valid generics.
									if not l_named_type.good_generics then
											-- Wrong number of geneneric parameters in parent
										l_vtug := l_named_type.error_generics
										l_vtug.set_class (a_class)
										l_vtug.set_location (l_feat.conversion_types.item.start_location)
										Error_handler.insert_error (l_vtug)
										has_error := True
									else
											-- Check constrained genericity validity rule
										l_named_type.reset_constraint_error_list
										l_named_type.check_constraints (a_class)
										if not l_named_type.constraint_error_list.is_empty then
											create l_vncp.make ("Invalid generic type.")
											l_vncp.set_class (a_class)
											l_vncp.set_location (l_feat.conversion_types.item.start_location)
											Error_handler.insert_error (l_vncp)
											has_error := True
										else
											l_named_type.check_for_obsolete_class (a_class)

												-- Check that specified routine argument or return
												-- type matches conversion type `l_named_type'.
											check_conversion_type (a_class, a_feat_tbl, l_feat,
												l_named_type)
											if not has_error then
												if l_feat.is_creation_procedure then
													if l_convert_from.has (l_named_type) then
														create l_vncp.make
															("Conversion type already specified.")
														l_vncp.set_class (a_class)
														l_vncp.set_location (l_feat.conversion_types.item.start_location)
														Error_handler.insert_error (l_vncp)
														has_error := True
													else
														l_convert_from.force (l_name_id, l_named_type)
													end
												else
													if l_convert_to.has (l_named_type) then
														create l_vncp.make
															("Conversion type already specified.")
														l_vncp.set_class (a_class)
														l_vncp.set_location (l_feat.conversion_types.item.start_location)
														Error_handler.insert_error (l_vncp)
														has_error := True
													else
														l_convert_to.force (l_name_id, l_named_type)
													end
												end
											end
										end
									end
								end
								l_feat.conversion_types.forth
							end
						end
					end
					a_convertors.forth
				end
			end
			if not has_error then
				a_class.set_convert_to (l_convert_to)
				a_class.set_convert_from (l_convert_from)
			end
		ensure
			set: (not has_error and a_convertors /= Void) implies
				(a_class.convert_to /= Void or a_class.convert_from /= Void)
		end

	system_validity_checking (an_array: ARRAY [CLASS_C]) is
			-- Check convertibility validity on all system. That is to say, check
			-- that there is only one way to convert from a type to another type.
			-- Note: Check is done on base class. Is this sufficient?
		require
			an_array_not_void: an_array /= Void
		local
			i, k, nb: INTEGER
			l_convertible_classes: ARRAYED_LIST [CLASS_C]
			l_class, l_other_class: CLASS_C
			l_vncp: VNCP
		do
				-- Reset error flag
			has_error := False

				-- First extract classes that have a convert clause.
			from
				i := an_array.lower
				nb := an_array.upper
				create l_convertible_classes.make (30)
			until
				i > nb
			loop
				l_class := an_array.item (i)
				if
					l_class /= Void and then
					(l_class.convert_from /= Void or l_class.convert_to /= Void)
				then
					l_convertible_classes.extend (l_class)
				end
				i := i + 1
			end

				-- Now check all convertible classes between themself to ensure that
				-- between two classes, there is no ambiguity when trying to convert from one
				-- to the other.
			from
				i := 1
				nb := l_convertible_classes.count
			until
				i > nb
			loop
				l_class := l_convertible_classes.i_th (i)
				from
					k := i + 1
				until
					k > nb
				loop
					l_other_class := l_convertible_classes.i_th (k)
					if
						is_conversion_ambiguous (l_class, l_other_class) or
						is_conversion_ambiguous (l_other_class, l_class)
					then
						create l_vncp.make ("Two classes convert to each other.")
						l_vncp.set_class (l_class)
						Error_handler.insert_error (l_vncp)
						has_error := True
					end
					k := k + 1
				end
				i := i + 1
			end
		end

	check_conversion (a_context_class: CLASS_C; a_source_type, a_target_type: TYPE_A) is
			-- In context of `a_context_class' check if `a_source_type' converts to `a_target_type'.
			-- If so set `last_conversion_check_successful' to True and set `last_conversion_info'
			-- with proper conversion information.
		require
			a_context_class_not_void: a_context_class /= Void
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
		local
			l_success: BOOLEAN
			l_source_class, l_target_class: CLASS_C
			l_convert_table: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A]
			l_conversion_type: TYPE_A
			l_feat_name_id: INTEGER
			l_feat: FEATURE_I
			l_cl_type: CL_TYPE_A
		do
				-- Reset previous computation
			last_conversion_check_successful := False
			last_conversion_info := Void

			l_target_class := a_target_type.associated_class
			if l_target_class /= Void then
				l_convert_table := l_target_class.convert_from
			end
			if l_convert_table /= Void then
				from
					l_cl_type ?= a_target_type
					l_convert_table.start
				until
					l_convert_table.after or l_success
				loop
					l_conversion_type := l_convert_table.key_for_iteration
						-- Evaluate conversion type in context of `a_target_type'. This is needed
						-- in the following case:
						-- class A [G] convert make_from ({G}) ... end
						-- a: A [X]
						-- x: X
						-- a := x
						-- Instantiating `G' in context of `A [X]' will give us `X'
						-- enabling us to convert from `X'.
					if l_cl_type /= Void then
						l_conversion_type := l_conversion_type.instantiated_in (l_cl_type)
					end
					l_success := a_source_type.same_as (l_conversion_type)
					if l_success then
						l_feat_name_id := l_convert_table.item_for_iteration
					end
					l_convert_table.forth
				end
				if l_success then
					l_feat := l_target_class.feature_table.item_id (l_feat_name_id)
					check
						l_feat_not_void: l_feat /= Void
						has_creation_procedures: l_target_class.creators /= Void
						has_convert_creation_procedure:
							l_target_class.creators.has (l_feat.feature_name)
					end
					l_success := l_target_class.creators.item (l_feat.feature_name).valid_for (
						a_context_class)
					if l_success then
						create {FEATURE_CONVERSION_INFO} last_conversion_info.
							make_from (a_source_type, a_target_type, l_target_class, l_feat)
					end
				end
			end
			if not l_success then
				l_source_class := a_source_type.associated_class
				if l_source_class /= Void then
					l_convert_table := l_source_class.convert_to
				end
				if l_convert_table /= Void then
					from
						l_cl_type ?= a_source_type
						l_convert_table.start
					until
						l_convert_table.after or l_success
					loop
						l_conversion_type := l_convert_table.key_for_iteration
							-- Evaluate conversion type in context of `a_target_type'. This is needed
							-- in the following case:
							-- class A [G] convert to_formal: {G} ... end
							-- a: A [X]
							-- x: X
							-- x := a
							-- Instantiating `G' in context of `A [X]' will give us `X'
							-- enabling us to convert from `X'.
						if l_cl_type /= Void then
							l_conversion_type := l_conversion_type.instantiated_in (l_cl_type)
						end
						l_success := a_target_type.same_as (l_conversion_type)
						if l_success then
							l_feat_name_id := l_convert_table.item_for_iteration
						end
						l_convert_table.forth
					end
					if l_success then
						l_feat := l_source_class.feature_table.item_id (l_feat_name_id)
						check
							l_feat_not_void: l_feat /= Void
						end
						l_success := l_feat.is_exported_for (a_context_class)
						if l_success then
							create {FEATURE_CONVERSION_INFO} last_conversion_info.
								make_to (a_source_type, a_target_type, l_source_class, l_feat)
						end
					end
				end
			end
			last_conversion_check_successful := l_success
		end

	check_formal_conversion (a_context_class: CLASS_C; a_formal: FORMAL_A; a_target_type: TYPE_A) is
			-- In context of `a_context_class' check if `a_formal' converts to `a_target_type'.
			-- If so set `last_conversion_check_successful' to True and set `last_conversion_info'
			-- with proper conversion information.
		require
			a_context_class_not_void: a_context_class /= Void
			context_class_has_generics: a_context_class.generics /= Void
			a_formal_not_void: a_formal /= Void
			valid_context_class: a_context_class.generics.count >= a_formal.position
			a_target_type_not_void: a_target_type /= Void
		local
			l_success: BOOLEAN
			l_other: FORMAL_A
			l_constraint: TYPE_A
			l_cl_type: CL_TYPE_A
		do
			l_other ?= a_target_type
			if l_other = Void then
				l_constraint := a_context_class.constraint (a_formal.position)
				if l_constraint.conform_to (a_target_type) then
						-- Constraint conform to target, we allow conversion.
						-- It is a conversion and not a plain conformance because in case where
						-- the formal generic is expanded it becomes a conversion.
					create {FORMAL_CONVERSION_INFO} last_conversion_info.make (a_formal, a_target_type)
					l_success := True
				elseif System.il_generation then
					l_cl_type ?= a_target_type
					if l_cl_type /= Void and then l_cl_type.is_system_object_or_any then
							-- Reattachement of a formal to SYSTEM_OBJECT/ANY, we allow this.
						create {FORMAL_DOTNET_CONVERSION_INFO} last_conversion_info.make (a_formal, a_target_type)
						l_success := True
					end
				end
			end
			last_conversion_check_successful := l_success
		end

feature -- Status report

	last_conversion_check_successful: BOOLEAN
			-- Was last call to `check_conversion' or `check_formal_conversion' successful?

	last_conversion_info: CONVERSION_INFO
			-- Information about last successful conversion checking

feature {NONE} -- Implementation: initialization

	new_convert_table: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A] is
			-- Create new instance used to initialize `convert_to' or `convert_from' of CLASS_C
			-- where equality on keys is done using `same_as' from NAMED_TYPE_A.
		do
			create Result.make (10)
				-- Compare keys using `same_as'.
			Result.set_key_equality_tester (Current)
		ensure
			new_convert_table_not_void: Result /= Void
		end

feature {NONE} -- Implementation: checking

	check_class_validity (a_class: CLASS_C) is
			-- Check that `a_class' can have a convert clause.
		require
			a_class_not_void: a_class /= Void
		do
			-- No checking. A convert clause can appear in a deferred class.
		end

	check_feature_basic_validity (
			a_class: CLASS_C;
			a_feat_tbl: FEATURE_TABLE;
			a_convert_feat: CONVERT_FEAT_AS)
		is
			-- Check validity of feature represented by `a_convert_feat' in `a_feat_tbl'.
			-- Update `Error_handler' if any error is found.
		require
			a_class_not_void: a_class /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
			matching_class_and_feat_tbl: a_class = a_feat_tbl.associated_class
			a_convert_feat_not_void: a_convert_feat /= Void
		local
			l_feat: FEATURE_I
			l_vncp: VNCP
		do
			a_feat_tbl.search_id (a_convert_feat.feature_name.internal_name_id)
			if a_feat_tbl.found then
				l_feat := a_feat_tbl.found_item
				if l_feat.is_routine and (not l_feat.is_once or not l_feat.is_external) then
					if a_convert_feat.is_creation_procedure then
							-- Check it is listed as part of creation procedures of current class.
						if
							a_class.creators = Void or else
							not a_class.creators.has (a_convert_feat.feature_name.internal_name)
						then
								-- Not a creation procedure.
							create l_vncp.make ("Not a creation procedure.")
							l_vncp.set_class (a_class)
							l_vncp.set_location (a_convert_feat.feature_name.start_location)
							Error_handler.insert_error (l_vncp)
							has_error := True
						else
								-- Check it only has one argument
							if l_feat.argument_count /= 1 then
									-- Not a valid creation procedure (too many or not enough
									-- arguments)
								create l_vncp.make ("Not just 1 argument.")
								l_vncp.set_class (a_class)
								l_vncp.set_location (a_convert_feat.feature_name.start_location)
								Error_handler.insert_error (l_vncp)
								has_error := True
							end
						end
					else
						if not l_feat.is_function or l_feat.argument_count /= 0 then
								-- Not a function without argument
							create l_vncp.make ("Not a function without argument.")
							l_vncp.set_class (a_class)
							l_vncp.set_location (a_convert_feat.feature_name.start_location)
							Error_handler.insert_error (l_vncp)
							has_error := True
						end
					end
				else
						-- Feature is not an Eiffel routine
					create l_vncp.make ("Should be a routine, not a once nor an external.")
					l_vncp.set_class (a_class)
					l_vncp.set_location (a_convert_feat.feature_name.start_location)
					Error_handler.insert_error (l_vncp)
					has_error := True
				end
			else
				create l_vncp.make ("Routine not found: " +
					a_convert_feat.feature_name.internal_name)
				l_vncp.set_class (a_class)
				l_vncp.set_location (a_convert_feat.feature_name.start_location)
				Error_handler.insert_error (l_vncp)
				has_error := True
			end
		end

	check_conversion_type (
			a_class: CLASS_C;
			a_feat_tbl: FEATURE_TABLE;
			a_convert_feat: CONVERT_FEAT_AS;
			a_type: NAMED_TYPE_A)
		is
			-- Check validity of `a_type' used to convert to or from using `a_convert_feat' routine
			-- so that it matches routine specified in `a_convert_feat', and that `a_type' does not
			-- conform to `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feat_tbl_not_void: a_feat_tbl /= Void
			matching_class_and_feat_tbl: a_class = a_feat_tbl.associated_class
			a_convert_feat_not_void: a_convert_feat /= Void
			a_type_not_void: a_type /= Void
			has_routine: a_feat_tbl.has_id (a_convert_feat.feature_name.internal_name_id)
			routine_valid:
				valid_signature (a_feat_tbl.item_id (a_convert_feat.feature_name.internal_name_id))
		local
			l_feat: FEATURE_I
			l_vncp: VNCP
		do
				-- Check conformance of `a_type' to signature of routine specified in
				-- `a_convert_feat'.
			l_feat := a_feat_tbl.item_id (a_convert_feat.feature_name.internal_name_id)
				-- FIXME: Manu 04/28/2003: we do not do yet apply convertibility to check
				-- for conversion type validity, only conformance
			if l_feat.is_function then
				if not l_feat.type.actual_type.conform_to (a_type) then
					create l_vncp.make ("Return type does not conform to SOURCE.")
					l_vncp.set_class (a_class)
					l_vncp.set_location (a_convert_feat.feature_name.start_location)
					Error_handler.insert_error (l_vncp)
					has_error := True
				end
			else
				if not a_type.conform_to (l_feat.arguments.i_th (1).actual_type) then
					create l_vncp.make ("SOURCE does not conform to argument type.")
					l_vncp.set_class (a_class)
					l_vncp.set_location (a_convert_feat.feature_name.start_location)
					Error_handler.insert_error (l_vncp)
					has_error := True
				end
			end

-- FIXME: Manu: 01/22/2004: If we say that we always take conformance over convertibility
-- then we do not need this test
--				-- Check non-conformance of `a_type' to `a_class'.
--			if
--				not has_error and then
--				a_type.conform_to (a_class.constraint_actual_type)
--			then
--				create l_vncp.make ("SOURCE conforms to current class.")
--				l_vncp.set_class (a_class)
--				Error_handler.insert_error (l_vncp)
--				has_error := True
--			end
		end

feature {NONE} -- Implementation: status report

	is_conversion_ambiguous (a, b: CLASS_C): BOOLEAN is
			-- Does `a' convert to `b'?
		require
			a_not_void: a /= Void
			b_not_void: b /= Void
		local
			l_convert: DS_HASH_TABLE [INTEGER, NAMED_TYPE_A]
		do
				-- First check if there are no conversion to `b' from `a'.
			l_convert := a.convert_to
			if l_convert /= Void then
				from
					l_convert.start
				until
					l_convert.after or Result
				loop
					Result := l_convert.key_for_iteration.associated_class = b
					l_convert.forth
				end
			end

			if Result then
					-- If conversion found, then check that there are no
					-- conversions from `a' in `b'.
				l_convert := b.convert_from
				Result := False
				if l_convert /= Void then
					from
						l_convert.start
					until
						l_convert.after or Result
					loop
						Result := l_convert.key_for_iteration.associated_class = a
						l_convert.forth
					end
				end
			end
		end

	valid_signature (a_feat: FEATURE_I): BOOLEAN is
			-- Is `a_feat' valid for a conversion routine.
		require
			a_feat_not_void: a_feat /= Void
		do
			if a_feat.is_function then
				Result := a_feat.argument_count = 0
			else
				Result := (a_feat.is_routine and (not a_feat.is_once or not a_feat.is_external))
					and then (a_feat.argument_count = 1)
			end
		end

feature {NONE} -- Implementation: access

	has_error: BOOLEAN
			-- Did we find an error in last checking.

	test (u, v: NAMED_TYPE_A): BOOLEAN is
			-- Compare two instances `u' and `v' of NAMED_TYPE_A using `same_as'.
		do
			if v = Void then
				Result := (u = Void)
			elseif u = Void then
				Result := False
			else
				Result := u.same_as (v)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CONVERTIBILITY_CHECKER

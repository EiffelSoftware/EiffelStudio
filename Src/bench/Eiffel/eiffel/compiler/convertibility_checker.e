indexing
	description: "Initialize and check validity of convert clauses in instances of CLASS_C."
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
			l_type: TYPE
			l_cl_type: CL_TYPE_A
			l_convert_to, l_convert_from: DS_HASH_TABLE [INTEGER, CL_TYPE_A]
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
								l_cl_type ?= l_type.actual_type
								if l_type.has_like or l_cl_type = Void then
										-- Not a valid type.
									create l_vncp.make ("Invalid type: use of anchors.")
									l_vncp.set_class (a_class)
									Error_handler.insert_error (l_vncp)
									has_error := True
								else
										-- Check type has valid generics.
									if not l_cl_type.good_generics then
											-- Wrong number of geneneric parameters in parent
										l_vtug := l_cl_type.error_generics
										l_vtug.set_class (a_class)
										Error_handler.insert_error (l_vtug)
										has_error := True
									else
											-- Check constrained genericity validity rule
										l_cl_type.reset_constraint_error_list
										l_cl_type.check_constraints (a_class)
										if not l_cl_type.constraint_error_list.is_empty then
											create l_vncp.make ("Invalide generic type.")
											l_vncp.set_class (a_class)
											Error_handler.insert_error (l_vncp)
											has_error := True
										else
											l_cl_type.check_for_obsolete_class (a_class)
											
												-- Check that specified routine argument or return
												-- type matches conversion type `l_cl_type'.
											check_conversion_type (a_class, a_feat_tbl, l_feat,
												l_cl_type)
											if not has_error then
												if l_feat.is_creation_procedure then
													if l_convert_from.has (l_cl_type) then
														create l_vncp.make
															("Conversion type already specified.")
														l_vncp.set_class (a_class)
														Error_handler.insert_error (l_vncp)
														has_error := True
													else
														l_convert_from.put (l_name_id, l_cl_type)
													end
												else
													if l_convert_to.has (l_cl_type) then
														create l_vncp.make
															("Conversion type already specified.")
														l_vncp.set_class (a_class)
														Error_handler.insert_error (l_vncp)
														has_error := True
													else
														l_convert_to.put (l_name_id, l_cl_type)
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

feature {NONE} -- Implementation: initialization

	new_convert_table: DS_HASH_TABLE [INTEGER, CL_TYPE_A] is
			-- Create new instance used to initialize `convert_to' or `convert_from' of CLASS_C
			-- where equality on keys is done using `same_as' from CL_TYPE_A.
		do
			create Result.make (10)
				-- Compare keys using `same_as'.
			Result.set_key_equality_tester (Cl_type_a_tester)
		ensure
			new_convert_table_not_void: Result /= Void
		end

feature {NONE} -- Implementation: checking

	check_class_validity (a_class: CLASS_C) is
			-- Check that `a_class' can have a convert clause.
		require
			a_class_not_void: a_class /= Void
		local
			l_vncp: VNCP
		do
			if a_class.is_deferred then
				create l_vncp.make ("Class is deferred.")
				l_vncp.set_class (a_class)
				Error_handler.insert_error (l_vncp)
				has_error := True
			end
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
						if not a_class.creators.has (a_convert_feat.feature_name.internal_name) then
								-- Not a creation procedure.
							create l_vncp.make ("Not a creation procedure.")
							l_vncp.set_class (a_class)
							Error_handler.insert_error (l_vncp)
							has_error := True
						else
								-- Check it only has one argument
							if l_feat.argument_count /= 1 then
									-- Not a valid creation procedure (too many or not enough
									-- arguments)
								create l_vncp.make ("Not just 1 argument.")
								l_vncp.set_class (a_class)
								Error_handler.insert_error (l_vncp)
								has_error := True
							end
						end
					else
						if not l_feat.is_function or l_feat.argument_count /= 0 then
								-- Not a function without argument
							create l_vncp.make ("Not a function without argument.")
							l_vncp.set_class (a_class)
							Error_handler.insert_error (l_vncp)
							has_error := True
						end
					end
				else
						-- Feature is not an Eiffel routine
					create l_vncp.make ("Should be a routine, not a once nor an external.")
					l_vncp.set_class (a_class)
					Error_handler.insert_error (l_vncp)
					has_error := True
				end
			end
		end

	check_conversion_type (
			a_class: CLASS_C;
			a_feat_tbl: FEATURE_TABLE;
			a_convert_feat: CONVERT_FEAT_AS;
			a_type: CL_TYPE_A)
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
				if not a_type.conform_to (l_feat.type.actual_type) then
					create l_vncp.make ("SOURCE does not conform to return type.")
					l_vncp.set_class (a_class)
					Error_handler.insert_error (l_vncp)
					has_error := True
				end
			else
				if not a_type.conform_to (l_feat.arguments.i_th (1).actual_type) then
					create l_vncp.make ("SOURCE does not conform to argument type.")
					l_vncp.set_class (a_class)
					Error_handler.insert_error (l_vncp)
					has_error := True
				end
			end
			
				-- Check non-conformance of `a_type' to `a_class'.
			if
				not has_error and then
				a_type.conform_to (a_class.constraint_actual_type)
			then
				create l_vncp.make ("SOURCE conforms to current class.")
				l_vncp.set_class (a_class)
				Error_handler.insert_error (l_vncp)
				has_error := True
			end
		end
		
feature {NONE} -- Implementation: status report

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

	Cl_type_a_tester: AGENT_BASED_EQUALITY_TESTER [CL_TYPE_A] is
			-- Compare instances of CL_TYPE_A using `same_as'.
			-- Once is ok now, but if we start doing operations on convert tables
			-- in 2 different threads, then it would need to become a once per object.
		once
				-- FIXME: Manu 04/23/2003, there is a bug in the parser that prevents us to
				-- write:
				-- create Result.make (agent {CL_TYPE_A}.same_as ({CL_TYPE_A}))
				-- Because the second {CL_TYPE_A} has an ambiguity, it can be the start
				-- of an agent expression (using the old syntax), or a type specification.
				-- By default it considers it to be the new agent expression
			create Result.make (agent compare_cl_type_a)
		ensure
			cl_type_a_tester_not_void: Result /= Void
		end

	compare_cl_type_a (u, v: CL_TYPE_A): BOOLEAN is
			-- Compare two instances of CL_TYPE_A.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := u.same_as (v)
		end

end -- class CONVERTIBILITY_CHECKER

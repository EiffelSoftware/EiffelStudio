indexing
	description:
		"Abstract description of an access to an Eiffel feature (note %
		%that this access cannot be the first call of a nested %
		%expression). Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_FEAT_AS

inherit
	ACCESS_AS
		redefine
			type_check, byte_node, format, is_equivalent
		end

	SHARED_CONFIGURE_RESOURCES

feature {AST_FACTORY} -- Initialization

	initialize (f: like feature_name; p: like parameters) is
			-- Create a new FEATURE_ACCESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
			parameters := p
			if p /= Void then
				p.start
			end
		ensure
			feature_name_set: feature_name = f
			parameters_set: parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_feat_as (Current)
		end

feature -- Attributes

	feature_name: ID_AS
			-- Name of the feature called

	parameters: EIFFEL_LIST [EXPR_AS]
			-- List of parameters

	parameter_count: INTEGER is
			-- Count of parameters
		do
			if parameters /= Void then
				Result := parameters.count
			end
		end

	access_name: STRING is
		do
			Result := feature_name
		end

feature -- Delayed calls

	is_delayed : BOOLEAN is
			-- Is this access delayed?
		do
			-- Default: No
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and
				equivalent (parameters, other.parameters) and
				is_delayed = other.is_delayed
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an access to a feature
		local
			id_type: TYPE_A
		do
			id_type := access_type
			Error_handler.checksum
			check
				id_type_exists: id_type /= Void
			end
				-- Update the type stack
			context.replace (id_type)
		end

	is_export_valid (feat: FEATURE_I): BOOLEAN is
			-- Is the call export-valid ?
		require
			good_argument: feat /= Void
		do
			Result := Context.is_ignoring_export or feat.is_exported_for (context.current_class)
		end

	access_type: TYPE_A is
			-- Type check an the access to an id
		local
			arg_type, l_like_arg_type: TYPE_A
			a_feature: FEATURE_I
			i, count, arg_count: INTEGER
				-- Id of the class type on the stack
			current_item: TYPE_A
			last_type, last_constrained: TYPE_A
				-- Type onto the stack
			last_id: INTEGER
			context_count: INTEGER
				-- Id of the class correponding to `last_type'
			last_class: CLASS_C
			depend_unit: DEPEND_UNIT
			access_b: ACCESS_B
			vuar1: VUAR1
			vuex: VUEX
			vkcn3: VKCN3
			obs_warn: OBS_FEAT_WARN
			context_export: EXPORT_I
			feature_export: EXPORT_I
			vape: VAPE
			formal_type: FORMAL_A
			operand: OPERAND_AS
			open_type: OPEN_TYPE_A
			is_in_creation_expression, is_in_creation_call: BOOLEAN
			multi: MULTI_TYPE_A
			was_overloaded: BOOLEAN
			l_feature_name: like feature_name
		do
			last_type := context_last_type

				-- Retrieve if we are type checking a routine that is the creation
				-- routine of a creation expression. As soon as we know this, we
				-- reset `is_in_creation_expression' to False, so that if any parameter
				-- of the creation routine is also a creation expression we perform
				-- a correct type checking of the VAPE errors.
			is_in_creation_expression := context.is_in_creation_expression
			is_in_creation_call := context.is_in_creation_call
			context.set_is_in_creation_expression (False)
			context.set_is_in_creation_call (False)

			if last_type.is_multi_type then
				multi ?= last_type
				last_type := multi.last_type
				context.replace (last_type)
			end
			last_constrained := context.last_constrained_type

			if last_constrained.is_void then
					-- No call when target is a procedure
				create vkcn3
				context.init_error (vkcn3)
				Error_handler.insert_error (vkcn3)
					-- Cannot go on here
				Error_handler.raise_error
			elseif last_constrained.is_none then
				create vuex.make_for_none (feature_name)
				context.init_error (vuex)
				Error_handler.insert_error (vuex)
					-- Cannot go on here
				Error_handler.raise_error
			end

			last_class := associated_class (last_constrained)
			last_id := last_class.class_id

				-- Look for a feature in the class associated to the
				-- last actual type onto the context type stack. If it
				-- is a generic take the associated constraint.
			l_feature_name := feature_name
			if last_class.feature_table.has_overloaded (feature_name) then
				a_feature := overloaded_feature (last_type, last_class)
				if a_feature /= Void then
						-- Update `feature_name' with appropriate resolved name.
						-- Otherwise some routine using `feature_name' will fail although
						-- it succeeds here (e.g. CREATION_EXPR_AS and CREATION_AS)
					create feature_name.initialize (a_feature.feature_name)
				end
				was_overloaded := True
			else
				a_feature := last_class.feature_table.item (feature_name)
			end
			if valid_feature (a_feature) then
					-- Attachments type check
				count := parameter_count
				arg_count := a_feature.argument_count

				if (count = 0) and then (arg_count /= 0) and then is_delayed then
						-- Delayed call with all arguments open.
						-- Create parameters.
					from
						create parameters.make_filled (arg_count)
						parameters.start
					until
						parameters.after
					loop
						create operand
						parameters.put (operand)
						parameters.forth
					end
					count := arg_count
					parameters.start
				end
				if count /= a_feature.argument_count then
					create vuar1
					context.init_error (vuar1)
					vuar1.set_called_feature (a_feature, last_id)
					vuar1.set_argument_count (count)
					Error_handler.insert_error (vuar1)
						-- Cannot go on here: too dangerous
					Error_handler.raise_error
				elseif parameters /= Void then
					if not was_overloaded then
							-- Type check on parameters only if feature was not overloaded. Type
							-- checking is already done in `overloaded_feature' because needed to
							-- resolve overloading.
						parameters.type_check
					end

						-- Conformance initialization
					Argument_types.init2 (a_feature)
					from
						i := count
						context_count := context.count - count
					until
						i < 1
					loop
							-- Extract expression type
						current_item := context.i_th (context_count + i); 
							-- Extract feature argument type
						arg_type ?= a_feature.arguments.i_th (i)

							-- Take care of anchoring to argument
						if arg_type.is_like_argument then
							l_like_arg_type := arg_type.conformance_type
							l_like_arg_type :=
								l_like_arg_type.instantiation_in (last_type, last_id).actual_type
								-- Check that `current_item' is compatible to its `like argument'.
								-- Once this is done, then type checking is done on the real
								-- type of the routine, not the anchor.
							if
								not current_item.conform_to (l_like_arg_type) and then
								not current_item.convert_to (context.current_class, l_like_arg_type)
							then
								insert_vuar2_error (a_feature, last_id, i, current_item, l_like_arg_type)
							end
						end
							-- Actual type of feature argument
						arg_type := arg_type.instantiation_in (last_type, last_id).actual_type

							-- Conformance: take care of constrained genericity
							-- We must generate an error when `arg_type' becomes
							-- an OPEN_TYPE_A, for example "~equal (?, b)" will
							-- check that the type of `b' conforms to type of `?'
							-- since `equal' is defined as `equal (a: ANY; b: like a)'.
							-- However `conform_to' does not work when parameter
							-- is an OPEN_TYPE_A type. Since this checks can only
							-- happens in type checking of an agent, we can do it
							-- at only one place, ie here.
						open_type ?= arg_type
						if open_type /= Void or else not current_item.conform_to (arg_type) then
							if
								open_type = Void and
								current_item.convert_to (context.current_class, arg_type)
							then
								if parameters_convert_info = Void then
									create parameters_convert_info.make (1, count)
								end
								parameters_convert_info.put (context.last_conversion_info, i)
								if context.last_conversion_info.has_depend_unit then
									context.supplier_ids.extend (
										context.last_conversion_info.depend_unit)
								end
							elseif
								current_item.is_expanded and then arg_type.is_external and then
								current_item.is_conformant_to (arg_type)
							then
									-- No need for conversion, this is currently done at the code
									-- generation level to properly handle the generic case.
									-- If not done at the code generation, we would need the
									-- following lines.
--								if parameters_convert_info = Void then
--									create parameters_convert_info.make (1, count)
--								end
--								parameters_convert_info.put (
--									create {BOX_CONVERSION_INFO}.make (current_item), i)	
							else
								insert_vuar2_error (a_feature, last_id, i, current_item, arg_type)
							end
						end
							-- Insert the attachment type in the
							-- parameters line for byte code
						Attachments.insert (arg_type)
						i := i - 1
					end
				end

					-- Get the type of Current feature.
				Result ?= a_feature.type

					-- If the declared target type is formal
					-- and if the corresponding generic parameter is
					-- constrained to a class which is also generic
					-- Result id a FORMAL_A object with no more information
					-- than the position of the formal in the generic parameter
					-- list of the class in which the feature "feature_name" is 
					-- declared.
					-- Example:
					--
					-- 	class TEST [G -> ARRAY [STRING]]
					--	...
					--	x: G
					-- 		x.item (1)
					--
					-- For the evaluation of `item', last_type is "Generic #1" (of TEST)
					-- `last_constrained_type' is ARRAY [STRING], `a_feature.type'
					-- is "Generic #1" (of ARRAY)
					-- We need to convert the type to the constrained type for proper
					-- type evaluation of remote calls.
					-- "Generic #1" (of ARRAY) is thus replaced by the corresponding actual
					-- type in the declaration of the constraint class type (in this case
					-- class STRING).
					-- Note: the following conditional instruction will not be executed
					-- if the class type of the constraint id not generic since in that
					-- case `Result' would not be formal.

				if last_type.is_formal then
					if Result.is_formal then
						formal_type ?= Result
					else
						formal_type ?= Result.actual_type
					end

					if formal_type /= Void then
						Result := last_constrained.generics.item (formal_type.position)
					end
				elseif last_type.is_like then
					if Result.is_formal then
						formal_type ?= Result
					else
						formal_type ?= Result.actual_type
					end
					if formal_type /= Void then
						Result := last_type.actual_type.generics.item (formal_type.position)
					end
				end
				Result := Result.conformance_type
				context.pop (count)
				Result := Result.instantiation_in (last_type, last_id).actual_type
					-- Export validity
				if not is_export_valid (a_feature) then
					create vuex
					context.init_error (vuex)
					vuex.set_static_class (last_class)
					vuex.set_exported_feature (a_feature)
					Error_handler.insert_error (vuex)
				end
				if
					a_feature.is_obsolete
						-- If the obsolete call is in an obsolete class,
						-- no message is displayed
					and then not context.current_class.is_obsolete
						-- The current feature is whether the invariant or
						-- a non obsolete feature
					and then (context.current_feature = Void or else
						not context.current_feature.is_obsolete)
				then
					create obs_warn
					obs_warn.set_class (context.current_class)
					obs_warn.set_obsolete_class (context.last_class)
					obs_warn.set_obsolete_feature (a_feature)
					obs_warn.set_feature (context.current_feature)
					Error_handler.insert_warning (obs_warn)
				end
				if
					not System.do_not_check_vape and then
					context.is_checking_precondition and then
					not is_in_creation_expression and then
					context.check_for_vape
				then
						-- In precondition and checking for vape
					context_export := context.current_feature.export_status
					feature_export := a_feature.export_status
					debug
						io.error.put_string ("feature ")
						io.error.put_string (context.current_feature.feature_name)
						io.error.put_string (" export ")
						io.error.put_new_line
						context_export.trace
						io.error.put_new_line
						io.error.put_string ("feature ")
						io.error.put_string (a_feature.feature_name)
						io.error.put_string (" export ")
						io.error.put_new_line
						feature_export.trace
						io.error.put_new_line
					end
					if not context_export.is_subset (feature_export) then
						create vape
						context.init_error (vape)
						vape.set_exported_feature (a_feature)
						Error_handler.insert_error (vape)
						Error_handler.raise_error
					end
				end

					-- Supplier dependances update
				if is_in_creation_call then
					create depend_unit.make_with_level (last_id, a_feature,
						{DEPEND_UNIT}.is_in_creation_flag | context.depend_unit_level)
				else
					create depend_unit.make_with_level (last_id, a_feature, context.depend_unit_level)
				end
				context.supplier_ids.extend (depend_unit)
	
					-- Access managment
				access_b := new_call_access (a_feature, Result.type_i)
				context.access_line.insert (access_b)
			else
					-- `a_feature' was not valid for current, report
					-- corresponding error.
				report_error_for_feature (a_feature, l_feature_name)
			end
		end

	context_last_type: TYPE_A is
			-- Context type in which access is performed.
		do
			Result := context.item
		ensure
			result_not_void: Result /= Void
		end

	associated_class (a_constraint: TYPE_A): CLASS_C is
			-- Associated class to `a_constraint' if any.
		require
			a_constraint_not_void: a_constraint /= Void
		do
			Result := a_constraint.associated_class
		ensure
			result_not_void: Result /= Void
		end

	valid_feature (a_feature: FEATURE_I): BOOLEAN is
			-- Is `a_feature' valid for current analyzis?
		do
			Result := a_feature /= Void	
		end

	report_error_for_feature (a_feature: FEATURE_I; a_feature_name: like feature_name) is
			-- Report error during `type_check' because `a_feature'
			-- was not valid for call.
		require
			a_feature_name_not_void: a_feature_name /= Void
		local
			veen: VEEN
		do
			if a_feature = Void then
					-- Not a valid feature name.
				create veen
				context.init_error (veen)
				veen.set_identifier (a_feature_name)
				veen.set_parameter_count (parameter_count)
				error_handler.insert_error (veen)
				error_handler.raise_error
			end
		end

	new_call_access (a_feature: FEATURE_I; a_type_i: TYPE_I): ACCESS_B is
			-- Create new node for associated AST node.
		require
			a_feature_not_void: a_feature /= Void
			a_type_i_not_void: a_type_i /= Void
		do
			Result := a_feature.access (a_type_i)
		ensure
			result_not_void: Result /= Void
		end
		
	byte_node: ACCESS_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE
			params: BYTE_LIST [PARAMETER_B]
			p: PARAMETER_B
			i, nb: INTEGER
			l_info: CONVERSION_INFO
			l_convert_info: like parameters_convert_info
		do
			if parameters /= Void then
				from
					nb := parameters.count
					create params.make_filled (nb)
					l_convert_info := parameters_convert_info
					i := 1
				until
					i > nb
				loop
					create p
					if l_convert_info /= Void then
						l_info := l_convert_info.item (i)
					end
					if l_info /= Void then
							-- Process conversion if any
						p.set_expression (l_info.byte_node (
							parameters.i_th (i).byte_node))
					else
						p.set_expression (parameters.i_th (i).byte_node)
					end
					params.put_i_th (p, i)
					i := i + 1	
				end
					-- Attachment types are inserted in the reversal
					-- order in `Attachments' during type check
				from
					i := nb
				until
					i < 1
				loop
					params.i_th (i).set_attachment_type (Attachments.item.type_i)
					Attachments.forth
					i := i - 1
				end
				
				parameters_convert_info := Void
			end

			access_line := context.access_line
			Result := access_line.access
			Result.set_parameters (params)
			access_line.forth
		end

	Attachments: LINE [TYPE_A] is
			-- Atachement types line
		once
			Result := Context.parameters
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin
			ctxt.prepare_for_feature (feature_name, parameters)
			ctxt.put_current_feature
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_feature (feature_name, parameters)
			ctxt.put_current_feature
		end

feature {COMPILER_EXPORTER} -- Replication {ACCESS_FEAT_AS, USER_CMD, CMD}

	set_feature_name (name: like feature_name) is
		require
			valid_arg: name /= Void
		do
			feature_name := name
		end

	set_parameters (p: like parameters) is
		do
			parameters := p
		end

feature {NONE} -- Implementation: convertibility

	parameters_convert_info: ARRAY [CONVERSION_INFO]
			-- For each parameters that need a conversion call, we store info used in `byte_node'
			-- to generate conversion call

feature {NONE} -- Implementation: overloading

	overloaded_feature (last_type: TYPE_A; last_class: CLASS_C): FEATURE_I is
			-- Find overloaded feature that could match Current. The rules are taken from
			-- C# ECMA specification "14.4.2 Overload Resolution".
		require
			last_type_not_void: last_type /= Void
			last_class_not_void: last_class /= Void
			last_class_has_overloaded: last_class.feature_table.has_overloaded (feature_name)
		local
			last_id: INTEGER
			l_features: LIST [FEATURE_I]
			viof: VIOF
			l_list: ARRAYED_LIST [TYPE_A]
			i, nb, context_count: INTEGER
		do
			last_id := last_class.class_id

				-- At this stage we know this is an overloaded routine.
			l_features := last_class.feature_table.overloaded_items (feature_name)

				-- Remove all features that are not valid for Current call.
				-- C# ECMA 14.4.2.1
			l_features := applicable_overloaded_features (l_features, last_type, last_id)

			if l_features.is_empty then
			elseif l_features.count = 1 then
				Result := l_features.first
			else
					-- Now that we have all valid features for this call, we need to find the
					-- best match. If we find more than one, there is an ambiguity.
					-- C# ECMA 14.4.2.2 and 14.4.2.3
				l_features := best_overloaded_features (l_features, last_type, last_id)

				if l_features.is_empty then
				elseif l_features.count = 1 then
					Result := l_features.first
				else
						-- Raise a VIOF error which states type of arguments of current call and list
						-- all possible features that matches the above types.
					from
						i := 1
						nb := parameter_count
						context_count := context.count - nb
						create l_list.make (nb)
					until
						i > nb
					loop
						l_list.extend (context.i_th (context_count + i))
						i := i + 1
					end
					create viof.make (System.current_class, context.current_feature,
						l_features, feature_name, last_id, l_list)
					Error_handler.insert_error (viof)
						-- Cannot go on here
					Error_handler.raise_error
				end
			end
		end

	applicable_overloaded_features
			(a_features: LIST [FEATURE_I]; last_type: TYPE_A; last_id: INTEGER): LIST [FEATURE_I]
		is
			-- Use C# ECMA specification 14.4.2.1 to find list of matching features in
			-- `a_features' that matches given arguments.
			-- That is to say it keeps features that have the same number of parameters,
			-- that are agent creations with full open type specification and whose
			-- signature is valid for given arguments.
		require
			a_features_not_void: a_features /= Void
			last_type_not_void: last_type /= Void
			last_id_nonnegative: last_id >= 0
		local
			l_feature: FEATURE_I
			i, count, context_count: INTEGER
			l_done: BOOLEAN
			l_arg_type: TYPE_A
			current_item: TYPE_A
			open_type: OPEN_TYPE_A
		do
			create {ARRAYED_LIST [FEATURE_I]} Result.make (a_features.count)
			count := parameter_count

				-- First remove not valid feature and feature with incorrect number of arguments.
			from
				a_features.start
			until
				a_features.after
			loop
				l_feature := a_features.item
				if valid_feature (l_feature) and then l_feature.argument_count = count then
					Result.extend (l_feature)
				end
				a_features.forth
			end
			
			if Result.is_empty then
			elseif Result.count = 1 then
					-- Only one feature remaining, we still need to do the type checking on the
					-- parameters as it is expected by callers of current feature.
				if parameters /= Void then
					parameters.type_check
				end
			else
				if parameters /= Void then
						-- Type check on parameters
					parameters.type_check
		
						-- Iterate through all found features and find all the features whose
						-- signature matches the one from the given arguments.
						-- In other words, for every `arg_i' of the given parameters, find
						-- all features where `arg_i' conforms to `formal_arg_i', formal argument
						-- type of the feature.
						-- Corresponds to second point of C# spec 14.4.2.1
					from
						Result.start
					until
						Result.after
					loop
						l_feature := Result.item

							-- Conformance checking
						from
							l_done := False
							i := count
							context_count := context.count - count
						until
							i < 1 or l_done
						loop
							l_arg_type := feature_arg_type (l_feature, i, last_type, last_id)
							current_item := context.i_th (context_count + i); 
								-- We must generate an error when `l_arg_type' becomes
								-- an OPEN_TYPE_A, for example "~equal (?, b)" will
								-- check that the type of `b' conforms to type of `?'
								-- since `equal' is defined as `equal (a: ANY; b: like a)'.
								-- However `conform_to' does not work when parameter
								-- is an OPEN_TYPE_A type. Since this checks can only
								-- happens in type checking of an agent, we can do it
								-- at only one place, ie here.
							open_type ?= l_arg_type
							if
								open_type /= Void or else
								not (current_item.conform_to (l_arg_type) or
								current_item.convert_to (context.current_class, l_arg_type))
							then
									-- Error, we cannot continue. Let's check the next feature.
								l_done := True
							end
							i := i - 1
						end
						if l_done then
							Result.remove
						else
							Result.forth
						end
					end
				end
			end
		ensure
			applicable_overloaded_features_not_void: Result /= Void
		end

	best_overloaded_features
			(a_features: LIST [FEATURE_I]; last_type: TYPE_A; last_id: INTEGER): LIST [FEATURE_I]
		is
			-- Use C# ECMA specification 14.4.2.2 and 14.4.2.3 to find list of best matching
			-- features in `a_features' that matches given arguments.
		require
			a_features_not_void: a_features /= Void
			a_features_has_two_items_at_least: a_features.count > 1
			all_features_have_arguments: a_features.for_all (agent {FEATURE_I}.has_arguments)
			last_type_not_void: last_type /= Void
			last_id_nonnegative: last_id >= 0
		local
			l_feature1, l_feature2, l_better_feature: FEATURE_I
			feature_count, arg_count: INTEGER
			l_place_found: BOOLEAN
			l_set: SEARCH_TABLE [FEATURE_I]
			l_set_traversal: ARRAYED_LIST [FEATURE_I]
		do
				-- Our goal is to build `l_set' which is the set of features that are better
				-- functions. If this set contains only one item, then it is the best function,
				-- if it contains more than one element, it means that they are not comparable
				-- (meaning they are neither worse nor better than the other).
				--
				-- We iterate on all features in `a_features'. For each feature, we compare
				-- if it can be ordered in `l_set', if it can then we replace all worse feature
				-- by the one that can be ordered. Once all features of `a_features' have been
				-- handled, `l_set' is properly filled.
				--
				-- To summarize:
				-- For each feature f1 in `a_features' do
				--   For each feature f2 in `l_set' do
				--     if f1 better than f2, replace f2 by f1 in `l_set'
				--     if f2 better than f1, nothing
				--     if f1 is no better or no worse than f2, it is not ordered
				--   end for
				--   if f1 was for each iteration in `l_set' not ordered then
				--     we add it to `l_set'.
				--   end if
				-- end for
			from
				a_features.start
				feature_count := a_features.count
				arg_count := a_features.first.argument_count
				create l_set.make (feature_count)
			until
				a_features.after
			loop
				l_feature1 := a_features.item
				l_set_traversal := l_set.linear_representation
				from
					l_place_found := False
					l_set_traversal.start
				until
					l_set_traversal.after
				loop
					l_feature2 := l_set_traversal.item
					l_better_feature := better_feature (l_feature1, l_feature2, last_type, last_id)
					if l_better_feature = l_feature1 then
							-- Replace `l_feature2' by `l_feature1' since we found a better match.
						l_set.remove (l_feature2)
						l_set.put (l_feature1)
						l_place_found := True
					elseif l_better_feature = l_feature2 then
						l_place_found := True
					end
					l_set_traversal.forth
				end
				if not l_place_found then
						-- `l_feature1' could not be ordered in `l_set_traversal'
						-- so we need to add it to `l_set'.
					l_set.put (l_feature1)
				end
				a_features.forth
			end
			Result := l_set.linear_representation	
		ensure
			applicable_overloaded_features_not_void: Result /= Void
		end

	better_feature (a_feat1, a_feat2: FEATURE_I; last_type: TYPE_A; last_id: INTEGER): FEATURE_I is
			-- If `a_feat1' is better for overloading that `a_feat2', returns `a_feat1',
			-- if `a_feat2' is better for overloading than `a_feat1', returns `a_feat2',
			-- otherwise returns Void.
		require
			a_feat1_not_void: a_feat1 /= Void
			a_feat2_not_void: a_feat2 /= Void
			a_feat1_has_arguments: a_feat1.has_arguments
			a_feat2_has_arguments: a_feat2.has_arguments
			a_feat1_and_a_feat2_have_same_argument_count:
				a_feat1.argument_count = a_feat2.argument_count
			last_type_not_void: last_type /= Void
			last_id_nonnegative: last_id >= 0
		local
			l_target1, l_target2, l_better: TYPE_A
			l_current_item: TYPE_A
			i, arg_count, context_count: INTEGER
			l_done: BOOLEAN
		do
			from
				arg_count := a_feat1.argument_count
				Result := Void
				l_done := False
				i := arg_count
				context_count := context.count - arg_count
			until
				i < 1 or l_done
			loop
					-- Extract argument info from `a_feat1'.
				l_target1 := feature_arg_type (a_feat1, i, last_type, last_id)

					-- Extract argument info from `a_feat2'.
				l_target2 := feature_arg_type (a_feat2, i, last_type, last_id)

					-- Extract passed argument info.
				l_current_item := context.i_th (context_count + i); 

				if not l_target1.same_as (l_target2) then
					l_better := better_conversion (l_current_item, l_target1, l_target2)
					if l_better = Void then
							-- No better conversion found, it means that we can skip
							-- this feature `a_feat2'.
						l_done := True
						Result := Void
					else
						if Result = Void then
							if l_better = l_target1 then
									-- It means that at the moment `a_feat1' seems
									-- to be a better feature, we store `a_feat1'
									-- as best routine.
								Result := a_feat1
							else
								Result := a_feat2
							end
						else
								-- We had already assigned `Result', so we
								-- really have a better feature, so we need to ensure the new 
								-- better conversion matches the better found feature.
							if Result = a_feat1 then
								l_done := l_better = l_target2
							else
								l_done := l_better = l_target1
							end
							if l_done then
								Result := Void
							end
						end
					end
				end
				i := i - 1
			end
		ensure
			better_function_valid: Result = Void or Result = a_feat1 or Result = a_feat2
		end
		
	better_conversion (source_type, target1, target2: TYPE_A): TYPE_A is
			-- Using C# ECMA 14.4.2.3 terminology, given `source_type' find which of `target1'
			-- or `target2' is a better conversion.
			-- Return type is either `target1' or `target2' if there is a better conversion,
			-- otherwise Void.
		require
			source_type_not_void: source_type /= Void
			target1_not_void: target1 /= Void
			target2_not_void: target2 /= Void
			target1_different_from_target2: not target1.same_as (target2)
		local
			conform1, conform2: BOOLEAN
			convert1, convert2: BOOLEAN
		do
			if source_type.same_as (target1) then
				Result := target1
			elseif source_type.same_as (target2) then
				Result := target2
			else
					-- First process conformance.
				conform1 := source_type.conform_to (target1)
				conform2 := source_type.conform_to (target2)
				if conform1 and conform2 then
					if target1.conform_to (target2) then
						Result := target1
					elseif target2.conform_to (target1) then
						Result := target2
					end
				elseif conform1 then
					Result := target1
				elseif conform2 then
					Result := target2
				else
						-- Conformance failed, so let's check conversion.
					convert1 := source_type.convert_to (context.current_class, target1)
					convert2 := source_type.convert_to (context.current_class, target2)
					if convert1 and not convert2 then
						Result := target1
					elseif convert2 and not convert1 then
						Result := target2
					end
				end
			end
		ensure
			better_conversion_found: Result /= Void implies (Result = target1 or Result = target2)
		end

	feature_arg_type
			(a_feature: FEATURE_I; a_pos: INTEGER; last_type: TYPE_A; last_id: INTEGER): TYPE_A
		is
			-- Find type of argument at position `a_pos' of feature `a_feature' in context
			-- of `last_type', `last_id'.
		require
			a_feature_not_void: a_feature /= Void
			a_feature_has_arguments: a_feature.has_arguments
			a_pos_valid: a_feature.arguments.valid_index (a_pos)
			last_type_not_void: last_type /= Void
			last_id_nonnegative: last_id >= 0
		do
				-- Get type from FEATURE_I. It should be evaluated already and therefore
				-- assignment attempt should work.
			Result ?= a_feature.arguments.i_th (a_pos)
			check
				feature_evaluated: Result /= Void
			end

				-- Evaluation of the actual type of the
				-- argument declaration
			if Result.is_like_argument then
				Result := Result.conformance_type
			end

				-- Instantiation of `Result' in context of target represented by `last_type' and
				-- `last_id'.
			Result := Result.instantiation_in (last_type, last_id).actual_type
		ensure
			feature_arg_type_not_void: Result /= Void
		end

end -- class ACCESS_FEAT_AS

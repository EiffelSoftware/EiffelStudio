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
				-- Delayed calls are always export valid!
			Result := is_delayed or else feat.is_exported_for (context.current_class)
		end

	access_type: TYPE_A is
			-- Type check an the access to an id
		local
			arg_type: TYPE_A
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
			vuar2: VUAR2
			vuex: VUEX
			vhne: VHNE
			vkcn3: VKCN3
			obs_warn: OBS_FEAT_WARN
			context_export: EXPORT_I
			feature_export: EXPORT_I
			like_argument_detected: BOOLEAN
			vape: VAPE
			formal_type: FORMAL_A
			operand: OPERAND_AS
			open_type: OPEN_TYPE_A
			is_in_creation_expression: BOOLEAN
			multi: MULTI_TYPE_A
		do
			last_type := context_last_type

				-- Retrieve if we are type checking a routine that is the creation
				-- routine of a creation expression. As soon as we know this, we
				-- reset `is_in_creation_expression' to False, so that if any parameter
				-- of the creation routine is also a creation expression we perform
				-- a correct type checking of the VAPE errors.
			is_in_creation_expression := context.is_in_creation_expression
			context.set_is_in_creation_expression (False)

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
				create vhne
				context.init_error (vhne)
				Error_handler.insert_error (vhne)
					-- Cannot go on here
				Error_handler.raise_error
			end

			last_class := associated_class (last_constrained)
			last_id := last_class.class_id

				-- Look for a feature in the class associated to the
				-- last actual type onto the context type stack. If it
				-- is a generic take the associated constraint.
			a_feature := last_class.feature_table.item (feature_name)
			if valid_feature (a_feature) then
					-- Supplier dependances update
				create depend_unit.make (last_id, a_feature)
				context.supplier_ids.extend (depend_unit)
				
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
						-- Type check on parameters
					parameters.type_check

						-- Conformance initialization
					Argument_types.init2 (a_feature)
					from
						i := count
						context_count := context.count - count
					until
						i < 1
					loop
						arg_type ?= a_feature.arguments.i_th (i)
							-- Evaluation of the actual type of the
							-- argument declaration
						if arg_type.is_like_argument then
							arg_type := arg_type.conformance_type
							arg_type := arg_type.instantiation_in
											(last_type, last_id).actual_type
							if metamorphosis_disabled then
								like_argument_detected := arg_type.is_basic
							else
								like_argument_detected := True
							end
						else
								-- Instantiation of it in the context of
								-- the context of the target
							arg_type := arg_type.instantiation_in
											(last_type, last_id).actual_type
						end
							-- Conformance: take care of constrained
							-- genericity
						current_item := context.i_th (context_count + i); 
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
							create vuar2
							context.init_error (vuar2)
							vuar2.set_called_feature (a_feature, last_id)
							vuar2.set_argument_position (i)
							vuar2.set_argument_name (a_feature.arguments.item_name (i))
							vuar2.set_formal_type (arg_type)
							vuar2.set_actual_type (current_item)
							Error_handler.insert_error (vuar2)
						end
							-- Insert the attachment type in the
							-- parameters line for byte code
						Attachments.insert (arg_type)
						i := i - 1
					end
					if like_argument_detected then
						update_argument_type (a_feature)
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
					context.level4 and then
					not is_in_creation_expression and then
					context.check_for_vape
				then
						-- In precondition and checking for vape
					context_export := context.current_feature.export_status
					feature_export := a_feature.export_status
debug
	io.error.putstring ("feature ")
	io.error.putstring (context.current_feature.feature_name)
	io.error.putstring (" export ")
	io.error.new_line
	context_export.trace
	io.error.new_line
	io.error.putstring ("feature ")
	io.error.putstring (a_feature.feature_name)
	io.error.putstring (" export ")
	io.error.new_line
	feature_export.trace
	io.error.new_line
end
					if 
						a_feature.feature_name_id /= feature {PREDEFINED_NAMES}.void_name_id
						and then not context_export.is_subset (feature_export) 
					then
						create vape
						context.init_error (vape)
						vape.set_exported_feature (a_feature)
						Error_handler.insert_error (vape)
						Error_handler.raise_error
					end
				end

					-- Access managment
				access_b := new_call_access (a_feature, Result.type_i)
				context.access_line.insert (access_b)
			else
					-- `a_feature' was not valid for current, report
					-- corresponding error.
				report_error_for_feature (a_feature)
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

	report_error_for_feature (a_feature: FEATURE_I) is
			-- Report error during `type_check' because `a_feature'
			-- was not valid for call.
		local
			veen: VEEN
		do
			if a_feature = Void then
					-- Not a valid feature name.
				create veen
				context.init_error (veen)
				veen.set_identifier (feature_name)
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
		do
			if parameters /= Void then
				from
					nb := parameters.count
					create params.make_filled (nb)
					i := 1
				until
					i > nb
				loop
					create p
					p.set_expression (parameters.i_th (i).byte_node)
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
			end

			access_line := context.access_line
			Result := access_line.access
			Result.set_parameters (params)
			access_line.forth
		end

	update_argument_type (feat: FEATURE_I) is
			-- Update the argument types for like_argument.
			-- Retrieve the corresponding argument type for the like
			-- argument and update the like_argument type
		local
			args: FEAT_ARG
			arg_pos, i, nbr: INTEGER
			type_a: TYPE_A
			like_arg: LIKE_ARGUMENT
			pos: INTEGER
		do
			args := feat.arguments
				-- Attachment types are inserted in the reversal
				-- order in `Attachments' during type check
			pos := Attachments.cursor
			from
				i := 1
				nbr := args.count; 
			until
				i > nbr
			loop
				like_arg ?= args.i_th (i)
				if like_arg /= Void then
					arg_pos := pos - like_arg.position + 1
						--| Retrieve type in which like_argument is
						--| referring to.
					Attachments.go_i_th (arg_pos)
					type_a := Attachments.item
						--| Replace item in like argument
					Attachments.go_i_th (pos - i + 1)
					if metamorphosis_disabled then
						if Attachments.item.is_basic then
								--| Replace item in like argument
							Attachments.change_item (type_a)
						end
					else
							--| Replace item in like argument
						Attachments.change_item (type_a)
					end
				end
				i := i + 1
			end;	
			Attachments.go_i_th (pos)
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

end -- class ACCESS_FEAT_AS

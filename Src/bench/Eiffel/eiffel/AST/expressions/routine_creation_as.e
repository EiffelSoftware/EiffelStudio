indexing
	description: "Abstract description of an Eiffel routine object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

	SHARED_TYPES
	SHARED_EVALUATOR

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; f: like feature_name; o: like operands; has_target: BOOLEAN) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		require
			f_not_void: f /= Void
		do
			target := t
			feature_name := f
			operands := o
			if target /= Void then
				if target.target /= Void then
					target_ast := target.target
				elseif target.expression /= Void then
						-- Target is an expression
					target_ast := target.expression
				elseif target.class_type = Void then
						-- Target is simply Current but not mentioned (thus 0 for length)
					create {CURRENT_AS} target_ast.make_with_location (f.line, f.column, f.position, 0)
				end
			end

			create call_ast.make (feature_name, operands, has_target)
		ensure
			target_set: target = t
			feature_name_set: feature_name = f
			operands_set: operands = o
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_creation_as (Current)
		end

feature -- Attributes

	target: OPERAND_AS
			-- Target operand used when the feature will be called.

	feature_name: ID_AS
			-- Feature name.

	operands : EIFFEL_LIST [OPERAND_AS]
			-- List of operands used by the feature when called.

	target_type : CL_TYPE_A
			-- Type of the target.

	open_positions: ARRAYED_LIST [INTEGER]
			-- Open positions in operands_tuple.

	operands_tuple: ARRAY [TYPE_A]
			-- TUPLE type which hold all open and closed values needed for agent call.

	target_ast: AST_EIFFEL
			-- Ast created for target during type checking.

	call_ast: DELAYED_ACCESS_FEAT_AS
			-- Ast created for delayed call during type checking.

	type : GEN_TYPE_A
			-- Type of routine object.

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if target /= Void then
				Result := target.start_location
			else
				Result := feature_name.start_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := call_ast.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target) and then
					  equivalent (call_ast, other.call_ast)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a routine creation expression.
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			depend_unit: DEPEND_UNIT
			not_supported: NOT_SUPPORTED
		do
			-- For type checking we treat the delayed call
			-- as if it were an ordinary call. So we don't
			-- have to duplicate all the code!

			-- Type check the target

			context.begin_expression

			if target = Void then
					-- Open target; feature comes from
					-- current class
				target_type := context.actual_class_type
				a_class := context.current_class
			elseif target.target /= Void then
					-- Target is an entity
				target_ast.type_check
				target_type ?= context.item

				if target_type /= Void then
					a_class := target_type.associated_class
				end
			elseif target.expression /= Void then
					-- Target is an expression
				target_ast.type_check
				target_type ?= context.item
				if target_type /= Void then
					a_class := target_type.associated_class
					context.pop (1)
					context.replace (target_type)
				end
			elseif target.class_type /= Void then
					-- Target is {TYPE}
				target_type ?= target.type_a
					-- A void target_type means that it is `NONE'
					-- and we do not accept this.
				if target_type /= Void then
					a_class := target_type.associated_class
					context.replace (target_type)
				end
			else
					-- Closed Current target; feature comes from
					-- current class
				target_ast.type_check
				target_type := context.actual_class_type
				a_class := context.current_class
			end

			if target_type = Void or else target_type.is_basic then
					-- Was not a class type or is basic.
					-- Not supported. May change in the future - M.S.
					-- Reason: We cannot call a feature with basic
					-- call target!
				create not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Type of target in a delayed %
					%call may not be a basic type or NONE.")
				if target /= Void then
					not_supported.set_location (target.start_location)
				else
					not_supported.set_location (feature_name)
				end
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

			-- Type check the call
			call_ast.type_check
			context.pop (1)

			-- Check that it's a function or procedure
			-- which is not external.

			a_table := a_class.feature_table
			a_feature := a_table.item (feature_name)

			if
				(a_feature = Void) or else
				(not a_feature.is_routine or else
				a_feature.is_external)
			then
				create  not_supported
				context.init_error (not_supported)
				not_supported.set_message ("Agent creation on `" + feature_name + "' is%
					% not supported because it is either an attribute, a constant or%
					% an external feature")
				not_supported.set_location (feature_name)
				Error_handler.insert_error (not_supported)
			else
					-- Dependance
				create  depend_unit.make_with_level (a_class.class_id, a_feature,
					context.depend_unit_level)
				context.supplier_ids.extend (depend_unit)

				type := routine_type (a_table, a_feature, a_class.class_id)
				System.instantiator.dispatch (type, context.current_class)
				context.put (type)
			end
			Error_handler.checksum
		end
	

	byte_node: ROUTINE_CREATION_B is
			-- Associated byte code.
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			access_b: ACCESS_B
			target_b: EXPR_B
			tuple_b: TUPLE_CONST_B
			new_list, blist: BYTE_LIST [BYTE_NODE]
			tuple_type_i: TUPLE_TYPE_I
			op: OPERAND_B
			p : PARAMETER_B
			int: INTEGER_CONSTANT
			open_b: ARRAY_CONST_B
			l_void: VOID_B
		do
			a_class := target_type.associated_class
			a_table := a_class.feature_table
			a_feature := a_table.item (feature_name)

			create Result

			if target_ast /= Void then
					-- Closed target
				target_b ?= target_ast.byte_node
			end

			access_b := call_ast.byte_node
			blist := access_b.parameters

				-- Setup closed arguments in `operands_tuple'.
			check
					-- `operands_tuple' should be set in `routine_type'.
				operands_tuple_not_void: operands_tuple /= Void
			end
			create new_list.make_filled (operands_tuple.count)
			new_list.start

				-- Generate fake `ATTRIBUTE_B' instance that corresponds to
				-- a non-initialized value of `operands_tuple'.
			create l_void
			
			if target_b /= Void then
					-- First closed argument is target.
				new_list.put (target_b)
			else
				new_list.put (l_void)
			end
			new_list.forth

			if blist /= Void then
					-- Insert values in `new_list'.
				from
					blist.start
				until
					blist.after
				loop
					p ?= blist.item
					op ?= p.expression
					if op /= Void then
							-- Open operands, we insert Void.
						new_list.put (l_void)
					else
							-- Closed operands, we insert its expression.
						new_list.put (blist.item)
					end
					new_list.forth
					blist.forth
				end
			end

				-- Create TUPLE_CONST_B instance which holds all closed arguments.
			new_list.start
			create tuple_b
			tuple_b.set_expressions (new_list)
			tuple_type_i := (create {TUPLE_TYPE_A}.make (System.tuple_id, operands_tuple)).type_i
			tuple_b.set_type (tuple_type_i)

				-- Setup open_positions
			if open_positions /= Void then
				create new_list.make_filled (open_positions.count)
				from
					new_list.start
					open_positions.start
				until
					open_positions.after
				loop
					create int.make_with_value (open_positions.item)
					new_list.put (int)
					new_list.forth
					open_positions.forth
				end

					-- Create ARRAY_CONST_B which holds all open positions in 
					-- above generated tuple.
				new_list.start
				create open_b
				open_b.set_type (integer_array_type_i)
				open_b.set_expressions (new_list)
			end

				-- Initialize ROUTINE_CREATION_B instance
			Result.init (target_type.type_i, a_class.class_id, a_feature,
						 type.type_i, tuple_b, open_b)
		end

feature {NONE} -- Type

	routine_type (a_table: FEATURE_TABLE; a_feature: FEATURE_I; cid : INTEGER) : GEN_TYPE_A is
			-- Type of routine object.
		require
			valid_table: a_table /= Void;
			valid_feature: a_feature /= Void;
			function_or_procedure: a_feature.is_routine
			not_external: not a_feature.is_external
		local
			t, tgt_type, solved_type:TYPE_A
			generics: ARRAY [TYPE_A]
			args: FEAT_ARG
			oargtypes, argtypes: ARRAY [TYPE_A]
			tuple: TUPLE_TYPE_A
			count, idx, oidx: INTEGER
			operand: OPERAND_AS
			is_open: BOOLEAN
		do

			if a_feature.is_function then
					-- generics are: base_type, open_types, result_type
				create generics.make (1, 3)

				create Result.make (System.function_class_id, generics)

					-- Look for declared type of feature
				solved_type := Creation_evaluator.evaluated_type (
										   a_feature.type, a_table, a_feature
																 )
					-- Find type of feature in context of `target_type'
				solved_type := solved_type.instantiation_in (target_type, cid).deep_actual_type
				generics.put (solved_type, 3)
			else
					-- generics are: base_type, open_types
				create generics.make (1, 2)
				create Result.make (System.procedure_class_id, generics)
			end

				-- FIXME: Emmanuel STAPF 10/27/99
				-- There is a problem where `target_type' contains an anchored declaration
				-- In the later case, we should compute `solved_type' in the feature table
				-- where the object is coming from and not in the feature table where
				-- the Agent is defined.
				-- E.g.: a: A [like x]
				--       x: INTEGER
				--       my_proc (agent a.f)	<- The compiler will complain because it won't
				--                         find in A the type of `like x'.
				-- In the previous example, we should look the feature table of the
				-- `actual_class_type', but if we have `my_proc (agent (a.y).f)', we need
				-- to take the feature table of the real type of `a'.
				--
				-- Note: Emmanuel STAPF 10/04/2000
				-- We now evaluate the target type in the context of the current class instead
				-- of the context of the class corresponding to `target_type'. Doing that it makes
				-- it possible to do what is described in the previous readme but it also enables to
				-- use a generic class with a formal parameter of the current class (previously it
				-- was crashing during the instantiation since the position of the formal was the
				-- one from the current class and if the target class has less generic parameter
				-- than the given position we were crashing, eg:
				--  class A [G, H] and B [G]
				--  f: B [H]
				--  agent f.g
				-- The creation of `agent f.g' crashed because we were looking for the second
				-- formal in B.
			solved_type := Creation_evaluator.evaluated_type (target_type,
				context.current_class.feature_table, a_feature)
			solved_type := solved_type.instantiation_in (context.actual_class_type,
				context.current_class.class_id)
			tgt_type := solved_type.deep_actual_type
			generics.put (tgt_type, 1)

			args := a_feature.arguments

				-- Compute `operands_tuple' and type of TUPLE needed to determine current 
				-- ROUTINE type.

				-- Create `argtypes', array used to initialize type of `operands_tuple'.
				-- This array can hold all arguments of the routine plus Current.
			if args /= Void then
				count := args.count + 1
			else
				count := 1
			end
			create argtypes.make (1, count)


				-- Create `oargtypes'. But first we need to find the `count', number
				-- of open operands.
			if target = Void or else target.class_type /= Void then
					-- No target is specified, or just a class type is specified.
					-- Therefore there is at least one argument
				count := 1
				oidx := 2
			else
					-- Target was specified
				count := 0
				oidx  := 1
			end

				-- Compute number of open positions.
			if operands /= Void then
				from
					operands.start
				until
					operands.after
				loop
					if operands.item.is_open then
						count := count + 1
					end
					operands.forth
				end
			else
				if args /= Void then
					count := count + args.count
				end
			end

				-- Create `oargytpes' with `count' parameters. This array
				-- is used to create current ROUTINE type.
			create oargtypes.make (1, count)

			if count > 0 then
				create open_positions.make (count)
				if oidx > 1 then
						-- Target is open, so insert it.
					open_positions.extend (1)
					oargtypes.put (tgt_type, 1)
				end
			end

				-- Always insert target's type in `argtypes' as first argument.
			argtypes.put (tgt_type, 1)

				-- Create argument types
			if args /= Void then
				from
						-- `idx' is 2, because at position `1' we have target of call.
					idx := 2
					args.start
					if operands /= Void then
						operands.start
					end
				until
					args.after
				loop
					t := Void
					is_open := False

						-- Let's find out if this is really an open operand.
					if operands /= Void then
						operand := operands.item
						if operand.is_open then
							is_open := True
						end

						if operand.class_type /= Void then
								-- Use type specification
							t := operand.type_a
						end
					else
						is_open := True
					end

						-- Get type of operand.
					if is_open then
						if t = Void then
							t := args.item.actual_type
						end
					else
						t := args.item.actual_type
					end

						-- Evaluate type of operand in current context
					solved_type := Creation_evaluator.evaluated_type (t, a_table, a_feature)
					solved_type := solved_type.instantiation_in (target_type, cid).deep_actual_type

						-- If it is open insert it in `oargtypes' and insert
						-- position in `open_positions'.
					if is_open then
						oargtypes.put (solved_type, oidx)
						open_positions.extend (idx)
						oidx := oidx + 1
					end

						-- Add type to `argtypes'.
					argtypes.put (solved_type, idx)

					idx := idx + 1
					args.forth

					if operands /= Void then
						operands.forth
					end
				end
			end

				-- Create open argument type tuple
			create tuple.make (System.tuple_id, oargtypes)
				-- Insert it as second generic parameter of ROUTINE.
			generics.put (tuple, 2)

				-- Set `operands_tuple'
			operands_tuple := argtypes
		ensure
			exists: Result /= Void and operands_tuple /= Void
		end

	integer_array_type_i : GEN_TYPE_I is

		local
			type_a : GEN_TYPE_A
			generics : ARRAY [TYPE_A]        
			int_a: INTEGER_A
		once
			create generics.make (1,1)
			create  int_a.make (32)
			generics.put (int_a, 1)
			create type_a.make (System.array_id, generics)

			Result := type_a.type_i
		end

invariant
	feature_name_not_void: feature_name /= Void
	call_ast_not_void: call_ast /= Void

end -- class ROUTINE_CREATION_AS



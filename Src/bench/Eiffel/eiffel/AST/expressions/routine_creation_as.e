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
			type_check, byte_node,
			fill_calls_list, replicate
		end

	SHARED_TYPES
	SHARED_EVALUATOR

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; f: like feature_name; o: like operands) is
			-- Create a new ROUTINE_CREATION AST node.
		require
			f_not_void: f /= Void
		local
			access_feat_as: DELAYED_ACCESS_FEAT_AS
			access_id_as: ACCESS_ID_AS
		do
			target := t
			feature_name := f
			operands := o
			if target /= Void then
				if target.target /= Void then
						-- Target is an entity
					!!access_id_as
					access_id_as.set_feature_name (target.target)
					target_ast := access_id_as
				else
					if target.expression /= Void then
							-- Target is an expression
						target_ast := target.expression
					else
						if target.class_type = Void then
							if target.is_result then
									-- Target is Result
								create {RESULT_AS} target_ast
							else
									-- Target is Current
								create {CURRENT_AS} target_ast
							end
						end
					end
				end
			end

			!! access_feat_as.make (feature_name, operands)
			call_ast := access_feat_as
		ensure
			target_set: target = t
			feature_name_set: feature_name = f
			operands_set: operands = o
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

	open_map: ARRAY [INTEGER]
			-- Maps i'th open operand to its position.

	closed_map: ARRAY [INTEGER]
			-- Maps i'th closed operand to its position.

	closed_type: TUPLE_TYPE_A
			-- Type of closed argument tuple.

	target_ast: AST_EIFFEL
			-- Ast created for target during type checking.

	call_ast: DELAYED_ACCESS_FEAT_AS
			-- Ast created for delayed call during type checking.

	type : GEN_TYPE_A
			-- Type of routine object.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a routine creation expression.
		local
			a_class: CLASS_C
			a_feature: FEATURE_I
			a_table: FEATURE_TABLE
			depend_unit: DEPEND_UNIT
			vxxx: VXXX
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
				a_class := context.a_class
			else
				if target.target /= Void then
					-- Target is an entity
					target_ast.type_check
					target_type ?= context.item

					if target_type /= Void then
						a_class := target_type.associated_class
					end
				else
					if target.expression /= Void then
						-- Target is an expression
						target_ast.type_check
						target_type ?= context.item
						if target_type /= Void then
							a_class := target_type.associated_class
							context.pop (1)
							context.replace (target_type)
						end
					else
						if target.class_type /= Void then
								-- Target is {TYPE}
							target_type := target.type_a
								-- A void target_type means that it is `NONE'
								-- and we do not accept this.
							if target_type /= Void then
								a_class := target_type.associated_class
								context.replace (target_type)
							end
						else
								-- Target is Current
							target_ast.type_check
							if target.is_result then
								target_type ?= context.feature_type
								a_class := target_type.associated_class
							else
								target_type := context.actual_class_type
								a_class := context.a_class
							end
						end
					end
				end
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

			if (a_feature = Void) 
					or else
				(not (a_feature.is_function or else a_feature.is_procedure)
					or else
				a_feature.is_external) then
				!! vxxx
				context.init_error (vxxx)
				vxxx.set_address_name (feature_name)
				Error_handler.insert_error (vxxx)
			else
					-- Dependance
				!! depend_unit.make (a_class.class_id, a_feature)
				context.supplier_ids.extend (depend_unit)

				type := routine_type (a_table, a_feature, a_class.class_id)
				System.instantiator.dispatch (type, context.a_class)
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
			idx, cnt: INTEGER
			op: OPERAND_B
			p : PARAMETER_B
			int: INTEGER_CONSTANT
			open_b, closed_b: ARRAY_CONST_B
		do
			a_class := target_type.associated_class
			a_table := a_class.feature_table
			a_feature := a_table.item (feature_name)

			!!Result

			if target_ast /= Void then
				-- Closed target
				target_b ?= target_ast.byte_node
			end

			access_b := call_ast.byte_node
			blist := access_b.parameters

			-- Setup the closed arguments.
			if closed_map /= Void then
				!!new_list.make_filled (closed_map.count)
				new_list.start
				
				idx := 0
				if target_b /= Void then
					-- First closed argument is the target.
					new_list.put (target_b)
					new_list.forth
					idx := 1
				end

				if blist /= Void then
					from
						blist.start
					until
						blist.after
					loop
						p ?= blist.item
						op ?= p.expression
						if op = Void then
							new_list.put (blist.item)
							new_list.forth
							idx := idx+1
						end
						blist.forth
					end
				end
			end

			if new_list /= Void then
				new_list.start
				!!tuple_b
				tuple_b.set_expressions (new_list)
				tuple_type_i := closed_type.type_i
				tuple_b.set_type (tuple_type_i)
			end

			-- Setup open map

			if open_map /= Void then
				cnt := open_map.count
				!!new_list.make_filled (cnt)
				from
					new_list.start
					idx := 1
				until
					idx > cnt
				loop
					create int.make (open_map.item (idx))
					new_list.put (int)
					idx := idx + 1
					new_list.forth
				end
				new_list.start
				!!open_b
				open_b.set_type (integer_array_type_i)
				open_b.set_expressions (new_list)
			end

			-- Setup closed map

			if closed_map /= Void then
				cnt := closed_map.count
				!!new_list.make_filled (cnt)
				from
					new_list.start
					idx := 1
				until
					idx > cnt
				loop
					create int.make (closed_map.item (idx))
					new_list.put (int)
					idx := idx + 1
					new_list.forth
				end
				new_list.start
				!!closed_b
				closed_b.set_type (integer_array_type_i)
				closed_b.set_expressions (new_list)
			end

			Result.init (target_type.type_i, a_class.class_id, a_feature,
						 type.type_i, tuple_b, open_b, closed_b)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- Find calls to Current.
		do
			if target_ast /= Void then
				target_ast.fill_calls_list (l)
				l.stop_filling
			end
			if call_ast /= Void then
				call_ast.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication.
		do
			Result := clone (Current)
			ctxt.adapt_name (feature_name)
			Result.set_feature_name (ctxt.adapted_name)

			if operands /= Void then
				Result.set_operands (operands.replicate (ctxt.new_ctxt))
			end

			if target /= Void then
				Result.set_target (target.replicate (ctxt.new_ctxt))
			end

			if target_ast /= Void then
				Result.set_target_ast (target_ast.replicate (ctxt.new_ctxt))
			end

			if call_ast /= Void then
				Result.set_call_ast (call_ast.replicate (ctxt.new_ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			dummy_call: ACCESS_FEAT_AS
			dummy_name: ID_AS
		do
			ctxt.put_text_item (ti_Agent_keyword)
			ctxt.put_space
			if target /= Void then
				if
					target.class_type /= Void or
					target.expression /= Void or
					target.target /= Void or
					target.is_result
				then
					if target_ast /= Void then
							-- A closed operand for target.
						ctxt.format_ast (target_ast)
					else
						ctxt.put_text_item (ti_L_curly)
						ctxt.format_ast (target.class_type)
						ctxt.set_type_creation (target.class_type)

							--| We have to create a dummy call because the current formating
							--| algorithm which makes the assumption that a feature call is
							--| either on Current or on something else (see CREATION_EXPR_AS).
						create dummy_call
						create dummy_name.initialize (ti_R_curly.image)
						dummy_call.set_feature_name (dummy_name)
						ctxt.format_ast (dummy_call)
					end
					ctxt.need_dot
				else
					-- No operand for target.
				end
			else
					-- An open operand for target.
				ctxt.put_text_item (Ti_question)
				ctxt.need_dot
			end

				-- Display routine used by the Agent.
			ctxt.format_ast (call_ast)

			ctxt.set_type_creation (Void)
		end

feature {ROUTINE_CREATION_AS} -- Replication

	set_target (t : like target) is
			-- Set `target' to `t'.
		do
			target := t
		end

	set_target_ast (t : like target_ast) is
			-- Set `target_ast' to `t'.
		do
			target_ast := t
		end

	set_feature_name (f : like feature_name) is
			-- Set `feature_name' to `f'.
		do
			feature_name := f
		end

	set_operands (o : like operands) is
			-- Set `operands' to `o'.
		do
			operands := o
		end

	set_call_ast (c : like call_ast) is
			-- Set `call_ast' to `c'.
		do
			call_ast := c
		end

feature {NONE} -- Type

	routine_type (a_table: FEATURE_TABLE; a_feature: FEATURE_I; cid : INTEGER) : GEN_TYPE_A is
			-- Type of routine object.
		require
			valid_table: a_table /= Void;
			valid_feature: a_feature /= Void;
			function_or_procedure: a_feature.is_function or else
								   a_feature.is_procedure;
			not_external: not a_feature.is_external
		local
			t, tgt_type, solved_type:TYPE_A
			generics: ARRAY [TYPE_A]
			args: FEAT_ARG
			oargtypes, cargtypes: ARRAY [TYPE_A]
			tuple: TUPLE_TYPE_A
			count, idx, oidx, cidx: INTEGER
			operand: OPERAND_AS
			is_open: BOOLEAN
		do

			if a_feature.is_function then
					-- generics are: base_type, open_types, result_type
				create generics.make (1, 3)

				create Result.make (generics)
				Result.set_base_class_id (System.function_class_id)


					-- Look for declared type of feature
				solved_type := Creation_evaluator.evaluated_type (
										   a_feature.type, a_table, a_feature
																 )
					-- Find type of feature in context of `target_type'
				solved_type := solved_type.instantiation_in (target_type, cid)
				generics.put (solved_type.deep_actual_type, 3)
			else
					-- generics are: base_type, open_types
				create generics.make (1, 2)

				create Result.make (generics)
				Result.set_base_class_id (System.procedure_class_id)
			end

				-- FIXME: Emmanuel STAPF 10/27/99
				-- There is a problem where `target_type' contains an anchored declaration
				-- In the later case, we should compute `solved_type' in the feature table
				-- where the object is coming from and not in the feature table where
				-- the Agent is defined.
				-- E.g.: a: A [like x]
				--       x: INTEGER
				--       my_proc (a~f)	<- The compiler will complain because it won't
				--                         find in A the type of `like x'.
				-- In the previous example, we should look the feature table of the
				-- `actual_class_type', but if we have `my_proc ((a.y)~f)', we need
				-- to take the feature table of the real type of `a'.
				--
				-- Note: Emmanuel STAPF 10/04/2000
				-- We now evaluate the target type in the context of the current class instead
				-- of the context of the class corresponding to `target_type'. Doing that it makes
				-- it possible to do what is described in the previous readme but it also enables to
				-- use a generic class with a formal parameter of the current class (previously it
				-- was crashing during the instantiation since the position of the formal was the one
				-- from the current class and if the target class has less generic parameter than the
				-- given position we were crashing, eg:
				--  class A [G, H] and B [G]
				--  f: B [H]
				--  f~g
				-- The creation of `f~g' crashed because we were looking for the second formal in B.
			solved_type := Creation_evaluator.evaluated_type (target_type, context.a_class.feature_table, a_feature)
			solved_type := solved_type.instantiation_in (context.actual_class_type, context.a_class.class_id)
			tgt_type := solved_type.deep_actual_type
			generics.put (tgt_type, 1)

			args := a_feature.arguments

			-- Setup mapping

			count := 0
			oidx  := 1
			cidx  := 1

			if target = Void or else target.class_type /= Void then
				count := 1
				oidx := 2
			else
				cidx := 2
			end

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

			create oargtypes.make (1, count)

			if count > 0 then
				create open_map.make (1, count)
				if oidx > 1 then
					open_map.put (0,1)
					oargtypes.put (tgt_type,1)
				end
			end

			if args /= Void then
				count := args.count + 1 - count
			else
				count := 1 - count
			end

			create cargtypes.make (1, count)

			if count > 0 then
				create closed_map.make (1, count)
				if cidx > 1 then
					closed_map.put (0,1)
					cargtypes.put (tgt_type,1)
				end
			end

				-- Create argument types
			if args /= Void then
				from
					idx := 1
					args.start
					if operands /= Void then
						operands.start
					end
				until
					args.after
				loop
					t := Void
					is_open := False

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

					if is_open then
						if t = Void then
							t := args.item.actual_type
						end

						solved_type := Creation_evaluator.evaluated_type (
														t, a_table, a_feature
																		 )
						solved_type := solved_type.instantiation_in (target_type, cid)

						oargtypes.put (solved_type.deep_actual_type, oidx)
						open_map.put (idx, oidx)
						oidx := oidx + 1
					else
						t := args.item.actual_type

						solved_type := Creation_evaluator.evaluated_type (
														t, a_table, a_feature
																		 )
						solved_type := solved_type.instantiation_in (target_type, cid)

						cargtypes.put (solved_type.deep_actual_type, cidx)
						closed_map.put (idx, cidx)
						cidx := cidx + 1
					end

					idx := idx + 1
					args.forth

					if operands /= Void then
						operands.forth
					end
				end
			end

				-- Create open argument type tuple
			create tuple.make (oargtypes)
			tuple.set_base_class_id (System.tuple_id)

			generics.put (tuple, 2)

				-- Create closed argument type tuple
			create tuple.make (cargtypes)
			tuple.set_base_class_id (System.tuple_id)

			closed_type := tuple
		ensure
			exists: Result /= Void and closed_type /= Void
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
			create type_a.make (generics)
			type_a.set_base_class_id (System.array_id)

			Result := type_a.type_i
		end

end -- class ROUTINE_CREATION_AS



indexing
	description: "Node for a creation instruction."
	date: "$Date$"
	revision: "$Revision$"

class CREATION_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node
		end

	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

	SHARED_EVALUATOR
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (tp: like type; tg: like target; c: like call; l: like location) is
			-- Create a new CREATION AST node.
		require
			tg_not_void: tg /= Void
			l_not_void: l /= Void
		local
			dcr_id: ID_AS
		do
			type := tp
			target := tg
			call := c
			location := clone (l)

				-- If there is no call we create `default_call'
			if call = Void then
					-- Create id. True name set later.
				create dcr_id.make (0)
				create {ACCESS_ID_AS} default_call
				default_call.set_feature_name (dcr_id)
			end
		ensure
			type_set: type = tp
			target_set: target = tg
			call_set: call = c
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_as (Current)
		end

feature -- Attributes

	type: TYPE
			-- Creation type

	target: ACCESS_AS
			-- Target to create

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

	default_call: ACCESS_INV_AS
			-- Default creation call

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (target, other.target) and then
				equivalent (type, other.type)
		end

feature -- Type check, byte code and dead code removal

	perform_type_check is
			-- Type check a creation instruction
		local
			access: ACCESS_B
			creation_type, new_creation_type: TYPE_A
			creation_class: CLASS_C
			feature_name: STRING
			a_feature: FEATURE_I
			export_status: EXPORT_I
			create_info: CREATE_INFO
			feature_type, local_type: TYPE_A
			local_b: LOCAL_B
			attribute_b: ATTRIBUTE_B
			creators: HASH_TABLE [EXPORT_I, STRING]
			depend_unit: DEPEND_UNIT
			vgcc1: VGCC1
			vgcc11: VGCC11
			vgcc2: VGCC2
			vgcc3: VGCC3
			vgcc31: VGCC31
			vgcc4: VGCC4
			vgcc5: VGCC5
			vgcc7: VGCC7
			vtcg3: VTCG3
			vtug: VTUG
			vtec1: VTEC1
			vtec2: VTEC2
			gen_type: GEN_TYPE_A
			formal_type: FORMAL_A
			formal_dec: FORMAL_DEC_AS
			is_formal_creation, is_default_creation: BOOLEAN
			dcr_feat: FEATURE_I
			the_call: like call
		do
				-- Init the type stack
			context.begin_expression

				-- Type check access
			target.type_check

				-- Last access: if error happened, then routine
				-- `type_check' of ACCESS_FEAT_AS will raise an error, so
				-- it is sure than we have the good access on the access line
			check
				access_exists: context.access_line.access /= Void
			end
			access := context.access_line.access

			creation_type := context.item
				-- Entity to create can only be an attribute, a local variable
				-- a constraint generic parameter with creation clause or Result
			if not access.is_creatable then
				create vgcc7
				context.init_error (vgcc7)
				vgcc7.set_target_name (target.access_name)
				vgcc7.set_type (creation_type)
				Error_handler.insert_error (vgcc7)
					-- Cannot go on here
				Error_handler.raise_error
			end

			if creation_type.is_formal then
					-- Cannot be Void
				formal_type ?= creation_type
					-- Get the corresponding constraint type of the current class
				formal_dec := context.current_class.generics.i_th (formal_type.position)
				if formal_dec.has_constraint and then formal_dec.has_creation_constraint then
					creation_type := formal_dec.constraint_type
					is_formal_creation := True
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because there is no creation routine constraints
					create vgcc1
					context.init_error (vgcc1)
					vgcc1.set_target_name (target.access_name)
					Error_handler.insert_error (vgcc1);					
				end
			end

			Error_handler.checksum

			if creation_type.is_none then
					-- An entity of type NONE cannot be created
				create vgcc3
				context.init_error (vgcc3)
				vgcc3.set_target_name (target.access_name)
				vgcc3.set_type (creation_type)
				Error_handler.insert_error (vgcc3)
			else
				if type /= Void then
						-- Check specified creation type
					if type.has_like then
							-- We need to evaluate `type' in context of current class
							-- and current feature.
						new_creation_type := creation_evaluator.evaluated_type (
							type, Context.feature_table, Context.current_feature)
					else
						new_creation_type := type.actual_type
					end
					if new_creation_type /= Void then
						if is_formal_creation then
							create vgcc3
							context.init_error (vgcc3)
							vgcc3.set_target_name (target.access_name)
							vgcc3.set_type (creation_type)
							Error_handler.insert_error (vgcc3)
						elseif new_creation_type.has_expanded then
							if new_creation_type.expanded_deferred then
								create vtec1
								context.init_error (vtec1)
								vtec1.set_entity_name (target.access_name)
								Error_handler.insert_error (vtec1)
							elseif not new_creation_type.valid_expanded_creation (context.current_class) then
								create vtec2
								context.init_error (vtec2)
								vtec2.set_entity_name (target.access_name)
								Error_handler.insert_error (vtec2)
							end
						end
						if not new_creation_type.good_generics then
							vtug := new_creation_type.error_generics
							vtug.set_class (context.current_class)
							vtug.set_feature (context.current_feature)
							Error_handler.insert_error (vtug)
							Error_handler.raise_error
						elseif
							new_creation_type.is_none or else
							(creation_type.is_true_expanded and then new_creation_type.is_true_expanded
							and then not new_creation_type.same_as (creation_type))
						then
								-- Cannot create instance of NONE
								-- Or we cannot create an expanded type that is not the same
								-- as the type of target itself expanded.
							create vgcc3
							context.init_error (vgcc3)
							vgcc3.set_target_name (target.access_name)
							vgcc3.set_type (creation_type)
							Error_handler.insert_error (vgcc3)
						elseif
							not new_creation_type.conform_to (creation_type)
						then
								-- Specified creation type must conform to
								-- the entity type
							create vgcc31
							context.init_error (vgcc31)
							vgcc31.set_target_name (target.access_name)
							vgcc31.set_type (creation_type)
							Error_handler.insert_error (vgcc31)
						else
							new_creation_type.reset_constraint_error_list
							new_creation_type.check_constraints (context.current_class)
							if not new_creation_type.constraint_error_list.is_empty then
								create vtcg3
								vtcg3.set_class (context.current_class)
								vtcg3.set_feature (context.current_feature)
								vtcg3.set_entity_name (target.access_name)
								vtcg3.set_error_list (new_creation_type.constraint_error_list)
								Error_handler.insert_error (vtcg3)
							else
								creation_type := new_creation_type
								gen_type ?= creation_type
								if gen_type /= Void then
									Instantiator.dispatch (gen_type, context.current_class)
								end
		
									-- Update type stack
								context.replace (creation_type)
									-- Update the access line
								access := access.creation_access (creation_type.type_i)
								context.access_line.change_item (access)
							end
						end
					else
							-- Cannot create instance of `type'.
							--| Most probably a BITS_SYMBOLS_AS
						create vgcc3
						context.init_error (vgcc3)
						vgcc3.set_target_name (target.access_name)
						vgcc3.set_is_symbol
						vgcc3.set_symbol_name (type.dump)
						Error_handler.insert_error (vgcc3)
					end
				end
				Error_handler.checksum

				creation_class := creation_type.associated_class
				if creation_class.is_deferred and then not is_formal_creation then
						-- Associated class cannot be deferred
					create vgcc2
					context.init_error (vgcc2)
					vgcc2.set_target_name (target.access_name)
					vgcc2.set_type (creation_type)
					Error_handler.insert_error (vgcc2)
					Error_handler.raise_error
				end

				if
					call = Void and then
					(creation_class.allows_default_creation or
					(is_formal_creation and then formal_dec.has_default_create))
				then
					if not is_formal_creation then
						dcr_feat := creation_class.default_create_feature
					else
						dcr_feat := creation_class.feature_table.feature_of_rout_id (
											System.default_create_id)
					end

						-- Use default_create
						-- if it actually does something or if it is a formal
						-- creation (because we need to keep the call for polymorphic
						-- reasons).
					if is_formal_creation or else not dcr_feat.is_empty then
						default_call.feature_name.load (dcr_feat.feature_name)
						the_call := default_call
					else
							-- We insert creation without call to creation procedure
							-- in list of dependences of current feature.
						create depend_unit.make_emtpy_creation_unit (creation_class.class_id,
							dcr_feat)
						context.supplier_ids.extend (depend_unit)
					end
					is_default_creation := True
				else
					the_call := call
				end

				creators := creation_class.creators

				if the_call /= Void then
						-- Type check the call: note that the creation
						-- type is on the type stack
					the_call.type_check
					feature_name := the_call.feature_name

					if not is_formal_creation then
							-- Check if creation routine is non-once procedure
						if
							not creation_class.valid_creation_procedure (feature_name)
						then
							create vgcc5
							context.init_error (vgcc5)
							vgcc5.set_target_name (target.access_name)
							vgcc5.set_type (creation_type)
							a_feature := creation_class.feature_table.item (feature_name)
							vgcc5.set_creation_feature (a_feature)
							Error_handler.insert_error (vgcc5)
						elseif creators /= Void then
							export_status := creators.item (feature_name)
							if not export_status.valid_for (context.current_class) then
									-- Creation procedure is not exported
								create vgcc5
								context.init_error (vgcc5)
								vgcc5.set_target_name (target.access_name)
								vgcc5.set_type (creation_type)
								a_feature := creation_class.feature_table.item (feature_name)
								vgcc5.set_creation_feature (a_feature)
								Error_handler.insert_error (vgcc5)
							end
						end
					else
							-- Check that the creation feature used for creating the generic
							-- parameter has been listed in the constraint for the generic
							-- parameter.
						if not formal_dec.has_creation_feature_name (feature_name) then
							create vgcc11
							context.init_error (vgcc11)
							vgcc11.set_target_name (target.access_name)
							a_feature := creation_class.feature_table.item (feature_name)
							vgcc11.set_creation_feature (a_feature)
							Error_handler.insert_error (vgcc11)
						end
					end
				else
					if not is_formal_creation then
						if (creators = Void) or is_default_creation then
						elseif creators.is_empty then
							create vgcc5
							context.init_error (vgcc5)
							vgcc5.set_target_name (target.access_name)
							vgcc5.set_type (creation_type)
							vgcc5.set_creation_feature (Void)
							Error_handler.insert_error (vgcc5)
						else
							create vgcc4
							context.init_error (vgcc4)
							vgcc4.set_target_name (target.access_name)
							vgcc4.set_type (creation_type)
							Error_handler.insert_error (vgcc4)
						end
					else
							-- An entity of type a formal generic parameter cannot be
							-- created here because we need a creation routine call
						create vgcc1
						context.init_error (vgcc1)
						vgcc1.set_target_name (target.access_name)
						Error_handler.insert_error (vgcc1);				
					end
				end
			end
			Error_handler.checksum

				-- Compute creation information
			if formal_type /= Void then
				create {CREATE_FORMAL_TYPE} create_info.make (formal_type.type_i)
			elseif type /= Void then
				create_info := creation_type.create_info
			elseif access.is_result then
				feature_type ?= context.current_feature.type
				create_info := feature_type.create_info
			elseif access.is_local then
				local_b ?= access
				local_type := context.local_ith (local_b.position).type
				create_info := local_type.create_info
			elseif access.is_attribute then
				attribute_b ?= access
				create {CREATE_FEAT} create_info.make (attribute_b.attribute_id,
					attribute_b.routine_id, context.current_class)
			end
			context.creation_infos.insert (create_info)
			context.creation_types.insert (creation_type.actual_type.type_i)
			
			check
				not creation_type.actual_type.type_i.is_void
			end

				-- Update type stack
			context.pop (1)
		end

	byte_node: ASSIGN_B is
			-- Byte code for creation instruction
		local
			l_create_info: CREATE_INFO
			l_type: TYPE_I
			l_access: ACCESS_B
			l_call_access: CALL_ACCESS_B
			the_call: like call
			l_creation_expr: CREATION_EXPR_B
		do
			l_access := target.byte_node

			create l_creation_expr

			if default_call = Void or else default_call.feature_name.is_empty then
				the_call := call
			else
				the_call := default_call
			end

			if the_call /= Void then
				l_call_access ?= the_call.byte_node
				check
					has_valid_call: l_call_access /= Void
				end
				l_creation_expr.set_call (l_call_access)
			end

				-- Cannot be Void since the only thing that we put is of type CREATION_TYPE
				-- for a CREATION_EXPR_B
			l_create_info := context.creation_infos.item
			context.creation_infos.forth
			check
				l_create_info_not_void: l_create_info /= Void
			end

			l_type := context.creation_types.item
			context.creation_types.forth
			check
				l_type_not_void: l_type /= Void
			end
			
			l_creation_expr.set_info (l_create_info)
			l_creation_expr.set_type (l_type)
			l_creation_expr.set_line_number (line_number)
			
			create Result
			Result.set_target (l_access)
			Result.set_source (l_creation_expr)
			Result.set_line_number (line_number)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_create_keyword)
			ctxt.put_space
			if type /= Void then
				ctxt.put_text_item (ti_l_curly)
				ctxt.format_ast (type)
				ctxt.put_text_item_without_tabs (ti_r_curly)
				ctxt.put_space
			end
			ctxt.format_ast (target)
			if type /= Void then
				ctxt.set_type_creation (type)
			end
			if call /= Void then
				ctxt.need_dot
				ctxt.format_ast (call)
			end
		end

feature {CREATION_AS} -- Replication

	set_call (c: like call) is
		do
			call := c
		end

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end

end -- class CREATION_AS

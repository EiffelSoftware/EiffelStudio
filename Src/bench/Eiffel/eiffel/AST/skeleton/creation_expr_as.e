indexing
	description: "Abstract description of an Eiffel creation expression call."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_AS

inherit
	CALL_AS
		rename
			position as start_position
		redefine
			type_check, is_equivalent, line_number, start_position
		end

	SHARED_INSTANTIATOR

feature {AST_FACTORY} -- Initialization

	initialize (t: like type; c: like call; s, l: INTEGER) is
			-- Create a new CREATION_EXPR AST node.
		require
			t_not_void: t /= Void
		local
			dcr_id : ID_AS
		do
			type := t
			call := c
			start_position := s
			line_number := l

				-- If there's no call create 'default_call'
			if call = Void then
					-- Create id. True name set later.
				create dcr_id.make (0)
				create default_call
				default_call.set_feature_name (dcr_id)
			end
		ensure
			type_set: type = t
			call_set: call = c
			start_position_set: start_position = s
			line_number_set: line_number = l
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			dummy_call: ACCESS_INV_AS
			dummy_name: ID_AS
		do
			ctxt.put_text_item (ti_Create_keyword)
			ctxt.put_space
			ctxt.put_text_item (ti_L_curly)
			ctxt.format_ast (type)

			if call /= Void then
					--| We have to create a dummy call because the current formating
					--| algorithm which makes the assumption that a feature call is
					--| either on Current or on something else.
					--| In the case of creation expression there is no current or no
					--| something else, so we create a dummy call which only goal is
					--| to set some properties of FORMAT_CONTEXT and LOCAL_FEAT_ADAPTATION
					--| to their correct value and then pass them to the real call, that
					--| way `call' is correctly formatted thanks to the information provided
					--| by the call to `dummy_call.format'.
					--| GB 12/13/2000: Changed dummy_name from " " to "}" to avoid
					--| useless space.
				create dummy_call
				create dummy_name.initialize (ti_R_curly.image)
				dummy_call.set_feature_name (dummy_name)
				ctxt.format_ast (dummy_call)
				ctxt.set_type_creation (type)
				ctxt.need_dot
				ctxt.format_ast (call)
			else
					--| Simply calling put_text_item doesn't work:
					--| the context local_adapt must change.
					--| Yeah yeah I know it's not really clean,
					--| but if you want to redo completely the text generation, go on.
				create dummy_call
				create dummy_name.initialize (ti_R_curly.image)
				dummy_call.set_feature_name (dummy_name)
				ctxt.format_ast (dummy_call)
			end

				--| If a dot call follows, it has to be relative to `type'.
			ctxt.set_type_creation (type)
		end

feature -- Access

	line_number : INTEGER

	start_position: INTEGER
			-- Start position of AST

	type: TYPE
			-- Creation Type.

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

	default_call : ACCESS_INV_AS
			-- Call to default create.

feature -- Type check

	type_check is
			-- Type check an access to a creation feature.
		local
			new_creation_type, creation_type: TYPE_A
			gen_type: GEN_TYPE_A
			creation_class: CLASS_C
			a_feature: FEATURE_I
			export_status, context_export: EXPORT_I
			create_type: CREATE_TYPE
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			depend_unit: DEPEND_UNIT
			feature_name: STRING
			vgcc1: VGCC1
			vgcc11: VGCC11
			vgcc2: VGCC2
			vgcc3: VGCC3
			vgcc4: VGCC4
			vgcc5: VGCC5
			vtcg3: VTCG3
			vtec1: VTEC1
			vtec2: VTEC2
			vtug: VTUG
			vape: VAPE
			not_supported: NOT_SUPPORTED
			formal_type: FORMAL_A
			formal_dec: FORMAL_DEC_AS
			is_formal_creation, is_default_creation: BOOLEAN
			dcr_feat: FEATURE_I
			the_call: like call
		do
				-- We need to remove from the stack the first element, since it
				-- has been added by EXPR_CALL_AS and it does not correspond to
				-- what we want to put, cad the type of the source.
				--| Type information will be added at the very end
			context.pop (1)

				-- Initialize the type stack, this information will be updated later
				-- just after `call.type_check'
			context.begin_expression

			if type.has_like then
				-- FIXME
				-- !like a! is not supported in 3.2
				-- The resolution of the type should be done
				-- as the one for local variables (call to
				-- local_evalutor and use of solved typecreate )
				create not_supported
				context.init_error (not_supported)
				not_supported.set_message ("An anchored type cannot be used as an explicit creation type")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

				-- Entity to create is of the type specified between the curlies.
			new_creation_type := type.actual_type

			if new_creation_type.has_expanded then
				if new_creation_type.expanded_deferred then
					create vtec1
					context.init_error (vtec1)
					Error_handler.insert_error (vtec1)
				elseif not new_creation_type.valid_expanded_creation (context.current_class) then
					create vtec2
					context.init_error (vtec2)
					Error_handler.insert_error (vtec2)
				end
			end

			if new_creation_type.is_formal then
					-- Cannot be Void
				formal_type ?= new_creation_type
					-- Get the corresponding constraint type of the current class
				formal_dec := context.current_class.generics.i_th (formal_type.position)
				if formal_dec.has_constraint and then formal_dec.has_creation_constraint then
					new_creation_type := formal_dec.constraint_type
					is_formal_creation := True
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because there is no creation routine constraints
					create vgcc1
					context.init_error (vgcc1)
					vgcc1.set_target_name ("")
					Error_handler.insert_error (vgcc1);					
				end
			end

			if not new_creation_type.good_generics then
				vtug := new_creation_type.error_generics
				vtug.set_class (context.current_class)
				vtug.set_feature (context.current_feature)
				Error_handler.insert_error (vtug)
				Error_handler.raise_error
			elseif
				new_creation_type.is_none
			then
					-- Cannot create instance of NONE
				create vgcc3
				context.init_error (vgcc3)
				vgcc3.set_target_name ("")
				vgcc3.set_type (new_creation_type)
				Error_handler.insert_error (vgcc3)
			else
				new_creation_type.reset_constraint_error_list
				new_creation_type.check_constraints (context.current_class)
				if not new_creation_type.constraint_error_list.is_empty then
					create vtcg3
					vtcg3.set_class (context.current_class)
					vtcg3.set_feature (context.current_feature)
					vtcg3.set_error_list (new_creation_type.constraint_error_list)
					Error_handler.insert_error (vtcg3)
				else
					creation_type := new_creation_type
					gen_type ?= creation_type
					if gen_type /= Void then
						Instantiator.dispatch (gen_type, context.current_class)
					end
						-- We do not update type stack now, since the call to
						-- `call.type_check' will change the information, we will
						-- do it when `call.type_check' will be done.
				end
			end

				-- Check for errors
			Error_handler.checksum

			creation_class := creation_type.associated_class
			if creation_class.is_deferred and then not is_formal_creation then
					-- Associated class cannot be deferred
				create vgcc2
				context.init_error (vgcc2)
				vgcc2.set_target_name ("")
				vgcc2.set_type (creation_type)
				Error_handler.insert_error (vgcc2)
				Error_handler.raise_error
			end

			if
				call = Void and then
				(creation_class.allows_default_creation or
				(is_formal_creation and then formal_dec.has_default_create))
			then
					-- Use default create
				if not is_formal_creation then
					dcr_feat := creation_class.default_create_feature
				else
					dcr_feat := creation_class.feature_table.feature_of_rout_id (
						System.default_create_id)
				end
				is_default_creation := True
				if is_formal_creation or else not dcr_feat.is_empty then
					default_call.feature_name.load (dcr_feat.feature_name)
					the_call := default_call
				else
						-- We insert creation without call to creation procedure
						-- in list of dependences of current feature.
					create depend_unit.make_emtpy_creation_unit (creation_class.class_id, dcr_feat)
					context.supplier_ids.extend (depend_unit)
				end
			else
				the_call := call
			end

			creators := creation_class.creators

			if the_call /= Void then
				context.replace (creation_type)

					-- Inform the next type checking that we are handling
					-- a creation expression and that this is not needed
					-- to check the VAPE validity of `the_call' if Current
					-- is used in a precondition clause statement.
				context.set_is_in_creation_expression (True)

					-- Type check the call: note that the creation type is on
					-- the type stack.
				the_call.type_check	
				feature_name := the_call.feature_name

					-- But since a creation routine is a feature its TYPE_A is of type
					-- VOID_A which is not what we want here, that's why we need to update
					-- the type now.
				if is_formal_creation then
					context.replace (formal_type)
				else
					context.replace (creation_type)
				end

				if not is_formal_creation then
						-- Check if creation routine is non-once procedure
					if not creation_class.valid_creation_procedure (feature_name) then
						create vgcc5
						context.init_error (vgcc5)
						vgcc5.set_target_name ("")
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
							vgcc5.set_target_name ("")
							vgcc5.set_type (creation_type)
							a_feature := creation_class.feature_table.item (feature_name)
							vgcc5.set_creation_feature (a_feature)
							Error_handler.insert_error (vgcc5)
						else
							if context.level4 then
								context_export := context.current_feature.export_status
								if not context_export.is_subset (export_status) then
									create vape
									context.init_error (vape)
									vape.set_exported_feature (a_feature)
									Error_handler.insert_error (vape)
									Error_handler.raise_error
								end
							end
						end
					end
				else
						-- Check that the creation feature used for creating the generic
						-- parameter has been listed in the constraint for the generic
						-- parameter.
					if not formal_dec.has_creation_feature_name (feature_name) then
						create vgcc11
						context.init_error (vgcc11)
						vgcc11.set_target_name ("")
						a_feature := creation_class.feature_table.item (feature_name)
						vgcc11.set_creation_feature (a_feature)
						Error_handler.insert_error (vgcc11)
					end
				end
			else
				if not is_formal_creation then
					context.replace (creation_type)
					if (creators = Void) or is_default_creation then
					elseif creators.is_empty then
						create vgcc5
						context.init_error (vgcc5)
						vgcc5.set_target_name ("")
						vgcc5.set_type (creation_type)
						vgcc5.set_creation_feature (Void)
						Error_handler.insert_error (vgcc5)
					else
						create vgcc4
						context.init_error (vgcc4)
						vgcc4.set_target_name ("")
						vgcc4.set_type (creation_type)
						Error_handler.insert_error (vgcc4)
					end
				else
						-- An entity of type a formal generic parameter cannot be
						-- created here because we need a creation routine call
					create vgcc1
					context.init_error (vgcc1)
					vgcc1.set_target_name ("")
					Error_handler.insert_error (vgcc1);				
				end
			end

				-- Check for errors
			Error_handler.checksum

				-- Compute creation information
			if is_formal_creation then
				create {CREATE_FORMAL_TYPE} create_type.make (formal_type.type_i)
			else
				create create_type.make (creation_type.type_i)
			end

			context.creation_types.insert (create_type)
		end

feature

	byte_node: CREATION_EXPR_B is
			-- Associated byte code.
		local
			create_type: CREATE_TYPE
			call_access: CALL_ACCESS_B
			feature_b: FEATURE_B
			creation_feature_call: CREATION_EXPR_CALL_B
			the_call: like call
		do
			create Result.make

			if default_call = Void or else default_call.feature_name.is_empty then
				the_call := call
			else
				the_call := default_call
			end

			if the_call /= Void then
				call_access ?= the_call.byte_node
				feature_b ?= call_access

				if feature_b /= Void then
					create {CREATION_FEATURE_B} creation_feature_call
				else
					create {CREATION_EXTERNAL_B} creation_feature_call
				end

				creation_feature_call.fill_from (call_access)
				Result.set_call (creation_feature_call)
			end

				-- Cannot be Void since the only thing that we put is of type CREATION_TYPE
				-- for a CREATION_EXPR_B
			create_type ?= context.creation_types.item
			context.creation_types.forth
			check
				create_type_not_void: create_type /= Void
			end
			
			Result.set_info (create_type)

			Result.set_line_number (line_number)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (type, other.type)
		end

invariant
		-- A creation expression contains its type
	type_exists: type /= Void

end -- class CREATION_EXPR_AS

indexing
	description: "Abstract description of an Eiffel creation expression call."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_AS

inherit
	CALL_AS
		redefine
			type_check, is_equivalent
		end

	SHARED_INSTANTIATOR

feature {AST_FACTORY} -- Initialization

	initialize (t: like type; c: like call) is
			-- Create a new CREATION_EXPR AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			call := c
		ensure
			type_set: type = t
			call_set: call = c
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			type ?= yacc_arg (0)
			call ?= yacc_arg (1)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable
			ctxt.put_text_item (ti_Create_keyword)
			ctxt.put_space
			ctxt.put_text_item (ti_L_curly)
			ctxt.set_type_creation (type)
			ctxt.format_ast (type)
			ctxt.put_text_item (ti_R_curly)
			ctxt.put_space

			if call /= Void then
				ctxt.need_dot
				ctxt.format_ast (call)
			end
		end

feature -- Properties

	type: TYPE
			-- Creation Type

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Type check

	type_check is
			-- Type check an access to a creation feature
		local
			new_creation_type, creation_type: TYPE_A
			feature_type, local_type: TYPE_A
			gen_type: GEN_TYPE_A
			creation_class: CLASS_C
			a_feature: FEATURE_I
			export_status: EXPORT_I
			class_type: CL_TYPE_A
			create_type: CREATE_TYPE
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			depend_unit: DEPEND_UNIT
			feature_name: STRING
			vgcc2: VGCC2
			vgcc3: VGCC3
			vgcc31: VGCC31
			vgcc4: VGCC4
			vgcc5: VGCC5
			vtug: VTUG
			not_supported: NOT_SUPPORTED
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
				-- local_evalutor and use of solved type!!)
				!!not_supported
				context.init_error (not_supported)
				not_supported.set_message ("An anchor type cannot be used as an explicit creation type")
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

				-- Entity to create is of the type specified between the curlies.
			new_creation_type := type.actual_type

			if not new_creation_type.good_generics then
				vtug := new_creation_type.error_generics
				vtug.set_class (context.a_class)
				vtug.set_feature (context.a_feature)
				Error_handler.insert_error (vtug)
				Error_handler.raise_error
			elseif
				new_creation_type.is_none or else
				new_creation_type.is_expanded or else
				not new_creation_type.type_i.is_reference
			then
					-- Cannot create instance of NONE
				!!vgcc3
				context.init_error (vgcc3)
				vgcc3.set_target_name ("")
				vgcc3.set_type (new_creation_type)
				Error_handler.insert_error (vgcc3)
			else
				creation_type := new_creation_type
				gen_type ?= creation_type
				if gen_type /= Void then
					Instantiator.dispatch (gen_type, context.a_class)
				end
					-- We do not update type stack now, since the call to
					-- `call.type_check' will change the information, we will
					-- do it when `call.type_check' will be done.
			end

				-- Check for errors
			Error_handler.checksum

			creation_class := creation_type.associated_class
			if creation_class.is_deferred then
					-- Associated class cannot be deferred
				!!vgcc2
				context.init_error (vgcc2)
				vgcc2.set_target_name ("")
				vgcc2.set_type (creation_type)
				Error_handler.insert_error (vgcc2)
				Error_handler.raise_error
			end

			if call /= Void then
				context.replace (creation_type)
					-- Type check the call: note that the creation type is on
					-- the type stack
				call.type_check	
					-- But since a creation routine is a feature its TYPE_A is of type
					-- VOID_A which is not what we want here, that's why we need to update
					-- the type now.
				context.replace (creation_type)

					-- Check if creation routine is non-once procedure
				feature_name := call.feature_name
				if not creation_class.valid_creation_procedure (feature_name) then
					!!vgcc5
					context.init_error (vgcc5)
					vgcc5.set_target_name ("")
					vgcc5.set_type (creation_type)
					a_feature := creation_class.feature_table.item (feature_name)
					vgcc5.set_creation_feature (a_feature)
					Error_handler.insert_error (vgcc5)
				else
					export_status := creation_class.creators.item (feature_name)
					if not export_status.valid_for (context.a_class) then
							-- Creation procedure is not exported
						!!vgcc5
						context.init_error (vgcc5)
						vgcc5.set_target_name ("")
						vgcc5.set_type (creation_type)
						a_feature := creation_class.feature_table.item (feature_name)
						vgcc5.set_creation_feature (a_feature)
						Error_handler.insert_error (vgcc5)
					end
				end
			else
				context.replace (creation_type)
				creators := creation_class.creators
				if (creators = Void) then
				elseif creators.empty then
					!!vgcc5
					context.init_error (vgcc5)
					vgcc5.set_target_name ("")
					vgcc5.set_type (creation_type)
					vgcc5.set_creation_feature (Void)
					Error_handler.insert_error (vgcc5)
				else
					!!vgcc4
					context.init_error (vgcc4)
					vgcc4.set_target_name ("")
					vgcc4.set_type (creation_type)
					Error_handler.insert_error (vgcc4)
				end
			end

				-- Check for errors
			Error_handler.checksum

				-- Insert the creation without creation routine
				-- (feature id = -1) in the dependance of the
				-- current feature
			!! depend_unit.make_creation_unit (creation_class.id)
			context.supplier_ids.extend (depend_unit)

				-- Compute creation information
			!! create_type
			create_type.set_type (creation_type.type_i)
			context.creation_types.insert (create_type)
		end

feature

	byte_node: CREATION_EXPR_B is
			-- Associated byte code
		local
			create_type: CREATE_TYPE
			call_access: FEATURE_B
			creation_feature_call: CREATION_FEATURE_B
		do
			!! Result.make



			if call /= Void then
				call_access ?= call.byte_node

					-- Cannot be Void since a call in this case is a call to a feature
				check
					call_access_not_void: call_access /= Void
				end

				!! creation_feature_call
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

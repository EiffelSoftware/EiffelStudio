class CREATION_AS

inherit

	INSTRUCTION_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end;

feature -- Attributes

	type: TYPE;
			-- Creation type

	target: ACCESS_AS;
			-- Target to create

	call: ACCESS_INV_AS;
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Initialization

	set is
			-- Yacc initialization
		do
			type ?= yacc_arg (0);
			target ?= yacc_arg (1);
			call ?= yacc_arg (2);
		ensure then
			target_exists: target /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check a creation instruction
		local
			access: ACCESS_B;
			creation_type, new_creation_type: TYPE_A;
			creation_class: CLASS_C;
			feature_name: STRING;
			a_feature: FEATURE_I;
			export_status: EXPORT_I;
			create_info: CREATE_INFO;
			create_type: CREATE_TYPE;
			create_feat: CREATE_FEAT;
			feature_type, local_type: TYPE_A;
			local_b: LOCAL_B;
			attribute_b: ATTRIBUTE_B;
			creators: EXTEND_TABLE [EXPORT_I, STRING];
			depend_unit: DEPEND_UNIT;
			vgcc1: VGCC1;
			vgcc2: VGCC2;
			vgcc3: VGCC3;
			vgcc31: VGCC31;
			vgcc4: VGCC4;
			vgcc5: VGCC5;
			vgcc7: VGCC7;
			vgcc8: VGCC8;
		do
				-- Init the type stack
			context.begin_expression;

				-- Type check access
			target.type_check;

				-- Last access: if error happened, then routine
				-- `type_check' of ACCESS_FEAT_AS will raise an error, so
				-- it is sure than we have the good access on the access line
			check
				access_exists: context.access_line.access /= Void;
			end;
			access := context.access_line.access;

			creation_type := context.item;
				-- Entity to create can only be an attribute, a local variable
				-- or Result
			if not access.is_creatable then
				!!vgcc7;
				context.init_error (vgcc7);
				vgcc7.set_target_name (target.access_name);
				vgcc7.set_type (creation_type);
				Error_handler.insert_error (vgcc7);
					-- Cannot go on here
				Error_handler.raise_error;
			end;

			if creation_type.is_formal then
					-- An entity of type a formal generic parameter cannot be
					-- created
				!!vgcc1;
				context.init_error (vgcc1);
				vgcc1.set_target_name (target.access_name);
				vgcc1.set_type (creation_type);
				Error_handler.insert_error (vgcc1);
			elseif 	creation_type.is_none
					--or else
					--creation_type.is_expanded
					--or else
					--not creation_type.type_i.is_reference
			then
					-- An entity of expanded type cannot be created
				!!vgcc3;
				context.init_error (vgcc3);
				vgcc3.set_target_name (target.access_name);
				vgcc3.set_type (creation_type);
				Error_handler.insert_error (vgcc3);
			else
				if type /= Void then
						-- Check specified creation type
					new_creation_type := type.actual_type;
					if 	new_creation_type.is_none
						or else
						new_creation_type.is_expanded
						or else
						not new_creation_type.type_i.is_reference
					then
							-- Cannot create instance of NONE
						!!vgcc3;
						context.init_error (vgcc3);
						vgcc3.set_target_name (target.access_name);
						vgcc3.set_type (creation_type);
						Error_handler.insert_error (vgcc3);
					elseif
						not new_creation_type.conform_to (creation_type)
					then
							-- Specified creation type must conform to
							-- the entity type
						!!vgcc31;
						context.init_error (vgcc31);
						vgcc31.set_target_name (target.access_name);
						vgcc31.set_type (creation_type);
						Error_handler.insert_error (vgcc31);
					else
						creation_type := new_creation_type;
							-- Update type stack
						context.change_item (creation_type);
							-- Update the access line
						access := access.creation_access (creation_type.type_i);
						context.access_line.change_item (access);
					end;
				end;
			
				creation_class := creation_type.associated_class;
				if creation_class.is_deferred then
						-- Associated class cannot be deferred
					!!vgcc2;
					context.init_error (vgcc2);
					vgcc2.set_target_name (target.access_name);
					vgcc2.set_type (creation_type);
					Error_handler.insert_error (vgcc2);
				end;

				if call /= Void then
						-- Type check the call: note that the creation
						-- type is on the type stack
					call.type_check;
	
						-- Check if creation routine is non-once procedure
					feature_name := call.feature_name;
					if
						 not creation_class.valid_creation_procedure
																(feature_name)
					then
						!!vgcc5;
						context.init_error (vgcc5);
						vgcc5.set_target_name (target.access_name);
						vgcc5.set_type (creation_type);
						a_feature := 		
							creation_class.feature_table.item (feature_name);
						vgcc5.set_creation_feature (a_feature);
						Error_handler.insert_error (vgcc5);
					else
						export_status := creation_class.creators.item
															(feature_name);
						if not export_status.valid_for (context.a_class) then
								-- Creation procedure is not exported
							!!vgcc8;
							context.init_error (vgcc8);
							vgcc8.set_target_name (target.access_name);
							vgcc8.set_type (creation_type);
							a_feature := 
								creation_class.feature_table.item
															(feature_name);
							vgcc8.set_creation_feature (a_feature);
							Error_handler.insert_error (vgcc8);
						end;
					end;
				else
					creators := creation_class.creators;
					if (creators = Void) then
							-- Insert the creation without creation routine
							-- (feature id = -1) in the dependance of the
							-- current feature
						!!depend_unit.make (creation_class.id, -1);
						context.supplier_ids.add (depend_unit);
					elseif creators.empty then
						!!vgcc8;
						context.init_error (vgcc8);
						vgcc8.set_target_name (target.access_name);
						vgcc8.set_type (creation_type);
						vgcc8.set_creation_feature (Void);
						Error_handler.insert_error (vgcc8);
					else
						!!vgcc4;
						context.init_error (vgcc4);
						vgcc4.set_target_name (target.access_name);
						vgcc4.set_type (creation_type);
						Error_handler.insert_error (vgcc4);
					end;
				end;
			end;

				-- Compute creation information
			if type /= Void then
				!!create_type;
				create_type.set_type (creation_type.type_i);
				create_info := create_type;
			elseif access.is_result then
				feature_type ?= context.a_feature.type;
				create_info := feature_type.create_info;
			elseif access.is_local then
				local_b ?= access;
				local_type := context.local_ith (local_b.position).type;
				create_info := local_type.create_info;
			elseif access.is_attribute then
				attribute_b ?= access;
				!!create_feat;
				create_feat.set_feature_id (attribute_b.attribute_id);
				create_feat.set_feature_name (attribute_b.attribute_name);
				create_info := create_feat;
			end;
			Creation_types.insert (create_info);

				-- Update type stack
			context.pop (1);
		end;

	Creation_types: LINE [CREATE_INFO] is
			-- Line of creation informations
		once
			Result := context.creation_types;
		end;

	byte_node: CREATION_B is
			-- Byte code for creation instruction
		local
			access, call_access: ACCESS_B;
			nested: NESTED_B;
			create_info: CREATE_INFO;
			create_feat: CREATE_FEAT;
			rout_id: INTEGER;
			type_set: ROUT_ID_SET;
		do
			!!Result;
			access := target.byte_node;
			Result.set_target (access);
		
			create_info := Creation_types.item;	
			Result.set_info (create_info);
			Creation_types.forth;

				-- Register information for generation of the final Eiffel
				-- executable.
			create_feat ?= create_info;
			if create_feat /= Void then
				rout_id := context.a_class.feature_table.item
					(create_feat.feature_name).rout_id_set.first;
				if rout_id < 0 then
					rout_id := -rout_id;
				end;
				type_set := System.type_set;
				if not type_set.has (rout_id) then
						-- Found a new routine id having a type table
					type_set.force (rout_id);
				end;
			end;

			if call /= Void then
				call_access := call.byte_node;
				!!nested;
				nested.set_target (access);
				access.set_parent (nested);
				nested.set_message (call_access);
				call_access.set_parent (nested);
				Result.set_call (nested);
			end;
		end;


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if type /= void then
				ctxt.put_special("!");
				type.format (ctxt);
				ctxt.put_special("!")
			else
				ctxt.put_special ("!!")
			end;
			target.format (ctxt);
			if  call /= void then
				ctxt.need_dot;
				call.format (ctxt);
				-- check whether "." is needeed
			end;
			ctxt.put_breakable;
			ctxt.always_succeed;
		end;


feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			target.fill_calls_list (l);
			l.stop_filling;
			call.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := twin;
			Result.set_target (target.replicate (ctxt));
			if type = void then
				if call /= void then
					Result.set_call (call.replicate (ctxt));
					-- if call is not creation routine
					-- raise exception
				else
					-- if creation routine is needed
					-- raise exception
				end;
			end;
		end;

feature {CREATION_AS}	-- Replication

	set_call (c: like call) is
		do
			call := c
		end;

	set_target (t: like target) is
		do
			target := t;
		end;
end

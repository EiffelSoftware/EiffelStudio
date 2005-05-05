-- Byte code for nested call

class NESTED_B 

inherit

	CALL_B
		redefine
			enlarged, make_byte_code,
			need_invariant, set_need_invariant,
			is_unsafe, calls_special_features, optimized_byte_node,
			is_special_feature, size, pre_inlined_code,
			inlined_byte_code, generate_il, need_target
		end

feature 

	target: ACCESS_B;
			-- Target of the call

	message: CALL_B;
			-- Message to send to the target

	set_target (t: ACCESS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_message (m: CALL_B) is
			-- Assign `m' to `message'.
		do
			message := m;
		end;

	type: TYPE_I is
			-- Expression of the remote call
		do
			Result := message.type;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in the local target or message ?
		do
			Result := message.used (r) or target.used (r);
		end;

	is_single: BOOLEAN is
			-- Is call a single one ?
		do
			if
				message.target = message and
					-- First condition: must have a depth of 1.
				target.is_predefined
					-- Second condition: target has to be predefined.
			then
					-- Third condition: all the parameters must be predefined.
				Result := message.is_single;
			end;
		end;

	enlarged: NESTED_BL is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			Result := sub_enlarged (Void);
		end;

	sub_enlarged (p: NESTED_BL): NESTED_BL is
			-- Enlarge node and set parent to `p'
		do
			create Result;
			Result.set_parent (p);
			Result.set_target (target.sub_enlarged (Result));
			Result.set_message (message.sub_enlarged (Result));
		end;

	need_invariant: BOOLEAN is
		do
			Result := message.need_invariant
		end;

	set_need_invariant (b: BOOLEAN) is
		do
			message.set_need_invariant (b)
		end

feature -- IL code generation

	need_target: BOOLEAN is
			-- Does current call really need a target to be performed?
			-- E.g. not (a constant or a static external)
		do
			Result := target.need_target
		end
		
	generate_il is
			-- Generate IL code for a nested call.
		local
			can_discard_target: BOOLEAN
			is_target_generated: BOOLEAN
			l_call_access: CALL_ACCESS_B
			l_attr: ATTRIBUTE_B
			l_cl_type: CL_TYPE_I
			local_number: INTEGER
			l_type: TYPE_I
			l_need_attribute_to_be_assigned_back: BOOLEAN
			l_external: EXTERNAL_B
		do
			can_discard_target := not message.need_target

			if can_discard_target then
					-- If we have a constant or a static external call,
					-- we can forget about the generation of `target' only
					-- if it is not a routine call. If the generation
					-- of `target' occurred, we need to pop from
					-- execution stack the value returned by `target'
					-- because it is not needed to perform the call to `message'.
				is_target_generated := (not target.is_predefined and
					(parent /= Void or not target.is_attribute))
			else
				is_target_generated := True
			end
			
			if is_target_generated then
					-- We pass `True' to force a special treatment on 
					-- generation of `target' if it is an expanded object.
					-- Namely if `target' is predefined we will load
					-- the address of `target' instead of `target' itself.
					-- `message' will manage the boxing operation if needed.
				target.generate_il_call_access (True)
					-- In case of attributes which requires their address to be loaded
					-- to perform the call, we check wether or not the value needs to be
					-- assigned back to the attribute or not, that is to say if they
					-- are first in the call chain.
					-- If it does then its address was loaded in previous call to `target', so
					-- we need to duplicate it.
				l_attr ?= target
				if l_attr /= Void then
					l_need_attribute_to_be_assigned_back :=  l_attr.need_address (True) and then
						l_attr.is_first and then not context.associated_class.is_single 
					if l_need_attribute_to_be_assigned_back then
						il_generator.duplicate_top
					end
				end
			end

			l_call_access ?= message

			if can_discard_target and is_target_generated then
				il_generator.pop
				l_external ?= l_call_access
				if l_external /= Void then
						-- Modify call so that we do it as if it was a static call.
						-- This is ok because eventhough the code looks like:
						-- f.static_external (args) where f is of type A
						-- it should have been written as:
						-- {A}.static_external (args)
					l_external.enable_static_call
					l_external.set_parent (Void)
				end
			end

				-- Generate call
			if l_call_access /= Void then
				l_call_access.generate_il_call (True)
			else
				message.generate_il
			end
			if l_need_attribute_to_be_assigned_back then
				l_type := Context.real_type (message.type)
				if not l_type.is_void then
					context.add_local (l_type)
					local_number := context.local_list.count
					il_generator.put_dummy_local_info (l_type, local_number)
					il_generator.generate_local_assignment (local_number)
				end
				l_cl_type ?= l_attr.context_type
				il_generator.generate_expanded_attribute_assignment (
					il_generator.implemented_type (l_attr.written_in, l_cl_type),
					Context.real_type (l_attr.type),
					l_attr.attribute_id)
				if not l_type.is_void then
					il_generator.generate_local (local_number)
				end
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a nested call.
		do
				-- generate the target byte code
			target.make_byte_code (ba);

			if target.is_feature then
					-- insert a debugger hook without increasing the line number
				generate_melted_debugger_hook_nested (ba); 
			end
	
				-- generate the call byte code
			message.make_byte_code (ba);
		end;

feature -- Array optimization

	is_special_feature: BOOLEAN is
		do
			Result := target.is_special_feature
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if target.conforms_to_array_opt and then
				(target.array_descriptor = array_desc)
			then
					-- The target of the message matches `array_desc'
					-- Check the message
				Result := message.is_special_feature
			end;
			Result := Result or else
				target.calls_special_features (array_desc) or else
				message.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := target.is_unsafe or else
				message.is_unsafe
		end

	optimized_byte_node: CALL_B is
		local
			opt_context: OPTIMIZATION_CONTEXT;
			array_desc: INTEGER;
			optimize, access_area: BOOLEAN;
			optimizer: ARRAY_OPTIMIZER;
			opt_feat_b: OPT_FEAT_B;
			m: CALL_B;
			t: ACCESS_B;
			nested_b: NESTED_B
		do
			if target.conforms_to_array_opt then
				optimizer := System.remover.array_optimizer;
				array_desc := target.array_descriptor;
				opt_context := optimizer.optimization_context;
				if opt_context.generated_array_desc.has (array_desc) then
					access_area := True
					optimize := message.is_special_feature;
				elseif opt_context.generated_offsets.has (array_desc) then
					optimize := message.is_special_feature;
				end;
			end;
			if optimize then
				optimizer.set_current_feature_optimized;

				create opt_feat_b;
				opt_feat_b.set_array_target (target);
				opt_feat_b.set_access_area (access_area);
				m := message;
				t := m.target;

				opt_feat_b.set_parameters (t.parameters.optimized_byte_node)
				opt_feat_b.set_type (t.type)
					-- if `parameters.count' = 1 then it is `item'
				opt_feat_b.set_special_feature_type;

				if t = m then
						-- Last nested call
						-- The OPT_FEAT_B node is the optimized node
					Result := opt_feat_b;
					opt_feat_b.set_parent (parent);
				else
						-- Create a nested node
					Result := Current
					target := opt_feat_b;
					opt_feat_b.set_parent (Current);
					nested_b ?= message; -- Cannot fail
					message := nested_b.message;
						-- Re-attach the message
					message.set_parent (Current)
				end;
			else
				Result := Current;
				message := message.optimized_byte_node
				target := target.optimized_byte_node
			end;
		end;

feature -- Inlining

	size: INTEGER is
		do
			Result := target.size + message.size + 1
		end

	pre_inlined_code: like Current is
		local
			inlined_current_b: INLINED_CURRENT_B
			access: like target
			access_expr_b: ACCESS_EXPR_B
		do
			if parent /= Void then
				Result := Current
			else
					-- First call
				access := target;

				access_expr_b ?= access;
				if
					access.is_argument or else
					access.is_local or else
					access.is_result or else
					access.is_current or else
					access_expr_b /= Void
				then
						-- `pre_inlined_code' in the target will take
						-- care of the special byte code
					Result := Current
				else
						-- The first call is a feature
						-- Create a dummy nested call:
						-- Current.feature
						-- (Current is in fact inlined_current_b)

					create parent;

					parent.set_message (Current);

					create inlined_current_b;
					parent.set_target (inlined_current_b);
					inlined_current_b.set_parent (parent);

					Result := parent
				end;
			end;
				-- Cannot fail: `parent' of `target' is Current, thus not void
				-- (no NESTED_B is created)
			target ?= target.pre_inlined_code
			message := message.pre_inlined_code
		end;

	inlined_byte_code: NESTED_B is
		do
			Result := Current
				-- FIXME
				-- FIXME
				-- FIXME
				-- Done to avoid a bug when both a and f are inlined
				-- in a a.f call.
				-- Xavier
				-- Note: Manu 4/10/2003: I don't know what was the bug, but it seems
				-- to work with inlining size of `0' that inline calls to `item' from
				-- SPECIAL.
			if System.inlining_size = 0 then
				target := target.inlined_byte_code
			end
			message := message.inlined_byte_code;
		end

end

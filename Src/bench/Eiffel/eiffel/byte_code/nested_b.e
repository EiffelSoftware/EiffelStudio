-- Byte code for nested call

class NESTED_B 

inherit

	CALL_B
		redefine
			enlarged, make_byte_code, make_creation_byte_code,
			need_invariant, set_need_invariant,
			is_unsafe, calls_special_features, optimized_byte_node,
			is_special_feature
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
			Result := message.forth_used (r) or target.used (r);
		end;

	forth_used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in the forthcomming expressions ?
		do
			Result := message.forth_used (r);
		end;

	is_single: BOOLEAN is
			-- Is call a single one ?
		do
			if message.target = message and
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
		local
			void_parent: NESTED_BL;
		do
				-- This is the root of the call tree
			Result := sub_enlarged (void_parent);
		end;

	sub_enlarged (p: NESTED_BL): NESTED_BL is
			-- Enlarge node and set parent to `p'
		do
			!!Result;
			Result.set_parent (p);
			Result.set_target (target.sub_enlarged (Result));
			Result.set_message (message.sub_enlarged (Result));
		end;

	generate_creation_call is
			-- Generation of a creation call
		do
		end;

	need_invariant: BOOLEAN is
		do
			Result := message.need_invariant
		end;

	set_need_invariant (b: BOOLEAN) is
		do
			message.set_need_invariant (b)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a nested call.
		do
			target.make_byte_code (ba);
			message.make_byte_code (ba);
		end;

	make_creation_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a nested call for a creation.
		do
			target.make_byte_code (ba);
			message.make_creation_byte_code (ba);
		end;

feature -- Array optimization

	is_special_feature: BOOLEAN is
		do
			Result := target.is_special_feature
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		local
			local_b: LOCAL_B;
			arg_b: ARGUMENT_B;
			result_b: RESULT_B
		do
			if target.conforms_to_array_opt and then
				(target.array_descriptor = array_desc)
			then
					-- The target of the message matches `array_desc'
					-- Check the message
				Result := check_message
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
			optimize: BOOLEAN;
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
					if check_message then
						optimize := True
					end;
				end;
			end;
			if optimize then
				optimizer.set_current_feature_optimized;

				!!opt_feat_b;
				opt_feat_b.set_array_target (array_desc);
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

				io.error.putstring ("NOT IMPLEMENTED%N");
			else
				Result := Current;
				message := message.optimized_byte_node
				target := target.optimized_byte_node
			end;
		end;

	check_message: BOOLEAN is
			-- Check to see if the message is a special feature
		do
			Result := message.is_special_feature
		end;

end

note
	description: "Byte code for a nested call."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class NESTED_B

inherit

	CALL_B
		redefine
			enlarged,
			call_kind, set_call_kind,
			is_unsafe, calls_special_features, optimized_byte_node,
			is_special_feature, size, pre_inlined_code,
			inlined_byte_code, need_target, has_call, allocates_memory
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_nested_b (Current)
		end

feature -- Access

	target: ACCESS_B;
			-- Target of the call

	message: CALL_B;
			-- Message to send to the target

	set_target (t: ACCESS_B)
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_message (m: CALL_B)
			-- Assign `m' to `message'.
		do
			message := m;
		end;

	type: TYPE_A
			-- Expression of the remote call
		do
			Result := message.type
		end;

	used (r: REGISTRABLE): BOOLEAN
			-- Is register `r' used in the local target or message ?
		do
			Result := message.used (r) or target.used (r);
		end;

	is_single: BOOLEAN
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

	enlarged: NESTED_BL
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			Result := sub_enlarged (Void);
		end;

	sub_enlarged (p: NESTED_BL): NESTED_BL
			-- Enlarge node and set parent to `p'
		do
			create Result
			Result.set_parent (p)
			Result.set_target (target.sub_enlarged (Result))
			Result.set_message (message.sub_enlarged (Result))
		end

feature {CALL_B} -- C code generation: kind of a call

	call_kind: INTEGER
			-- <Precursor>
		do
			Result := message.call_kind
		end

	set_call_kind (value: like call_kind)
			-- <Precursor>
		do
			message.set_call_kind (value)
		end

feature -- Status report

	has_call: BOOLEAN
			-- <Precursor>
		do
			Result := target.has_call or message.has_call
		end

	allocates_memory: BOOLEAN
		do
			Result := target.allocates_memory or message.allocates_memory
		end

feature -- IL code generation

	need_target: BOOLEAN
			-- Does current call really need a target to be performed?
			-- E.g. not (a constant or a static external)
		do
			Result := target.need_target
		end

feature -- Array optimization

	is_special_feature: BOOLEAN
		do
			Result := target.is_special_feature
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
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

	is_unsafe: BOOLEAN
		do
			Result := target.is_unsafe or else
				message.is_unsafe
		end

	optimized_byte_node: CALL_B
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

	size: INTEGER
		do
			Result := target.size + message.size + 1
		end

	pre_inlined_code: like Current
			-- <Precursor>
		local
			call: like target.pre_inlined_code
		do
			Result := Current
			if not attached parent then
					-- First call.
				call := target.pre_inlined_code
				target :=
					if attached {ACCESS_B} call as t then
						t
					else
						create {ACCESS_EXPR_B}.make (call)
					end
				message := message.pre_inlined_code
			end
		end

	inlined_byte_code: NESTED_B
		do
			Result := Current
			target := target.inlined_byte_code
			message := message.inlined_byte_code
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

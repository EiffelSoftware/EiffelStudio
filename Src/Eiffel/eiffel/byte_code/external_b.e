indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Access to a C external

class EXTERNAL_B

inherit
	CALL_ACCESS_B
		rename
			precursor_type as static_class_type,
			set_precursor_type as set_static_class_type
		redefine
			same, is_external, set_parameters, parameters, enlarged, enlarged_on,
			is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			need_target, is_constant_expression
		end

	SHARED_INCLUDE

	SHARED_IL_CONSTANTS
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		local
			c: CL_TYPE_A
			f: FEATURE_I
		do
			if not is_static_call and then not context.is_written_context then
					-- Ensure the feature is not redeclared into attribute or internal routine.
					-- and if redeclared as an external, make sure it is not redeclared differently.
				c ?= context_type
				f := c.associated_class.feature_of_rout_id (routine_id)
				if equal (f.extension, extension) then
					f := Void
				end
			end
			if f = Void then
					-- Process feature as an external routine.
				v.process_external_b (Current)
			else
					-- Create new byte node and process it instead of the current one.
				byte_node (f, c).process (v)
			end
		end

feature

	type: TYPE_A
			-- Type of the call

	parameters: BYTE_LIST [PARAMETER_B];
			-- Feature parameters: can be Void

feature -- Attributes for externals

	extension: EXTERNAL_EXT_I
			-- Encapsulation of external extensions

	external_name_id: INTEGER
			-- Name ID of C external.

	external_name: STRING is
			-- Name of C external.
		require
			external_name_id_set: external_name_id > 0
		do
			Result := Names_heap.item (external_name_id)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	is_external: BOOLEAN is True;
			-- Access is an external call

	is_static_call: BOOLEAN
			-- Is current external call made through a static access?

	precursor_type: like static_class_type is
		require
			il_generation: System.il_generation
			not_a_static_call: not is_static_call
		do
			Result := static_class_type
		end

feature -- Status report

	is_constant_expression: BOOLEAN is
			-- Is constant expression?
		local
			l_ext: IL_ENUM_EXTENSION_I
		do
				-- For now only a .NET enum type is constant for an external call.
			l_ext ?= extension
			Result := l_ext /= Void
		end

feature -- Routines for externals

	set_extension (e: like extension) is
			-- Assign `e' to `extension'.
		do
			extension := e
		end;

	set_parameters (p: like parameters) is
			-- Assign `p' to `parameters'.
		do
			parameters := p
			if p /= Void then
				p.do_all (agent {PARAMETER_B}.set_parent (Current))
			end
		end

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	enable_static_call is
			-- Set `is_static_call' to `True'.
		do
			is_static_call := True
			set_need_invariant (False)
		ensure
			is_static_call_set: is_static_call
		end

	init (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void
			is_valid_feature_for_normal_generation: not System.il_generation implies f.is_external
			is_valid_feature_for_il_generation: System.il_generation implies
				(f.is_external or f.is_attribute or f.is_deferred or f.is_constant)
		do
			feature_name_id := f.feature_name_id
			routine_id := f.rout_id_set.first
			if System.il_generation and f.is_c_external then
				feature_id := f.origin_feature_id
				written_in := f.origin_class_id
			else
				feature_id := f.feature_id
				written_in := f.written_in
			end
		end;

	set_external_name_id (id: INTEGER) is
			-- Assign `id' to `external_name_id'.
		require
			valid_id: id > 0
		do
			external_name_id := id
		ensure
			external_name_id_set: external_name_id = id
		end

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'
		do
			encapsulated := b;
		end;

feature {STATIC_ACCESS_AS} -- Settings

	set_written_in (id: INTEGER) is
			-- Set `written_in' to `id'.
		require
			valid_id: id > 0
		do
			written_in := id
		ensure
			written_in_set: written_in = id
		end

feature -- Status report

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			external_b: EXTERNAL_B;
		do
			external_b ?= other;
			if external_b /= Void then
				Result := external_name_id = external_b.external_name_id;
			end;
		end;

	enlarged: CALL_ACCESS_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		do
				-- Fallback to default implementation.
			Result := enlarged_on (context_type)
		end

	enlarged_on (a_type_i: TYPE_A): CALL_ACCESS_B is
			-- Enlarged byte node evaluated in the context of `a_type_i'.
		local
			external_bl: EXTERNAL_BL
			c: CL_TYPE_A
			f: FEATURE_I
		do
			if not is_static_call and then not context.is_written_context then
					-- Ensure the feature is not redeclared into attribute or internal routine.
					-- and if redeclared as an external, make sure it is not redeclared differently.
				c ?= a_type_i
				if c /= Void then
					f := c.associated_class.feature_of_rout_id (routine_id)
					if equal (f.extension, extension) then
						f := Void
					end
				end
			end
			if f = Void then
				if context.final_mode then
					create external_bl
				else
					create {EXTERNAL_BW} external_bl.make
				end
				external_bl.fill_from (Current)
				Result := external_bl
			else
				Result ?= byte_node (f, a_type_i).enlarged
			end
		end

feature -- IL code generation

	need_target: BOOLEAN is
			-- Does current call need a target to be performed?
			-- Meaning that it is not a static call.
		local
			il_ext: IL_EXTENSION_I
		do
			if System.il_generation then
				il_ext ?= extension
					-- It can either be a C externals or an IL static external
				Result := il_ext = Void or else need_current (il_ext.type)
			else
				Result := False
			end
		end

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
				-- An external call can have access to the entire system
				-- and move. resize objects. Thus it is unsafe to call
				-- an external feature.
			Result := True
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if parameters /= Void then
				parameters := parameters.optimized_byte_node
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if parameters /= Void then
				Result := parameters.calls_special_features (array_desc)
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			if parameters /= Void then
				Result := 1 + parameters.size
			else
				Result := 1
			end
		end

	pre_inlined_code: CALL_B is
		local
			inlined_current_b: INLINED_CURRENT_B
		do
			if parent /= Void then
				Result := Current
			else
				create parent;

				create inlined_current_b;
				parent.set_target (inlined_current_b);
				inlined_current_b.set_parent (parent);

				parent.set_message (Current);

				Result := parent;
			end
				-- Adapt type in current context for better results. We have to remove
				-- the anchors otherwise it does not work, see eweasel test#final050.
			type := real_type (type.deep_actual_type).instantiated_in (context.context_cl_type)
			if static_class_type /= Void then
				static_class_type ?= real_type (static_class_type)
			end
			if parameters /= Void then
				parameters := parameters.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			type := real_type (type)
			if static_class_type /= Void then
				static_class_type ?= real_type (static_class_type)
			end
			if parameters /= Void then
				parameters := parameters.inlined_byte_code
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

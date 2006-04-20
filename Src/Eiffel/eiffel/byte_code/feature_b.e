indexing
	description	: "Byte code generation for feature call."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_B

inherit
	CALL_ACCESS_B
		redefine
			is_feature, set_parameters,
			parameters, enlarged, enlarged_on, context_type,
			is_feature_special, make_special_byte_code,
			is_unsafe, optimized_byte_node,
			calls_special_features, is_special_feature,
			size, pre_inlined_code, inlined_byte_code
		end

	SHARED_TABLE

	SHARED_SERVER

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; t: like type; p_type: like precursor_type) is
			-- Initialization
		require
			good_argument: f /= Void
		local
			feat: FEATURE_I
			feat_tbl: FEATURE_TABLE
		do
			feature_name_id := f.feature_name_id
			body_index := f.body_index
			routine_id := f.rout_id_set.first
			is_once := f.is_once
			is_process_relative := f.is_process_relative
			precursor_type := p_type
			type := t
			if System.il_generation then
				if precursor_type = Void then
						-- Normal feature call.
					if f.origin_class_id /= 0 then
						feature_id := f.origin_feature_id
						written_in := f.origin_class_id
					else
							-- Case of a non-external Eiffel routine
							-- written in an external class.
						feature_id := f.feature_id
						written_in := f.written_in
					end
				else
						-- Precursor access, we need to find where body
						-- is defined. It is slow since we have to do a lookup
						-- in the parent feature table but we do not have
						-- much choice at the moment. The good thing is that
						-- since it is done at degree 3, we are most likely
						-- to hit the feature table cache.
					written_in := f.written_in
					feat_tbl := System.class_of_id (written_in).feature_table
					feat := feat_tbl.feature_of_rout_id_set (f.rout_id_set)
					feature_id := feat.feature_id
				end
			else
				feature_id := f.feature_id
				written_in := f.written_in
			end
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		local
			c: CL_TYPE_I
			f: FEATURE_I
		do
			if not context.is_written_context then
					-- Ensure the feature is not redeclared into attribute.
				c ?= context_type
				f := c.base_class.feature_of_rout_id (routine_id)
				if not f.is_attribute then
					f := Void
				end
			end
			if f = Void then
					-- Process feature as an internal routine.
				v.process_feature_b (Current)
			else
					-- Create new byte node and process it instead of the current one.
				byte_node (f).process (v)
			end
		end

feature -- Access

	type: TYPE_I
			-- Type of the call

	body_index: INTEGER
			-- Body Index of the feature

	is_once: BOOLEAN
			-- Is the current feature a once feature?
			--| Used when inlining is turned on in final mode, because we are not
			--| allowed to inline once routines

	is_process_relative: BOOLEAN
			-- Is current feature process-relative?

	parameters: BYTE_LIST [PARAMETER_B]
			-- Feature parameters: can be Void

	set_parameters (p: like parameters) is
			-- Assign `p' to `parameters'.
		do
			parameters := p
		end

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	special_routines: SPECIAL_FEATURES is
			-- Array containing special routines.
		once
			create Result
		end

	is_any_feature: BOOLEAN is
			-- Is Current an instance of ANY_FEATURE_B?
		do
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_I): BOOLEAN is
			-- Search for feature_name in special_routines.
			-- This is used for simple types only.
			-- If found return True (and keep reference position).
			-- Otherwize, return false
		do
			Result := special_routines.has (feature_name_id, compilation_type, target_type)
		end

	is_feature: BOOLEAN is True
			-- Is Current an access to an Eiffel feature ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			feature_b: FEATURE_B
		do
			feature_b ?= other
			if feature_b /= Void then
				Result := feature_id = feature_b.feature_id
			end
		end

	enlarged: CALL_ACCESS_B is
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		do
			Result := enlarged_on (context_type)
		end

	enlarged_on (type_i: TYPE_I): CALL_ACCESS_B is
			-- Enlarged byte node evaluated in the context of `type_i'.
		local
			feature_bl: FEATURE_BL
			c: CL_TYPE_I
			f: FEATURE_I
		do
			if not context.is_written_context then
					-- Ensure the feature is not redeclared into attribute.
				c ?= real_type (type_i)
				if c /= Void then
					f := c.base_class.feature_of_rout_id (routine_id)
					if not f.is_attribute then
						f := Void
					end
				end
			end
			if f = Void then
					-- Process feature as an internal routine.
				if context.final_mode then
					create feature_bl
				else
					create {FEATURE_BW} feature_bl.make
				end
				feature_bl.fill_from (Current)
				Result := feature_bl
			else
					-- Create new byte node and process it instead of the current one.
				Result ?= byte_node (f).enlarged
			end
		end

feature -- Context type

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		do
			if precursor_type = Void then
				Result := Precursor {CALL_ACCESS_B}
			else
				Result := Context.real_type (precursor_type)
			end
		end

feature -- Byte code generation

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_I) is
			-- Make byte code for special calls.
		do
			special_routines.make_byte_code (ba, basic_type)
		end

feature -- Array optimization

	is_special_feature: BOOLEAN is
		local
			cl_type: CL_TYPE_I
			base_class: CLASS_C
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type -- Cannot fail
			base_class := cl_type.base_class
			f := base_class.feature_table.item_id (feature_name_id)
			create dep.make (base_class.class_id, f)
			Result := optimizer.special_features.has (dep)
		end

	is_unsafe: BOOLEAN is
		local
			cl_type: CL_TYPE_I
			base_class: CLASS_C
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type -- Cannot fail
			base_class := cl_type.base_class
			f := base_class.feature_table.item_id (feature_name_id)
debug ("OPTIMIZATION")
	io.error.put_string ("%N%N%NTESTING is_unsafe for ")
	io.error.put_string (feature_name)
	io.error.put_string (" from ")
	io.error.put_string (base_class.name)
	io.error.put_string (" is NOT safe%N")
end
			optimizer.test_safety (f, base_class)
			create dep.make (base_class.class_id, f)
			Result := (not optimizer.is_safe (dep))
				or else (parameters /= Void and then parameters.is_unsafe)
debug ("OPTIMIZATION")
	if Result then
		io.error.put_string (f.feature_name)
		io.error.put_string (" from ")
		io.error.put_string (base_class.name)
		io.error.put_string (" is NOT safe%N")
	end
end
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

feature {NONE} -- Array optimization

	optimizer: ARRAY_OPTIMIZER is
		do
			Result := System.remover.array_optimizer
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
				create parent
				create inlined_current_b
				parent.set_target (inlined_current_b)
				inlined_current_b.set_parent (parent)

				parent.set_message (Current)

				Result := parent
			end
			type := real_type (type)
			if precursor_type /= Void then
				precursor_type ?= real_type (precursor_type)
			end
			if parameters /= Void then
				parameters := parameters.pre_inlined_code
			end
		end

	inlined_byte_code: ACCESS_B is
		local
			inlined_feat_b: INLINED_FEAT_B
			inline: BOOLEAN
			inliner: INLINER
			type_i: TYPE_I
			cl_type: CL_TYPE_I
			bc: STD_BYTE_CODE
			l_rout_table: ROUT_TABLE
			l_body_index: INTEGER
			entry: ROUT_ENTRY
			f: FEATURE_I
			context_class_type: CLASS_TYPE
			written_class_type: CLASS_TYPE
		do
			if not is_once then
				type_i := context_type
				if not type_i.is_basic then
					cl_type ?= type_i -- Cannot fail
						-- Inline only if it is not polymorphic and if it can be inlined.
					if Eiffel_table.is_polymorphic (routine_id, cl_type.type_id, True) = -1 then
						l_rout_table ?= eiffel_table.poly_table (routine_id)
						l_rout_table.goto_implemented (cl_type.type_id)
							-- Only if it is implemented that we can inline it.
						if l_rout_table.is_implemented then
							inliner := System.remover.inliner
							entry := l_rout_table.item
							l_body_index := entry.body_index
							inline := inliner.inline (type, l_body_index)
						end
					end
				end
			end

			if inline then
					-- Ensure the feature is not redeclared into attribute or external routine
				f := system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id)
				if f.is_attribute or else f.is_external then
						-- Create new byte node and process it instead of the current one
					Result := byte_node (f).inlined_byte_code
				else
						-- Creation of a special node for the entire
						-- feature (descendant of STD_BYTE_CODE)
					inliner.set_current_feature_inlined
					if cl_type.base_class.is_special then
						create {SPECIAL_INLINED_FEAT_B} inlined_feat_b
					else
						create inlined_feat_b
					end
					inlined_feat_b.fill_from (Current)
					bc ?= Byte_server.disk_item (l_body_index)

					context_class_type := system.class_type_of_id (entry.type_id)
					written_class_type := context_class_type.associated_class.implemented_type (f.written_in, context_class_type.type).associated_class_type
					inlined_feat_b.set_context_type (context_class_type, written_class_type)

					Context.change_class_type_context (context_class_type, written_class_type)
					bc := bc.pre_inlined_code
					Context.restore_class_type_context

					inlined_feat_b.set_inlined_byte_code (bc)
					Result := inlined_feat_b
				end
			else
				Result := Current
				if parameters /= Void then
					parameters := parameters.inlined_byte_code
				end
			end
		end

	current_class_type: CLASS_TYPE is
			-- Current type for the call (NOT the static type but the
			-- type corresponding to the written in class)
		local
			written_class	: CLASS_C
			tuple_class		: TUPLE_CLASS_B
			original_feature: FEATURE_I
			m				: META_GENERIC
			true_gen		: ARRAY [TYPE_I]
			real_target_type: TYPE_A
			actual_type		: TYPE_A
			constraint		: TYPE_A
			formal_a		: FORMAL_A
			nb_generics, i	: INTEGER
			l_formal_dec: FORMAL_CONSTRAINT_AS
		do
			original_feature := context_type.type_a.associated_class.
									feature_table.origin_table.item (routine_id)
			written_class := original_feature.written_class

			if written_class.generics = Void then
				Result := written_class.types.first
			else
				tuple_class ?= written_class
				if tuple_class /= Void then
					Result := tuple_class.types.first
				else
					real_target_type := context_type.type_a
						-- LINKED_LIST [STRING] is recorded as LINKED_LIST [REFERENCE_I]
						-- => LINKED_LIST [ANY] after previous call

					from
						i := 1
						nb_generics := written_class.generics.count
						create m.make (nb_generics)
						create true_gen.make (1, nb_generics)
					until
						i > nb_generics
					loop
						l_formal_dec ?= written_class.generics.i_th (1)
						check l_formal_dec_not_void: l_formal_dec /= Void end
						create formal_a.make (l_formal_dec.is_reference, l_formal_dec.is_expanded, i)
						actual_type := formal_a.instantiation_in (real_target_type, written_class.class_id)

						if actual_type.is_expanded then
							m.put (actual_type.type_i, i)
						else
							constraint := written_class.constraint (i)
							m.put (constraint.type_i, i)
						end
						true_gen.put (actual_type.type_i, i)
						i := i + 1
					end

					Result := (create {GEN_TYPE_I}.make (written_class.class_id, m, true_gen)).associated_class_type
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

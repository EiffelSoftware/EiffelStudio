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
					written_in := f.access_in
					feat_tbl := System.class_of_id (written_in).feature_table
					feat := feat_tbl.feature_of_rout_id_set (f.rout_id_set)
					feature_id := feat.feature_id
				end
			else
				feature_id := f.feature_id
				written_in := f.access_in
					--| IEK Changed from 'written_in' to handle replication correctly
					--| FIXME IEK .Net implementation needs updating
			end
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		local
			c: CL_TYPE_A
			f: FEATURE_I
			l_node: ACCESS_B
		do
			if not context.is_written_context or (system.il_generation and then context_type.is_expanded) then
					-- Ensure the feature is not redeclared into attribute.
				c ?= context_type
				f := c.associated_class.feature_of_rout_id (routine_id)
				if not f.is_attribute then
					if not system.il_generation or else not c.is_expanded then
						f := Void
					end
				end
			end
			if f = Void then
					-- Process feature as an internal routine.
				v.process_feature_b (Current)
			else
					-- Create new byte node and process it instead of the current one.
				l_node := byte_node (f, c)
				if {l_feat: like Current} l_node then
					v.process_feature_b (l_feat)
				else
					l_node.process (v)
				end
			end
		end

feature -- Access

	type: TYPE_A
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
			if p /= Void then
				p.do_all (agent {PARAMETER_B}.set_parent (Current))
			end
		end

	set_type (t: like type) is
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

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN is
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

	enlarged_on (type_i: TYPE_A): CALL_ACCESS_B is
			-- Enlarged byte node evaluated in the context of `type_i'.
		local
			feature_bl: FEATURE_BL
			c: CL_TYPE_A
			l_type: TYPE_A
			f: FEATURE_I
		do
			if not context.is_written_context then
					-- Ensure the feature is not redeclared into attribute if inherited.
				c ?= type_i
				if c /= Void then
					f := c.associated_class.feature_of_rout_id (routine_id)
					if not f.is_attribute then
						f := Void
					elseif context.final_mode and then system.seed_of_routine_id (routine_id).has_formal then
							-- It was originally a FEATURE_B because its seed had a formal, we still need
							-- to call the FEATURE_B if and only if it has a conforming expanded descendant.
						l_type := context.real_type (type)
						if
							context.has_expanded_descendants_information and then
							context.has_expanded_descendants (l_type.type_id (context.context_class_type.type))
						then
							f := Void
						end
					end
				end
			end
			if f = Void then
					-- Process feature as an internal routine.
				if context.final_mode then
					create feature_bl.make
				else
					create {FEATURE_BW} feature_bl.make
				end
				feature_bl.fill_from (Current)
				Result := feature_bl
			else
					-- Create new byte node and process it instead of the current one.
				Result ?= byte_node (f, type_i).enlarged
			end
		end

feature -- Context type

	context_type: TYPE_A is
			-- Context type of the access (properly instantiated)
		do
			if precursor_type = Void then
				Result := Precursor {CALL_ACCESS_B}
			else
				Result := Context.real_type (precursor_type)
			end
		end

feature -- Byte code generation

	make_special_byte_code (ba: BYTE_ARRAY; basic_type: BASIC_A) is
			-- Make byte code for special calls.
		do
			special_routines.make_byte_code (ba, basic_type)
		end

feature -- Array optimization

	is_special_feature: BOOLEAN is
		local
			cl_type: CL_TYPE_A
			base_class: CLASS_C
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type -- Cannot fail
			base_class := cl_type.associated_class
			f := base_class.feature_table.item_id (feature_name_id)
			create dep.make (base_class.class_id, f)
			Result := optimizer.special_features.has (dep)
		end

	is_unsafe: BOOLEAN is
		local
			cl_type: CL_TYPE_A
			base_class: CLASS_C
			f: FEATURE_I
			dep: DEPEND_UNIT
		do
			cl_type ?= context_type -- Cannot fail
			base_class := cl_type.associated_class
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
				-- Adapt type in current context for better results.
			type := type.instantiated_in (context.current_type)
			if precursor_type /= Void then
				precursor_type ?= real_type (precursor_type)
			end
			if parameters /= Void then
				set_parameters (parameters.pre_inlined_code)
			end
		end

	inlined_byte_code: ACCESS_B is
		local
			inlined_feat_b: INLINED_FEAT_B
			inline: BOOLEAN
			inliner: INLINER
			type_i: TYPE_A
			cl_type, written_cl_type: CL_TYPE_A
			bc: STD_BYTE_CODE
			l_rout_table: ROUT_TABLE
			l_body_index: INTEGER
			entry: ROUT_ENTRY
			f: FEATURE_I
			context_class_type, written_class_type: CLASS_TYPE
		do
			if not is_once then
				type_i := context_type
				if not type_i.is_basic then
					cl_type ?= type_i -- Cannot fail
						-- Inline only if it is not polymorphic and if it can be inlined.
					if Eiffel_table.is_polymorphic (routine_id, cl_type, context.context_class_type, True) = -1 then
						l_rout_table ?= eiffel_table.poly_table (routine_id)
						l_rout_table.goto_implemented (cl_type, context.context_class_type)
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
					-- Get information on the routine being inlined.
				f := system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id)
					-- Ensure the feature is not redeclared into attribute or external routine
				if f.is_attribute or else f.is_external then
						-- Create new byte node and process it instead of the current one
					Result := byte_node (f, type_i).inlined_byte_code
				else
						-- Creation of a special node for the entire
						-- feature (descendant of STD_BYTE_CODE)
					inliner.set_current_feature_inlined

						-- Adapt current to the appropriate context.
						-- For example, inlining SPECIAL [G#2] from HASH_TABLE [G#1, G#2] when
						-- the class is generated for HASH_TABLE [G#1, INTEGER] should yield
						-- SPECIAL [INTEGER].
						-- We also use `deep_actual_type' to get rid of the anchors since we do
						-- not care about them and actually they can cause trouble (see eweasel
						-- test#final047).
					cl_type := cl_type.instantiated_in (context.context_cl_type).deep_actual_type

						-- When the feature being inlined is implemented in a descendant or ancestor
						-- class of `cl_type' then we can perform inlining by providing two different
						-- contests (the target type/ the written type).
						-- If it is not the case, we have to do inlining differently (see the `else'
						-- part of the following if statement to see the explanation why doing
						-- it the same would yield a wrong result) by not really inlining, but
						-- by generating the code from the context in which it is defined.
					if
						cl_type.associated_class.simple_conform_to (f.written_class) or
						f.written_class.simple_conform_to (cl_type.associated_class)
					then
							-- Evaluate the type of `cl_type' in the descendant class `entry.class_id'.
							-- Note that if `cl_type.class_id = entry.class_id' we still do that
							-- because `cl_type' might not be a valid generic type on its own, see
							-- eweasel test#final056 where `cl_type' is `CACHE [G#2]' but it should
							-- be transformed as `CACHE [G#1]' to be a valid context type.
						cl_type := cl_type.find_descendant_type (system.class_of_id (entry.class_id))

							-- We should now have conformance the other way around or the same class.
						check cl_type.associated_class.simple_conform_to (f.written_class) end

							-- Get the CLASS_TYPE from `cl_type'.
						context_class_type := cl_type.associated_class_type (context.context_cl_type)
							-- Get the CLASS_TYPE for the class defining `f'.
						written_class_type := context_class_type.type.implemented_type (f.written_in).associated_class_type (Void)

							-- Get the actual type for code generation.
							-- Below, optimization if `f' is written in `cl_type'.
						if cl_type.class_id = f.written_in then
							written_cl_type := cl_type
						else
							written_cl_type := cl_type.find_class_type (f.written_class)
								-- Ensured that formal generics in `written_cl_type' are valid for `f.written_class'.
							written_cl_type := written_cl_type.find_descendant_type (f.written_class)
						end

							-- We have to limit the inlining here because of eweasel test#final062 and test#final061
							-- where if the ancestor and the written class do not share the same number of formal
							-- generic, or if they are not the same generic parameters, then it causes the compiler
							-- to fail during finalization.
						if
							(cl_type.has_formal_generic or written_cl_type.has_formal_generic) and
							not same_for_generics (cl_type.associated_class, written_cl_type.associated_class)
						then
							context_class_type := written_class_type
							cl_type := written_cl_type
						end
					else
							-- We are going to perform the inlining as if we were generating the class in
							-- which `f' is defined. To be clear, here is a sample:
							-- class A [G] feature f is do g end g deferred end end
							-- class B [H] feature g is do end end
							-- class C [G] inherit A [G] B [X] end
							-- class X end
							-- So when generating the code for A.f, we inline g, but we do it as if the code
							-- in A.f was:
							-- f is do
							-- 	local
							--		b: B [X]
							--	do
							--		b ?= Current -- Assignment cannot fail.
							--		b.g
							-- end
							-- The
							--

							-- It is clear that in that case the implemented version of `f' cannot be in
							-- `cl_type', otherwise we would go via the `then' part of the current
							-- if then else.
						check cl_type.class_id /= entry.class_id end
							-- Using the example above, we get `C [G]'
						cl_type := cl_type.find_descendant_type (system.class_of_id (entry.class_id))
							-- `f' cannot be implemented in the descendant version for which the first
							-- implementation of `f' appears, otherwise we would go via the `then' part
							-- of the current if then else.
						check cl_type.class_id /= f.written_in end
							-- Get the CLASS_TYPE corresponding to `C [G#1]'.
						context_class_type := cl_type.associated_class_type (context.context_cl_type)
							-- Get the CLASS_TYPE where `g' is coming from, that is to say `B [G#1]'.
						written_class_type := context_class_type.type.implemented_type (f.written_in).associated_class_type (Void)
							-- The actual type during code generation, i.e. B [X].
						check cl_type.associated_class.simple_conform_to (f.written_class) end
						written_cl_type := cl_type.find_class_type (f.written_class)

							-- Here we are going to do the inlining, but we are going to use written_cl_type
							-- all the time.
						context_class_type := written_class_type
						cl_type := written_cl_type
					end

						-- When types involved a generic formal parameter,
						-- then we cannot use a type adapted from the original
						-- current context. See eweasel test#final061.
					cl_type := normalized (cl_type, context_class_type)
					written_cl_type := normalized (written_cl_type, written_class_type)

						-- Create inlined byte node.
					if cl_type.associated_class.is_special then
						create {SPECIAL_INLINED_FEAT_B} inlined_feat_b
					else
						create inlined_feat_b
					end
					inlined_feat_b.fill_from (Current)

						-- Change context type before evaluating inlined feature byte code.
					Context.change_class_type_context (context_class_type, cl_type, written_class_type, written_cl_type)
					inlined_feat_b.set_context_type (context_class_type, cl_type, written_class_type, written_cl_type)

					bc ?= Byte_server.disk_item (l_body_index)
					check bc_not_void: bc /= Void end

						-- We set the `byte_code' of `inlined_feat_b' because we need to be set
						-- when handling in `pre_inlined_code' the type of attributes which relies
						-- on the type of the arguments of the inlined routine.
						-- This works because `bc' and `bc.pre_inlined_code' are the same object although
						-- the content is modified.
					inlined_feat_b.set_inlined_byte_code (bc)
					inliner.set_inlined_feature (inlined_feat_b)
					bc := bc.pre_inlined_code
					check same_bc: bc = inlined_feat_b.byte_code end
					Context.restore_class_type_context

					Result := inlined_feat_b
				end
			else
				Result := Current
				if parameters /= Void then
					parameters := parameters.inlined_byte_code
				end
			end
		end

feature {NONE} -- Normalization of types

	normalized (a_type: CL_TYPE_A; a_class_type: CLASS_TYPE): CL_TYPE_A is
			-- Replace all formals of `a_type' with formals of `a_class_type'.
		require
			a_type_not_void: a_type /= Void
			a_class_type_not_void: a_class_type /= Void
			a_class_type_valid: a_class_type.associated_class = a_type.associated_class
		local
			l_generics: ARRAY [TYPE_A]
			l_type: TYPE_A
			i, nb: INTEGER
		do
			Result := a_type
			l_generics := a_type.generics
			if l_generics /= Void then
				from
					i := l_generics.lower
					nb := l_generics.upper
				until
					i > nb
				loop
					l_type := l_generics.item (i)
					if l_type.has_formal_generic then
							-- If it is a generic at the right position, no need to duplicate
							-- the generics.
						if not (l_type.is_formal and then {l_formal: FORMAL_A} l_type and then l_formal.position = i) then
							if l_generics = a_type.generics then
								Result := a_type.duplicate
								l_generics := Result.generics
							end
							l_generics.put (a_class_type.type.generics.item (i), i)
						end
					end
					i := i + 1
				end
			end
		ensure
			normalized: Result /= Void
		end

	same_for_generics (a_current_class, a_class: CLASS_C): BOOLEAN is
			-- Is `a_current_class' using the same sets of generics as `a_class'.
			-- That is to say that `a_current_class' and `a_class' have the same number of
			-- generic parameter, and that each of them have the same routine ID.
			-- If `a_current_class' has not generic parameter then it is safe to assume True.
		require
			a_class_not_void: a_class /= Void
		local
			i, j, k, nb: INTEGER
			l_id_set, l_other_id_set: ROUT_ID_SET
		do
			if a_current_class.generics = Void then
				Result := True
			elseif a_class.generics /= Void and then (a_current_class.generics.count = a_class.generics.count) then
					-- They have the same number of generics, let's check they relate.
				from
					i := 1
					nb := a_current_class.generics.count
					Result := True
				until
					i > nb or not Result
				loop
					l_id_set := a_current_class.formal_at_position (i).rout_id_set
					l_other_id_set := a_class.formal_at_position (i).rout_id_set
					from
						j := 1
						k := l_id_set.count
						Result := False
					until
						j > k
					loop
						if l_other_id_set.has (l_id_set.item (j)) then
							Result := True
							j := k
						end
						j := j + 1
					end
					i := i + 1
				end
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

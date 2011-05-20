note
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
			is_feature_special, has_call, allocates_memory,
			is_unsafe, optimized_byte_node,
			calls_special_features, is_special_feature,
			size, pre_inlined_code, inlined_byte_code
		end

	SHARED_TABLE

	SHARED_SERVER

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; t: like type; p_type: like precursor_type)
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
			is_object_relative := f.is_object_relative_once
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

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		local
			c: CL_TYPE_A
			f: FEATURE_I
			l_node: ACCESS_B
		do
			c ?= context_type
			if system.il_generation and then not (c.is_expanded and c.is_basic) then
					-- We cannot optimize .NET feature calls at this point. See eweasel test#term202
					-- for an example where trying to optimize is not working properly: the issue is
					-- that the typing gets confused between inherited context and descendant context
					-- we do call `{BYTE_CONTEXT}.real_type.
					-- We only optimize calls on basic expanded type.
				v.process_feature_b (Current)
			else
				if not context.is_written_context then
						-- Ensure the feature is not redeclared into attribute.
					f := c.associated_class.feature_of_rout_id (routine_id)
					debug ("fixme")
						(create {REFACTORING_HELPER}).fixme ("Correct evaluation of context type of an operator call.")
					end
					if attached f and then not f.is_attribute then
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
					if attached {like Current} l_node as l_feat then
						v.process_feature_b (l_feat)
					else
						l_node.process (v)
					end
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

	is_object_relative: BOOLEAN
			-- Is current feature object-relative?

	is_thread_relative: BOOLEAN
			-- Is current feature thread-relative?
		do
			Result := not (is_process_relative or is_object_relative)
		end

	parameters: BYTE_LIST [PARAMETER_B]
			-- Feature parameters: can be Void

	set_parameters (p: like parameters)
			-- Assign `p' to `parameters'.
		local
			i: INTEGER
		do
			parameters := p
			if p /= Void then
					-- Set all parameter parents to `Current'.
				from
					i := p.count
				until
					i = 0
				loop
					p [i].set_parent (Current)
					i := i - 1
				end
			end
		end

	set_type (t: like type)
			-- Assign `t' to `type'.
		do
			type := t
		end

	is_any_feature: BOOLEAN
			-- Is Current an instance of ANY_FEATURE_B?
		do
		end

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN
			-- Search for feature_name in special_routines.
			-- This is used for simple types only.
			-- If found return True (and keep reference position).
			-- Otherwize, return false
		do
			Result := special_routines.has (feature_name_id, compilation_type, target_type)
		end

	is_feature: BOOLEAN = True
			-- Is Current an access to an Eiffel feature ?

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		local
			feature_b: FEATURE_B
		do
			feature_b ?= other
			if feature_b /= Void then
				Result := feature_id = feature_b.feature_id
			end
		end

	enlarged: CALL_ACCESS_B
			-- Enlarge the tree to get more attributes and return the
			-- new enlarged tree node.
		do
			Result := enlarged_on (context_type)
		end

	enlarged_on (type_i: TYPE_A): CALL_ACCESS_B
			-- Enlarged byte node evaluated in the context of `type_i'.
		local
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
					create {FEATURE_BL} Result.fill_from (Current)
				else
					create {FEATURE_BW} Result.fill_from (Current)
				end
			else
					-- Create new byte node and process it instead of the current one.
				Result ?= byte_node (f, type_i).enlarged
			end
		end

feature -- Status report

	has_call: BOOLEAN = True
			-- <Precursor>

	allocates_memory: BOOLEAN = True
			-- <Precursor>
			--| Ideally a feature call does not always allocate memory, but it
			--| would be quite expensive to compute that information at the moment,
			--| so we always assume it allocates some.

feature -- Context type

	context_type: TYPE_A
			-- Context type of the access (properly instantiated)
		do
			if precursor_type = Void then
				Result := Precursor {CALL_ACCESS_B}
			else
				Result := Context.real_type (precursor_type)
				if Result.is_multi_constrained then
					check
						has_multi_constraint_static: has_multi_constraint_static
					end
					Result := context.real_type (multi_constraint_static)
				end
			end
		end

feature -- Array optimization

	is_special_feature: BOOLEAN
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

	is_unsafe: BOOLEAN
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

	optimized_byte_node: like Current
		do
			Result := Current
			if parameters /= Void then
				parameters := parameters.optimized_byte_node
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			if parameters /= Void then
				Result := parameters.calls_special_features (array_desc)
			end
		end

feature {NONE} -- Array optimization

	optimizer: ARRAY_OPTIMIZER
		do
			Result := System.remover.array_optimizer
		end

feature -- Inlining

	size: INTEGER
		do
			if parameters /= Void then
				Result := 1 + parameters.size
			else
				Result := 1
			end
		end

	pre_inlined_code: CALL_B
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
			if parameters /= Void then
				set_parameters (parameters.pre_inlined_code)
			end
		end

	inlined_byte_code: ACCESS_B
		local
			inlined_feat_b: INLINED_FEAT_B
			inline, l_is_deferred_inlinable: BOOLEAN
			inliner: INLINER
			type_i: TYPE_A
			cl_type, desc_cl_type, written_cl_type: CL_TYPE_A
			bc: STD_BYTE_CODE
			l_rout_table: ROUT_TABLE
			l_body_index: INTEGER
			entry: ROUT_ENTRY
			f: FEATURE_I
			context_class_type, written_class_type: CLASS_TYPE
			has_separate_formal_arguments: BOOLEAN
		do
				-- We have to disable inlining if target is a multi constraint. This fixes eweasel
				-- test#final0978 and test#final094.
			has_separate_formal_arguments :=
				system.is_scoop and then
				attached parameters as p and then
				across p as parameter some context.real_type (parameter.item.attachment_type).is_separate end
			if not is_once and then not has_separate_formal_arguments then
				type_i := context_type
				if not type_i.is_basic then
						-- Inline only if it is not polymorphic and if it can be inlined.
					if Eiffel_table.is_polymorphic (routine_id, type_i, context.context_class_type, True) = -1 then
						l_rout_table ?= eiffel_table.poly_table (routine_id)
						l_rout_table.goto_implemented (type_i, context.context_class_type)
							-- Only if it is implemented that we can inline it.
						if l_rout_table.is_implemented then
							inliner := System.remover.inliner
							entry := l_rout_table.item
							l_body_index := entry.body_index
								-- We need to instantiate `type' in current context to fix eweasel test#final065.
							inline := inliner.inline (context.real_type (type), l_body_index)

								-- Special handling of deferred routine with one implementation in more than one
								-- descendants which do not conform to each other. To avoid the expensive cost of
								-- the computation we check first that the context type is deferred. This fixes
								-- eweasel test#final087.
							if inline and type_i.associated_class.is_deferred then
									-- The routine in the deferred class could be deferred and we need to
									-- ensure that all implementations of Current are forming an inheritance
									-- line, not a tree as if it is a tree, inlining has to be done from the top
									-- of the tree not from the first implemented version we found.
									-- Ideally we could figure it out, but it is more complicated, for the time
									-- being we disallow inlining in those rare cases. See eweasel test#final087.
								l_is_deferred_inlinable := l_rout_table.is_inlinable (type_i, context.context_class_type)
							else
								l_is_deferred_inlinable := True
							end
						end
					end
				end
			end

			if inline then
				cl_type ?= type_i -- Cannot fail
					-- Get information on the routine being inlined.
				f := system.class_of_id (entry.class_id).feature_of_feature_id (entry.feature_id)
					-- Ensure the feature is not redeclared into attribute or external routine
				if f.is_attribute then
						-- Changed the FEATURE_B into an ATTRIBUTE_B only if attribute is not of
						-- an attached type in some descendant that declares an explicit body for it.
						-- This is necessary because if the attribute requires a wrapper, often the wrapper
						-- is only known to the descendant, not the ancestor. This fixes test#final076.
					if not Eiffel_table.poly_table (f.rout_id_set.first).is_initialization_required (type_i, context.context_class_type) then
							-- Create new byte node and process it instead of the current one
						Result := byte_node (f, type_i).inlined_byte_code
					else
						Result := Current
					end
				elseif f.is_external or else f.is_constant then
						-- Create new byte node and process it instead of the current one
					Result := byte_node (f, type_i).inlined_byte_code
				elseif l_is_deferred_inlinable then
						-- Adapt context type `cl_type' to the appropriate context.
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
						-- by generating the code from the context in which it is defined (see eweasel test#final048
						-- for an example of the `else' part).
					if
						cl_type.associated_class.simple_conform_to (f.written_class) or
						f.written_class.simple_conform_to (cl_type.associated_class)
					then
							-- Now try to find a proper descendant type for the candidate for inlining. There is
							-- two possibility here: The class associated with `entry' is the same as `cl_type'
							-- (case of a routine implemented in an ancestor), or `entry' is a descendant of `cl_type'
							-- (case of a deferred routine of `cl_type' with one implementation in descendant).
						desc_cl_type := cl_type.find_descendant_type (system.class_of_id (entry.class_id))
						if desc_cl_type = Void then
								-- No valid descendant was found, therefore we cancel inlining (see
								-- eweasel test#final083).
								-- Note: This case means that the descendant is adding some new formal
								-- generic parameters that cannot be guessed in the current context.
								-- If the routine being inlined had no reference to the new formals
								-- then we could ideally allow it, but this is quite difficult at this
								-- time to perform this check.
							inline := False
						else
								-- We could find a descendant type, thus we can try to inline.
							cl_type := desc_cl_type

								-- Get the CLASS_TYPE from `cl_type'.
							context_class_type := cl_type.associated_class_type (context.context_cl_type)

								-- If `cl_type' has some formals, then they are formals that make sense for
								-- `context.context_class_type', but clearly not for `context_class_type'
								-- (see eweasel test#fina061 when inlining `set_value' in TEST1 [G]). Whenever
								-- possible we sanitize `cl_type' but worst case scenario it is `context_class_type.type'.
							cl_type := sanitized_type (cl_type, context_class_type.type)

								-- Get the actual type for code generation. At this stage we know for sure
								-- that it is either written in `cl_type' or one of its ancestor. It cannot
								-- be a descendant since we have already computed it above with `find_descendant_type'
							if cl_type.class_id = f.written_in then
									-- Optimization if this is the same class.
								written_cl_type := cl_type
							else
									-- Find the ancestor type.
								check
									ancestor: cl_type.associated_class.inherits_from (f.written_class)
								end
								written_cl_type := cl_type.find_class_type (f.written_class)
							end

								-- Get the CLASS_TYPE for the class defining `f'.
							written_class_type := context_class_type.type.implemented_type (f.written_in).associated_class_type (Void)

								-- If `written_cl_type' has some formals, then they are formals that make sense for
								-- `context.context_class_type', but clearly not for `written_class_type'
								-- (see eweasel test#fina062 when inlining `set_value' in TEST1 [G]). In this
								-- scenario, we have no choice to take the least optimized type from `written_class_type'.
							written_cl_type := sanitized_type (written_cl_type, written_class_type.type)
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
						desc_cl_type := cl_type.find_descendant_type (system.class_of_id (entry.class_id))
						if
							desc_cl_type = Void or else
							not same_for_generics (desc_cl_type.associated_class, cl_type.associated_class)
						then
								-- Another failures are test#final091 and test#final097 which we test
								-- by checking' the precondition of `associated_class_type'.
							inline := False
						else
								-- `f' cannot be implemented in the descendant version for which the first
								-- implementation of `f' appears, otherwise we would go via the `then' part
								-- of the current if then else.
							cl_type := desc_cl_type
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
					end

					if inline then
							-- We can safely inline.
							-- Creation of a special node for the entire
							-- feature (descendant of STD_BYTE_CODE)
						inliner.set_current_feature_inlined

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
						-- Case of an inline deferred routine that we cannot really inlined.
					inline := False
				end
			end

			if not inline then
					-- We could not inline, we perform a simple call as usual.
				Result := Current
				if parameters /= Void then
					parameters := parameters.inlined_byte_code
				end
			end
		end

feature {NONE} -- Normalization of types

	sanitized_type (a_type, a_sanitized_type: CL_TYPE_A): CL_TYPE_A
			-- If `a_type' is generic, ensures that all the formals referenced in `a_type'
			-- are mapped to the proper formal generic parameter of `a_sanitized_type'.
		local
			i, nb: INTEGER
			l_generics, l_new_generics: ARRAY [TYPE_A]
			l_type: TYPE_A
		do
			Result := a_type
			if attached {GEN_TYPE_A} a_type as l_gen_type then
				from
					l_generics := a_type.generics
					i := l_generics.lower
					nb := l_generics.upper
				until
					i > nb
				loop
					l_type := l_generics.item (i).actual_type
					if attached {FORMAL_A} l_type as l_formal then
						if l_formal.position /= i then
							if l_new_generics = Void then
								Result := Result.duplicate_for_instantiation
								l_new_generics := Result.generics
							end
							l_new_generics.put (a_sanitized_type.generics.item (i), i)
						end
					elseif l_type.has_formal_generic then
							-- There is a formal generic, but then it becomes harder to substitute that formal
							-- generic parameter with the correct one, we use `a_sanitized_type'.
						if l_new_generics = Void then
							Result := Result.duplicate_for_instantiation
							l_new_generics := Result.generics
						end
						l_new_generics.put (a_sanitized_type.generics.item (i), i)
					end
					i := i + 1
				end
			end
		end

	same_for_generics (a_current_class, a_class: CLASS_C): BOOLEAN
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
					l_id_set := a_current_class.formal_rout_id_set_at_position (i)
					l_other_id_set := a_class.formal_rout_id_set_at_position (i)
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

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

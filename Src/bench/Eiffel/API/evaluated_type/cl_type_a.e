indexing
	description: "Description of an actual class type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CL_TYPE_A

inherit
	NAMED_TYPE_A
		redefine
			is_expanded, is_reference, is_separate, instantiation_in, valid_generic,
			duplicate, meta_type, same_as, good_generics, error_generics,
			has_expanded, is_valid, format, convert_to,
			is_full_named_type, is_external, is_conformant_to
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_class_id: INTEGER) is
		require
			valid_class_id: a_class_id > 0
		do
			class_id := a_class_id
		ensure
			class_id_set: class_id = a_class_id
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_cl_type_a (Current)
		end

feature -- Properties

	has_no_mark: BOOLEAN is
			-- Has class type no explicit mark?
		do
			Result := declaration_mark = no_mark
		ensure
			definition: Result = (declaration_mark = no_mark)
		end

	has_expanded_mark: BOOLEAN is
			-- Is class type explicitly marked as expanded?
		do
			Result := declaration_mark = expanded_mark
		ensure
			definition: Result = (declaration_mark = expanded_mark)
		end

	has_reference_mark: BOOLEAN is
			-- Is class type explicitly marked as reference?
		do
			Result := declaration_mark = reference_mark
		ensure
			definition: Result = (declaration_mark = reference_mark)
		end

	has_separate_mark: BOOLEAN is
			-- Is class type explicitly marked as reference?
		do
			Result := declaration_mark = separate_mark
		ensure
			definition: Result = (declaration_mark = separate_mark)
		end

	is_expanded: BOOLEAN is
			-- Is the type expanded?
		do
			Result := has_expanded_mark or else has_no_mark and then associated_class.is_expanded
		end

	is_reference: BOOLEAN is
			-- Is the type a reference type?
		do
			Result := has_reference_mark or else has_no_mark and then not associated_class.is_expanded
		end

	is_separate: BOOLEAN is
			-- Is the type separate?
		do
			Result := has_separate_mark
		end

	is_valid: BOOLEAN is
			-- Is Current still valid?
			-- I.e. its `associated_class' is still in system.
		do
			Result := associated_class /= Void
		end

	is_full_named_type: BOOLEAN is
			-- Current is a full named type.
		do
			Result := True
		end

	is_external: BOOLEAN is
			-- Is current type based on an external calss?
		local
			l_base_class: like associated_class
		do
			l_base_class := associated_class
			Result := is_basic or (not l_base_class.is_basic and l_base_class.is_external)
		end

	is_system_object_or_any: BOOLEAN is
			-- Does current type represent SYSTEM_OBJECT or ANY?
		require
			il_generation: System.il_generation
		local
			l_class_id: like class_id
			l_system: like system
		do
			l_class_id := class_id
			l_system := system
			Result := l_class_id = l_system.system_object_class.compiled_class.class_id or
				l_class_id = l_system.any_class.compiled_class.class_id
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := declaration_mark = other.declaration_mark and then
				class_declaration_mark = other.class_declaration_mark and then
				class_id = other.class_id
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code value.
		do
			Result := class_id
		end

	class_id: INTEGER
			-- Class id of the associated class

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_class_type: CL_TYPE_A
		do
			other_class_type ?= other
			Result := other_class_type /= Void and then class_id = other_class_type.class_id
						and then is_expanded = other_class_type.is_expanded
						and then is_separate = other_class_type.is_separate
		end

	associated_class: CLASS_C is
			-- Associated class to the type
		do
			Result := System.class_of_id (class_id)
		end

feature -- Output

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			if has_expanded_mark then
				st.add (ti_expanded_keyword)
				st.add_space
			elseif has_reference_mark then
				st.add (ti_reference_keyword)
				st.add_space
			elseif has_separate_mark then
				st.add (ti_separate_keyword)
				st.add_space
			end
			associated_class.append_name (st)
		end

	dump: STRING is
			-- Dumped trace
		local
			class_name: STRING
		do
			class_name := associated_class.name_in_upper
			if has_expanded_mark then
				create Result.make (class_name.count + 9)
				Result.append ("expanded ")
			elseif has_reference_mark then
				create Result.make (class_name.count + 10)
				Result.append ("reference ")
			elseif has_separate_mark then
				create Result.make (class_name.count + 9)
				Result.append ("separate ")
			else
				create Result.make (class_name.count)
			end
			Result.append (class_name)
		end

feature {COMPILER_EXPORTER} -- Settings

	set_expanded_class_mark is
			-- Mark class declaration as expanded.
		do
			class_declaration_mark := expanded_mark
		ensure
			has_expanded_class_mark: class_declaration_mark = expanded_mark
		end

	set_expanded_mark is
			-- Set class type declaration as expanded.
		do
			declaration_mark := expanded_mark
		ensure
			has_expanded_mark: has_expanded_mark
		end

	set_reference_mark is
			-- Set class type declaration as reference.
		do
			declaration_mark := reference_mark
		ensure
			has_reference_mark: has_reference_mark
		end

	set_separate_mark is
			-- Set class type declaration as separate.
		do
			declaration_mark := separate_mark
		ensure
			has_separate_mark: has_separate_mark
		end

	type_i: CL_TYPE_I is
			-- C type
		do
			create Result.make (class_id)
			Result.set_mark (declaration_mark)
		end

	meta_type: TYPE_I is
			-- Meta type of the type
		do
			if is_expanded then
				Result := type_i
			else
				Result := Reference_c_type
			end
		end

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		do
			Result := associated_class.generics = Void
		end

	error_generics: VTUG is
		do
			create {VTUG2} Result
			Result.set_type (Current)
			Result.set_base_class (associated_class)
		end

	has_expanded: BOOLEAN is
			-- Has the current type some expanded types in its declration ?
		do
			Result := is_expanded
		end

feature {COMPILER_EXPORTER} -- Conformance

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_checker: CONVERTIBILITY_CHECKER
		do
			create l_checker
			l_checker.check_conversion (a_context_class, Current, a_target_type)
			Result := l_checker.last_conversion_check_successful
			if Result then
				context.set_last_conversion_info (l_checker.last_conversion_info)
			else
				context.set_last_conversion_info (Void)
			end
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			other_class_type: CL_TYPE_A
		do
			other_class_type ?= other.conformance_type
			if other_class_type /= Void then
				if other_class_type.is_expanded then
						-- It should be the exact same base class for expanded.
					Result := is_expanded and then class_id = other_class_type.class_id
						and then other_class_type.valid_generic (Current)
				else
					Result :=
						associated_class.conform_to (other_class_type.associated_class)
						and then other_class_type.valid_generic (Current)
					if not Result and then system.il_generation and then system.system_object_class /= Void then
							-- Any type in .NET conforms to System.Object
						check
							system.system_object_class.is_compiled
						end
						Result := other_class_type.class_id = system.system_object_id
					end
				end
			end
		end

	is_conformant_to (other: TYPE_A): BOOLEAN is
			-- Does Current inherit from other?
			-- Most of the time, it is equivalent to `conform_to' except
			-- when current is an expanded type.
		local
			l_is_exp, l_other_is_exp: BOOLEAN
			l_other_class_type: CL_TYPE_A
			current_mark: like declaration_mark
			other_mark: like declaration_mark
		do
			l_other_class_type ?= other.actual_type
			if l_other_class_type /= Void then
					-- We perform conformance as if the two types were not
					-- expanded. So, if they are expanded, we remove their
					-- expanded flag to do the conformance check.
				l_is_exp := is_expanded
				l_other_is_exp := l_other_class_type.is_expanded
				if l_is_exp then
					current_mark := declaration_mark
					set_reference_mark
				end
				if l_other_is_exp then
					other_mark := l_other_class_type.declaration_mark
					l_other_class_type.set_reference_mark
				end

				Result := conform_to (other)

				if l_is_exp then
					set_mark (current_mark)
				end
				if l_other_is_exp then
					l_other_class_type.set_mark (other_mark)
				end
			end
		end

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Do the generic parameter of `type' conform to those
			-- of Current (none).
		do
			Result := True
		end

	generic_conform_to (gen_type: GEN_TYPE_A): BOOLEAN is
			-- Does Current conform to `gen_type' ?
		require
			good_argument: gen_type /= Void
			associated_class.conform_to (gen_type.associated_class)
		local
			i, count: INTEGER
			parent_actual_type: TYPE_A
			parents: FIXED_LIST [CL_TYPE_A]
		do
			from
				parents := associated_class.parents
				i := 1
				count := parents.count
			until
				i > count or else Result
			loop
				parent_actual_type := parent_type (parents.i_th (i))
				Result := parent_actual_type.conform_to (gen_type)
				i := i + 1
			end
		end

	parent_type (parent: CL_TYPE_A): TYPE_A is
			-- Parent actual type.
		require
			parent_not_void: parent /= Void
		do
			Result := parent.duplicate
		ensure
			result_not_void: Result /= Void
		end

feature {COMPILER_EXPORTER} -- Instantitation of a feature type

	feature_type (f: FEATURE_I): TYPE_A is
			-- Instantiation of the feature type in the context of
			-- current
		require
			good_argument: f /= Void
			associated_class.conform_to (f.written_class)
			feature_type_is_solved: f.type.is_solved
		local
			feat_type: TYPE_A
		do
			feat_type ?= f.type
			Result := feat_type.instantiation_in (Current, f.written_in)
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in `written_id'
		local
			class_type: CL_TYPE_A
		do
			class_type ?= type
			if class_type /= Void then
				Result := class_type.instantiation_of (Current, written_id)
			else
				Result := Current
			end
		end

feature {COMPILER_EXPORTER} -- Instantiation of a type in the context of a descendant one

	instantiation_of (type: TYPE_A; a_class_id: INTEGER): TYPE_A is
			-- Instantiation of type `type' written in class of id `a_class_id'
			-- in the context of Current
		local
			instantiation: TYPE_A
			gen_type: GEN_TYPE_A
		do
			if a_class_id = class_id then
					-- Feature is written in the class associated to the
					-- current actual class type
				instantiation := Current
			else
				instantiation := find_class_type (System.class_of_id (a_class_id))
			end
			Result := type.actual_type
			if instantiation.generics /= Void and instantiation.generics.count > 0 then
					-- Does not make sense to instantiate if `instantation' is
					-- a TUPLE with no arguments.
				gen_type ?= instantiation
				Result := gen_type.instantiate (Result)
			end
		end

	find_class_type (c: CLASS_C): CL_TYPE_A is
			-- Actual type of class of id `class_id' in current
			-- context
		require
			good_argument: c /= Void
			conformance: associated_class.conform_to (c)
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent: CL_TYPE_A
			parent_class: CLASS_C
			i, count: INTEGER
			parent_class_type: CL_TYPE_A
		do
			from
				parents := associated_class.parents
				i := 1
				count := parents.count
			until
				i > count or else Result /= Void
			loop
				parent := parents.i_th (i)
				parent_class := parent.associated_class
				if parent_class = c then
						-- Class `c' is found
					Result ?= parent_type (parent)
				elseif parent_class.conform_to (c) then
						-- Iterate in the inheritance graph and
						-- conformance tables help to take the good
						-- way in the parents
					parent_class_type ?= parent_type (parent)
					Result := parent_class_type.find_class_type (c)
				end
				i := i + 1
			end
		end

	duplicate: like Current is
			-- Duplication
		do
			Result := twin
		end

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			create Result.make (type_i)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Format current.
		do
			ctxt.put_classi (associated_class.lace_class)
		end

feature -- Debugging

	debug_output: STRING is
			-- Display name of associated class.
		do
			if is_valid then
				Result := dump
			else
				Result := "Class not in system anymore"
			end
		end

feature {CL_TYPE_A, CL_TYPE_I, TUPLE_CLASS_B} -- Implementation: class type declaration marks

	declaration_mark: NATURAL_8
			-- Declaration mark associated with a class type (if any)

	class_declaration_mark: NATURAL_8
			-- Declaration mark associated with class

	set_mark (mark: like declaration_mark) is
			-- Set `declaration_mark' to the given value `mark'.
		require
			valid_declaration_mark:
				mark = no_mark or mark = expanded_mark or
				mark = reference_mark or mark = separate_mark
		do
			declaration_mark := mark
		ensure
			declaration_mark_set: declaration_mark = mark
		end

	no_mark: NATURAL_8 is 0
			-- Empty declaration mark

	expanded_mark: NATURAL_8 is 1
			-- Expanded declaration mark

	reference_mark: NATURAL_8 is 2
			-- Reference declaration mark

	separate_mark: NATURAL_8 is 3
			-- Separate declaration mark

invariant
	class_id_positive: class_id > 0
	valid_declaration_mark: declaration_mark = no_mark or declaration_mark = expanded_mark or
		declaration_mark = reference_mark or declaration_mark = separate_mark
	valid_class_declaration_mark:
		class_declaration_mark = no_mark or
		class_declaration_mark = expanded_mark or
		class_declaration_mark = reference_mark or
		class_declaration_mark = separate_mark

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

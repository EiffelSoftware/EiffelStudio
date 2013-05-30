note
	description: "[
		Find all types in system. It includes reference class types and
		expanded class types, as well as all generic derivations of a given
		class.

		Call to routine `dispatch' are done in second pass for treating generic
		types in inheritance clause, at the end of second pass for types in
		feature arguments or result and during third pass while evaluating local types.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INSTANTIATOR

inherit
	FILTER_LIST

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

	SHARED_COUNTER
		undefine
			copy, is_equal
		end

create
	make

create {INSTANTIATOR}
	make_with_key_tester

feature -- Processing

	dispatch (a_type: TYPE_A; a_class: CLASS_C)
			-- Treat generic type `a_type': it is either a new
			-- class filter or a new data. If it is a data, the instantiator
			-- keeps it, or it is a filter then it sends the new filter
			-- to the class `a_class'.
		require
			a_type_not_void: a_type /= Void
			a_class_not_void: a_class /= Void
		local
			type_i: CL_TYPE_A;
			i, nb: INTEGER;
			generics: ARRAYED_LIST [TYPE_A];
			insertion_list: FILTER_LIST;
		do
				-- Evaluation of a type class
			type_i ?= a_type

			if system.il_generation and then a_type.is_valid then
					-- If `a_type' has an anchor, we need to add them to `{CLASS_C}.type_set'.
					-- Currently this is only needed in .NET code generation.
				a_type.dispatch_anchors (a_class)
			end

				-- We do not record various type declaration of BIT x
				-- as we only need the one from BIT_REF.
			if type_i /= Void then
					-- Check if it is a data or a filter
				if type_i.is_loose then
						-- It is a filter: the insertion list is the filter
						-- list of `a_class'
					insertion_list := a_class.filters
					check
						class_has_generics: type_i.has_formal_generic implies a_class.generics /= Void
					end;
				else
						-- it is a data: the insertion list is the Current one
					insertion_list := Current
				end

				debug
					io.error.put_string ("Dispatch : ");
					io.error.put_string (a_class.name);
					io.error.put_integer (a_class.class_id);
					io.error.put_new_line;
					io.error.put_string (a_type.dump);
					io.error.put_new_line;
				end;

					-- Insert item in the insertion list if not present
				insertion_list.put (type_i)

					-- Recursion on the generic types
				generics := a_type.generics
				if generics /= Void then
					from
						i := 1
						nb := generics.count
					until
						i > nb
					loop
						dispatch (generics.i_th (i).actual_type, a_class)
						i := i + 1
					end
				end
			end
		end

	process
			-- Process the list in order to find new class types
		local
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER
		do
				-- Remove the obsolete class types
			class_array := System.classes
			nb := Class_counter.count
			from i := 1 until i > nb loop
				if attached class_array [i] as l_class then
					l_class.types.clean
				end
				i := i + 1
			end

				-- Ensures that all required classes are properly registered
			check_required_classes

				-- Remove the obsolete types
			clean_standalone

			from
				start
			until
				after
			loop
				item_for_iteration.base_class.update_types (item_for_iteration);
				forth
			end;
			derivations.wipe_out;
		end;

feature -- Removal

	clean_standalone
			-- Remove all invalid standalone types..
		do
				-- Use the class with the worst void-safety settings, i.e. root class,
				-- because these settings are used when performing conformance tests.
			clean (system.root_creators.first.root_class.compiled_class)
		end

	clean_all
			-- Clean up Current and all classes from obsolete type.
		local
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER
		do
				-- Remove obsolete class types in each class' filters.
			class_array := System.classes
			nb := Class_counter.count
			from i := 1 until i > nb loop
				if attached class_array [i] as l_class then
					l_class.filters.clean (l_class)
				end
				i := i + 1
			end
				-- Remove obsolete types from the global list.
			clean_standalone
		end

feature -- Access

	derivations: DERIVATIONS
			-- Set of all the processed derivations
			-- Avoid recursive loop in process
		once
			create Result.make (40)
		end

feature {NONE} -- Checks for predefined types

	check_required_classes
			-- Check that the associated types of all required
			-- classes are properly registered.
		require
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
			procedure_compiled: System.procedure_class.is_compiled
			function_compiled: System.function_class.is_compiled
			predicate_compiled: System.predicate_class.is_compiled
		local
			l_context_class: CLASS_C
		do
				-- Check array class
			l_context_class := System.array_class.compiled_class
			dispatch (Array_type_a, l_context_class)

				-- Check tuple class
			l_context_class := System.tuple_class.compiled_class
			dispatch (Tuple_type_a, l_context_class)

				-- Check function class
			l_context_class := System.function_class.compiled_class
			dispatch (Function_type_a, l_context_class)

				-- Check predicate class
			l_context_class := System.predicate_class.compiled_class
			dispatch (Predicate_type_a, l_context_class)

				-- Check procedure class
			l_context_class := System.procedure_class.compiled_class
			dispatch (Procedure_type_a, l_context_class)
		end

feature {STRIP_B, SYSTEM_I, AUXILIARY_FILES} -- Predefined types

	Array_type_a: GEN_TYPE_A
			-- Default array type.
			-- Not a once since `array_id' might change.
		require
			any_compiled: System.any_class.is_compiled;
			array_compiled: System.array_class.is_compiled;
		local
			any_type: CL_TYPE_A
			generics: ARRAYED_LIST [TYPE_A]
		do
				-- Not once because array_id and any_id can change
			create generics.make (1)
			create any_type.make (System.any_id)
			generics.extend (any_type)

			create Result.make (System.array_id, generics)
		end;

feature -- Predefined types

	Tuple_type_a: TUPLE_TYPE_A
			-- Default tuple type: TUPLE
		require
			tuple_compiled: System.tuple_class.is_compiled
		do
				-- Not once because tuple_id can change
			create Result.make (System.tuple_id, create {ARRAYED_LIST [TYPE_A]}.make (0))
		end;

	Function_type_a: GEN_TYPE_A
			-- Default function type: FUNCTION [ANY, TUPLE, ANY]
		require
			function_compiled: System.function_class.is_compiled
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
		local
			any_type: CL_TYPE_A
			generics: ARRAYED_LIST [TYPE_A]
		do
				-- Not once because function_id can change
			create generics.make (3)
			create any_type.make (System.any_id)
			generics.extend (any_type)
			generics.extend (Tuple_type_a)
			generics.extend (any_type)

			create Result.make (System.function_class_id, generics)
		end

	Predicate_type_a: GEN_TYPE_A
			-- Default function type: PREDICATE [ANY, TUPLE]
		require
			predicate_compiled: System.predicate_class.is_compiled
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
		local
			any_type: CL_TYPE_A
			generics: ARRAYED_LIST [TYPE_A]
		do
				-- Not once because function_id can change
			create generics.make (2)
			create any_type.make (System.any_id)
			generics.extend (any_type)
			generics.extend (Tuple_type_a)

			create Result.make (System.predicate_class_id, generics)
		end

	Procedure_type_a: GEN_TYPE_A
			-- Default procedure type: PROCEDURE [ANY, TUPLE]
		require
			procedure_compiled: System.procedure_class.is_compiled
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
		local
			any_type: CL_TYPE_A
			generics: ARRAYED_LIST [TYPE_A]
		do
				-- Not once because procedure_id can change
			create generics.make (2)
			create any_type.make (System.any_id)
			generics.extend (any_type)
			generics.extend (Tuple_type_a)

			create Result.make (System.procedure_class_id, generics)
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class INSTANTIATOR


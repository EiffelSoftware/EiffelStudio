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

feature -- Attributes

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
			generics: ARRAY [TYPE_A];
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
			if type_i /= Void and then not type_i.is_bit then
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
						dispatch (generics.item (i).actual_type, a_class)
						i := i + 1
					end
				end
			end
		end

	process
			-- Process the list in order to find new class types
		local
			data: like item
			a_class: CLASS_C;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER
		do
				-- Remove the obsolete class types
			class_array := System.classes
			nb := Class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					a_class.types.clean
				end
				i := i + 1
			end

				-- Check array class
			check_array_class

				-- Check tuple class
			check_tuple_class

				-- Check function class
			check_function_class

				-- Check predicate class
			check_predicate_class

				-- Check procedure class
			check_procedure_class

				-- Remove the obsolete types
			clean;

			from
				start
			until
				after
			loop
				data := item_for_iteration
				data.associated_class.update_types (data);
				forth
			end;
			derivations.clear_all;
		end;

	derivations: DERIVATIONS
			-- Set of all the processed derivations
			-- Avoid recursive loop in process
		once
			create Result.make (40);
		end;

feature {NONE}

	check_array_class
			-- Force an array type in the system
		require
			any_compiled: System.any_class.is_compiled;
			array_compiled: System.array_class.is_compiled;
		local
			array_cl: CLASS_C;
		do
			array_cl := System.array_class.compiled_class;
			dispatch (Array_type_a, array_cl);
		end;

	check_tuple_class
			-- Force a tuple type in the system
		require
			tuple_compiled: System.tuple_class.is_compiled
		local
			tuple_cl: CLASS_C;
		do
			tuple_cl := System.tuple_class.compiled_class;
			dispatch (Tuple_type_a, tuple_cl);
		end;

	check_function_class
			-- Force a function type in the system
		require
			function_compiled: System.function_class.is_compiled
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
		local
			funct_cl: CLASS_C;
		do
			funct_cl := System.function_class.compiled_class;
			dispatch (Function_type_a, funct_cl);
		end;

	check_procedure_class
			-- Force a procedure type in the system
		require
			procedure_compiled: System.procedure_class.is_compiled
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
		local
			proc_cl: CLASS_C;
		do
			proc_cl := System.procedure_class.compiled_class;
			dispatch (Procedure_type_a, proc_cl);
		end;

	check_predicate_class
			-- Force a predicate type in the system
		require
			predicate_compiled: System.predicate_class.is_compiled
			any_compiled: System.any_class.is_compiled
			array_compiled: System.array_class.is_compiled
			tuple_compiled: System.tuple_class.is_compiled
		local
			pred_cl: CLASS_C;
		do
			pred_cl := System.predicate_class.compiled_class;
			dispatch (Predicate_type_a, pred_cl);
		end;

feature

	Array_type_a: GEN_TYPE_A
			-- Default array type
		require
			any_compiled: System.any_class.is_compiled;
			array_compiled: System.array_class.is_compiled;
		local
			any_type: CL_TYPE_A;
			generics: ARRAY [TYPE_A];
		do
				-- Not once because array_id and any_id can change
			create generics.make (1, 1)
			create any_type.make (System.any_id)
			generics.put (any_type, 1)

			create Result.make (System.array_id, generics)
		end;

	Tuple_type_a: TUPLE_TYPE_A
			-- Default tuple type: TUPLE
		require
			tuple_compiled: System.tuple_class.is_compiled
		local
			generics: ARRAY [TYPE_A]
		do
				-- Not once because tuple_id can change
			create generics.make (1, 0)
			create Result.make (System.tuple_id, generics)
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
			generics: ARRAY [TYPE_A]
		do
				-- Not once because function_id can change
			create generics.make (1, 3)
			create any_type.make (System.any_id)
			generics.put (any_type, 1)
			generics.put (Tuple_type_a, 2)
			generics.put (any_type, 3)

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
			generics: ARRAY [TYPE_A]
		do
				-- Not once because function_id can change
			create generics.make (1, 2)
			create any_type.make (System.any_id)
			generics.put (any_type, 1)
			generics.put (Tuple_type_a, 2)

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
			generics: ARRAY [TYPE_A]
		do
				-- Not once because procedure_id can change
			create generics.make (1, 2)
			create any_type.make (System.any_id)
			generics.put (any_type, 1)
			generics.put (Tuple_type_a, 2)

			create Result.make (System.procedure_class_id, generics)
		end

feature {STRIP_B, SYSTEM_I, AUXILIARY_FILES}

	array_type: GEN_TYPE_A
			-- Default array type.
			-- Not a once since `array_id' might change.
		local
			true_gen: ARRAY [TYPE_A]
			any_type_a : TYPE_A
		do
			create true_gen.make (1, 1)
			any_type_a := system.any_class.compiled_class.actual_type
			true_gen.put (any_type_a, 1);
			create Result.make (System.array_id, true_gen)
		end;

note
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

end -- class INSTANTIATOR


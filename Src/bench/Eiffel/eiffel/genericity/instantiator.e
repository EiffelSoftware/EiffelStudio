indexing
	description: "[
		Find all types in system. It includes reference class types and
		expanded class types, as well as all generic derivations of a given
		class.
		
		Call to routine `dispatch' are done in second pass for treating generic
		types in inheritance clause, at the end of second pass for types in
		feature arguments or result and during third pass while evaluating local types.
		]"
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

	dispatch (a_type: TYPE_A; a_class: CLASS_C) is
			-- Treat generic type `a_type': it is either a new
			-- class filter or a new data. If it is a data, the instantiator
			-- keeps it, or it is a filter then it sends the new filter
			-- to the class `a_class'.
		require
			a_type_not_void: a_type /= Void
			a_class_not_void: a_class /= Void
		local
			type_i: CL_TYPE_I;
			i, nb: INTEGER;
			generics: ARRAY [TYPE_A];
			insertion_list: FILTER_LIST;
		do
				-- Evaluation of a type class
			type_i ?= a_type.type_i

				-- We do not record various type declaration of BIT x
				-- as we only need the one from BIT_REF.
			if type_i /= Void and then not type_i.is_bit then
					-- Check if it is a data or a filter
				if type_i.has_formal then
						-- It is a filter: the insertion list is the filter
						-- list of `a_class'
					insertion_list := a_class.filters
					check
						class_has_generics: a_class.generics /= Void
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

					-- Look for the item in the insertion list
				insertion_list.start;
				if not insertion_list.has_item (type_i) then
						-- New data or item
					insertion_list.extend (type_i)
				end

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

	process is
			-- Process the list in order to find new class types
		local
			data: like item
			l_area: like area
			a_class: CLASS_C;
			types: TYPE_LIST;
			class_type: CLASS_TYPE;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER
		do
				-- Check array class
			check_array_class

				-- Check tuple class
			check_tuple_class

				-- Check function class
			check_function_class

				-- Check procedure class
			check_procedure_class

				-- Remove the obsolete types
			clean;

			from
				i := 0
				nb := count - 1
				l_area := area
			until
				i > nb
			loop
				data := l_area.item (i);
debug
	io.error.put_string ("Adding data%N");
	data.trace
	io.error.put_new_line;
end;
				data.base_class.update_types (data);
				i := i + 1
			end;
			derivations.clear_all;

				-- Remove the obsolete class types
			class_array := System.classes
			nb := Class_counter.count
			from i := 1 until i > nb loop
				a_class := class_array.item (i)
				if a_class /= Void then
					from
						types := a_class.types;
						types.start
					until
						types.after
					loop
						class_type := types.item;
						if not class_type.type.is_valid then
debug
io.error.put_string ("Removing a type of ");
io.error.put_string (a_class.name);
io.error.put_new_line;
end;
							System.class_types.put (Void, class_type.type_id);
							types.remove;
						else
							types.forth
						end;
					end;
				end
				i := i + 1
			end
		end;

	derivations: DERIVATIONS is
			-- Set of all the processed derivations
			-- Avoid recursive loop in process
		once
			create Result.make (40);
		end;

feature {NONE}

	check_array_class is
			-- Force an array type in the system
		require
			any_compiled: System.any_class.is_compiled;
			array_compiled: System.array_class.is_compiled;
		local
			array_cl: CLASS_C;
			array_t: GEN_TYPE_I;
		do
			array_cl := System.array_class.compiled_class;
			dispatch (Array_type_a, array_cl);
			array_t := Array_type;
			--array_cl.update_types (Array_type);
		end;

	check_tuple_class is
			-- Force a tuple type in the system
		require
			tuple_compiled: System.tuple_class.is_compiled
		local
			tuple_cl: CLASS_C;
			tuple_t: GEN_TYPE_I;
		do
			tuple_cl := System.tuple_class.compiled_class;
			dispatch (Tuple_type_a, tuple_cl);
			tuple_t := Tuple_type;
		end;

	check_function_class is
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

	check_procedure_class is
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

feature

	Array_type_a: GEN_TYPE_A is
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
			Result.set_is_expanded (False)
		end;

	Tuple_type_a: TUPLE_TYPE_A is
			-- Default tuple type: TUPLE
		require
			tuple_compiled: System.tuple_class.is_compiled
		local
			generics: ARRAY [TYPE_A]
		do
				-- Not once because tuple_id can change
			create generics.make (1, 0)
			create Result.make (System.tuple_id, generics)
			Result.set_is_expanded (False)
		end;

	Function_type_a: GEN_TYPE_A is
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
			Result.set_is_expanded (False)
		end

	Procedure_type_a: GEN_TYPE_A is
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
			Result.set_is_expanded (False)
		end

feature {STRIP_B, SYSTEM_I, AUXILIARY_FILES, MULTI_TYPE_A}

	Array_type: GEN_TYPE_I is
			-- Default array type
		local
			ref: REFERENCE_I;
			meta_gen: META_GENERIC;
			true_gen: ARRAY [TYPE_I]
			any_type_i : TYPE_I
			any_type_a : TYPE_A
		do
				--- Not once because array_id can change
			create ref;
			create meta_gen.make (1);
			meta_gen.put (ref, 1);
			create true_gen.make (1, 1);
			any_type_a := ref.type_a;

			if any_type_a /= Void then
				any_type_i := any_type_a.type_i;
			end;

			if any_type_i /= Void then
				true_gen.put (any_type_i, 1);
			else
				-- Should never happen!
				true_gen.put (ref, 1);
			end;
			create Result.make (System.array_id)
			Result.set_meta_generic (meta_gen);
			Result.set_true_generics (true_gen);
		end;

	Tuple_type: TUPLE_TYPE_I is
			-- Default tuple type
		do
			Result := Tuple_type_a.type_i
		ensure
			Result_not_void: Result /= Void
		end;

end -- class INSTANTIATOR


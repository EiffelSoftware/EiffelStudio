-- Genericity duplication processor: we call "data" a generic type
-- (instance of GEN_TYPE_A) which has no formal type in its array `generics'.
-- We call filter a generic type which has at least o formal parameter
-- (instance of FORMAL_A) in its array `generics'.

-- Call to routine `dispatch' are done in second pass for treating generic
-- types in inheritance clause, at the end of second pass for generic
-- types in feature arguments or result and during third pass while
-- evaluating local types.

class INSTANTIATOR 

inherit

	FILTER_LIST
		redefine
			trace
		end;
	SHARED_WORKBENCH;
	COMPILER_EXPORTER;
	SHARED_COUNTER

creation

	make
	
feature -- Attributes

	dispatch (generic_type: GEN_TYPE_A; a_class: CLASS_C) is
			-- Treat generic type `generic_type': it is either a new
			-- class filter or a new data. If it is a data, the instantiator
			-- keeps it, or it is a filter then it sends the new filter
			-- to the class `a_class'.
		require
			good_type: generic_type /= Void;
			good_class: a_class /= Void
--			class_changed: a_class.changed;
		local
			type_i: GEN_TYPE_I;
			i, nb: INTEGER;
			another_generic: GEN_TYPE_A;
			generics: ARRAY [TYPE_A];
			insertion_list: FILTER_LIST;
		do
				-- Evaluation of a type class
			type_i := generic_type.type_i

				-- In case of expanded
			type_i.set_is_expanded (False)

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
	io.error.putstring ("Dispatch : ");
	io.error.putstring (a_class.name);
	a_class.id.trace;
	io.error.new_line;
	io.error.putstring (generic_type.dump);
	io.error.new_line;
end;

				-- Look for the item in the insertion list
			insertion_list.start;
			insertion_list.search (type_i)
			if insertion_list.after then
					-- New data or item
				insertion_list.put_front (type_i)
			end

				-- Recursion on the generic types
			from
				i := 1
				generics := generic_type.generics
				nb := generics.count
			until
				i > nb
			loop
				another_generic ?= generics.item (i).actual_type
				if another_generic /= Void then
					dispatch (another_generic, a_class)
				end
				i := i + 1
			end
		end

	process is
			-- Process the list in order to find new class types
		local
			data: GEN_TYPE_I;
			local_cursor: LINKABLE [GEN_TYPE_I];
			a_class: CLASS_C;
			types: TYPE_LIST;
			class_type: CLASS_TYPE;
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER
		do
				-- Check array class
			check_array_class;

				-- Remove the obsolete types
			clean;

			from
				local_cursor := first_element
			until
				local_cursor = Void
			loop
				data := local_cursor.item;
debug
	io.error.putstring ("Adding data%N");
	data.dump (io.error);
	io.error.new_line;
end;
				data.base_class.update_types (data);
				local_cursor := local_cursor.right;
			end;
			derivations.clear_all;

				-- Remove the obsolete class types
			classes := System.classes;
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
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
	io.error.putstring ("Removing a type of ");
	io.error.putstring (a_class.name);
	io.error.new_line;
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
				classes.forth
			end;
		end;

	derivations: DERIVATIONS is
			-- Set of all the processed derivations
			-- Avoid recursive loop in process
		once
			!!Result.make (40);
		end;

feature {NONE}

	check_array_class is
			-- Force an array type in the system
		local
			array_cl: CLASS_C;
			array_t: GEN_TYPE_I;
		do
			array_cl := System.array_class.compiled_class;
			dispatch (Array_type_a, array_cl);
			array_t := Array_type;
			--array_cl.update_types (Array_type);
		end;

feature

	Array_type_a: GEN_TYPE_A is
			-- Default array type
		require
			any_compiled: System.any_class.compiled;
			array_compiled: System.array_class.compiled;
		local
			any_type: CL_TYPE_A;
			generics: ARRAY [TYPE_A];
		do
				-- Not once because array_id and any_id can change
			!!Result;
			Result.set_base_class_id (System.array_id);
			!!generics.make (1, 1);
			!!any_type;
			any_type.set_base_class_id (System.any_id);
			generics.put (any_type, 1);
			Result.set_generics (generics);
			Result.set_is_expanded (False);
		end;

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
			!!ref;
			!!meta_gen.make (1);
			meta_gen.put (ref, 1);
			!!true_gen.make (1, 1);
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
			!!Result;
			Result.set_meta_generic (meta_gen);
			Result.set_true_generics (true_gen);
			Result.set_base_id (System.array_id);
		end;

feature -- Debug

	trace is
		local
			data: GEN_TYPE_I;
			local_cursor: LINKABLE [GEN_TYPE_I];
		do
			io.error.putstring ("Instantiator.trace%N");
			from
				local_cursor := first_element
			until
				local_cursor = Void
			loop
				data := local_cursor.item;
				data.dump (io.error);
				io.error.new_line;
				local_cursor := local_cursor.right;
			end;
		end;

end

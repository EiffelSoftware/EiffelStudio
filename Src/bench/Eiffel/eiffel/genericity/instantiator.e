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

	FILTER_LIST;
	SHARED_WORKBENCH

creation

	make
	
feature 

	dispatch (generic_type: GEN_TYPE_A; a_class: CLASS_C) is
			-- Treat generic type `generic_type': it is either a new
			-- class filter or a new data. If it is a data, the instantiator
			-- keeps it, or it is a filter then it sends the new filter
			-- to the class `a_class'.
		require
			good_type: generic_type /= Void;
			good_class: a_class /= Void and then a_class.changed;
		local
			type_i: GEN_TYPE_I;
			i, nb: INTEGER;
			another_generic: GEN_TYPE_A;
			generics: ARRAY [TYPE_A];
			insertion_list: LINKED_LIST [GEN_TYPE_I];
		do
				-- Evaluation of a type class
			type_i := generic_type.type_i;
				-- In case of expanded
			type_i.set_is_expanded (False);
				-- Check if it is a data or a filter
			if type_i.has_formal then
					-- It is a filter: the insertion list is the filter
					-- list of `a_class'
				insertion_list := a_class.filters;
				check
					class_has_generics: a_class.generics /= Void
				end;
			else
					-- it is a data: the insertion list is the Current one
				insertion_list := Current;
			end;

				-- Look for the item in the insertion list
			insertion_list.start;
			insertion_list.search_equal (type_i);
			if insertion_list.offright then
					-- New data or item
				insertion_list.start;
				insertion_list.add_left (type_i);
			end;

				-- Recursion on the generic types
			from
				i := 1;
				generics := generic_type.generics;
				nb := generics.count;
			until
				i > nb
			loop
				another_generic ?= generics.item (i).actual_type;
				if another_generic /= Void then
					dispatch (another_generic, a_class);
				end;
				i := i + 1;
			end;
		end;

	process is
			-- Process the list in order to find new class types
		local
			data: GEN_TYPE_I;
			local_cursor: LINKABLE [GEN_TYPE_I];
		do
			from
				local_cursor := first_element
			until
				local_cursor = Void
			loop
				data := local_cursor.item;
				data.base_class.update_types (data);
				local_cursor := local_cursor.right;
			end;
				-- Check array class
			check_array_class;
		end;

feature {NONE}

	check_array_class is
			-- Force an array type in the system
		local
			array_cl: CLASS_C;
		do
			array_cl := System.array_class.compiled_class;
			if array_cl.types.empty then
					-- Insert a default array class type
				array_cl.update_types (Array_type);
			end
		end;

feature {STRIP_B, SYSTEM_I}

	Array_type: GEN_TYPE_I is
			-- Default array type
		local
			ref: REFERENCE_I;
			meta_gen: META_GENERIC;
		once
			!!ref;
			!!meta_gen.make (1);
			meta_gen.put (ref, 1);
			!!Result;
			Result.set_meta_generic (meta_gen);
			Result.set_base_id (System.array_id);
		end;

end

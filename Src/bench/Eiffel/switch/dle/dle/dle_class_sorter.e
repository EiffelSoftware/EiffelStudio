-- Topological sort on dynamic classes

class DLE_CLASS_SORTER

inherit

	CLASS_SORTER
		redefine
			fill_original, fill
		end;
	COMPILER_EXPORTER

creation

	make

feature

	fill_original is
			-- Fill `original' and the lists of descendants `successors'.
			-- Keep the static classes in the same order (they already
			-- have been sorted).
		local
			cl_id: INTEGER;
			a_class: CLASS_C;
			classes: CLASS_C_SERVER
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
		do
			classes := System.classes;
			check
				consistency: count = classes.count
			end;
			count := System.dle_max_topo_id
			from 
				classes.start 
			until 
				classes.after 
			loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
				from 
					i := 1 
				until 
					i > nb 
				loop
					a_class := class_array.item (i)
					if a_class /= Void then
						cl_id := a_class.topological_id;

debug ("DLE TOPO")
	io.error.put_string ("Class ");
	io.error.put_string (a_class.name);
	io.error.put_string (" (topo id #");
	io.error.put_integer (cl_id);
	io.error.put_string (" inserted in `original' at position #")
end;

							-- Keep the static classes in the same order.
						if a_class.is_dynamic then
							count := count + 1;
							cl_id := count;
							a_class.set_topological_id (cl_id)
						end;
						original.put (a_class, cl_id);
						successors.put (a_class.descendants, cl_id)

debug ("DLE TOPO")
	io.error.put_integer (cl_id);
	io.error.new_line
end
					end
					i := i + 1
				end;
				classes.forth
			end;
		end

	fill is
			-- Fill `precursor_count' and `outsides'.
		local
			i, k, succ_id: INTEGER;
			succ: LINKED_LIST [CLASS_C];
			cl: CLASS_C
		do
			from
				i := 1
			until
				i > count
			loop
				from
					succ := successors.item (i);
					check
						successor_exists: succ /= Void;
							-- Data structure `successors' for id `i'
							-- must exist.
					end;
					succ.start
				until
					succ.off
				loop
					cl := succ.item;
					if cl.is_dynamic then
							-- Static classes are already sorted, so they
							-- are considered having no precursors.
						succ_id := cl.topological_id;
						k := precursor_count.item (succ_id);
						precursor_count.put (k + 1, succ_id)
					end;
					succ.forth
				end;
				i := i + 1
			end;
			from
					-- Initialization of `outsides'
				i := 1
			until
				i > count
			loop
				if precursor_count.item (i) = 0 then
					outsides.extend (original.item (i))
				end;
				i := i + 1
			end
		end;

invariant

	dynamic_system: System.is_dynamic

end -- class DLE_CLASS_SORTER

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
			i, nb, class_id: INTEGER;
			cl_id: INTEGER;
			cl: CLASS_C;
			e_class: E_CLASS;
			class_array: ARRAY [CLASS_C]
		do
			check
				consistency: count = System.id_array.count
			end;
			from
				i := 1;
				class_array := System.id_array;
				nb := class_array.count;
				count := System.dle_max_topo_id
			until
				i > nb
			loop
				cl := class_array.item (i);

					-- Since a class can be removed, test here if `cl' is
					-- not Void.
				if cl /= Void then
					e_class := cl.e_class;
					cl_id := cl.topological_id;

debug ("DLE TOPO")
	io.error.put_string ("Class ");
	io.error.put_string (cl.class_name);
	io.error.put_string (" (topo id #");
	io.error.put_integer (cl_id);
	io.error.put_string (" inserted in `original' at position #")
end;

						-- Keep the static classes in the same order.
					if cl.is_dynamic then
						count := count + 1;
						cl_id := count;
						cl.set_topological_id (cl_id)
					end;
					original.put (e_class, cl_id);
					successors.put (e_class.descendants, cl_id)

debug ("DLE TOPO")
	io.error.put_integer (cl_id);
	io.error.new_line
end

				end;

				i := i + 1
			end
		end;

	fill is
			-- Fill `precursor_count' and `outsides'.
		local
			i, k, succ_id: INTEGER;
			succ: LINKED_LIST [E_CLASS];
			cl: E_CLASS
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
					if cl.compiled_info.is_dynamic then
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

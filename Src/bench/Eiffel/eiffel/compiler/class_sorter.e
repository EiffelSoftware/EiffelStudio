-- Topological sort on classes

class CLASS_SORTER

inherit

	TOPO_SORTER [CLASS_C]
		redefine
			sort
		end;
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;

creation

	make

feature

	make is
			-- Creation
		do
			!!order.make (1,1);
			!!precursor_count.make (1,1);
			!!successors.make (1,1);
			!!original.make (1,1);
			!!outsides.make;
		end;

	fill_original is
			-- Fill `original' with the lists `descendants' of classes
		local
			i, nb, class_id: INTEGER;
			cl: CLASS_C;
			class_array: ARRAY [CLASS_C];
		do
			check
				consistency: count = System.id_array.count
			end;
			from
				i := 1;
				nb := System.id_array.count;
				class_array := System.id_array;
				count := 0;
			until
				i > nb
			loop
				cl := class_array.item (i);
			
					-- Since a class can be removed, test here if `cl' is
					-- not Void.
				if cl /= Void then
					count := count + 1;
					cl.set_topological_id (count);
					original.put (cl, count);
					successors.put (cl.descendants, count);
				end;

				i := i + 1;
			end
		end;

	sort is
			-- Topological sort of classes
		do
				-- Initialize data structures
			init (System.id_array.count);
				-- Initialize arrays `successors' and `precursor_count'.
			fill;
				-- Perform sort
			perform_sort;
				-- Check validity: there must be no cycle in the 
				-- inheritance graph
			check_validity;
		end;

	check_validity is
			-- Check if there is cycle(s) in the inheritance graph
		local
			i: INTEGER;
			no_cycle: BOOLEAN;
			name_list: LINKED_LIST [INTEGER];
			a_class: CLASS_C;
			vhpr1: VHPR1;
		do
			from
				no_cycle := True;
				i := 1
			until
				i > count
			loop
				if precursor_count.item (i) /= 0 then
						-- I_th item of the graph is involved in a cycle
						-- in the inheritance graph
					no_cycle := False;
					a_class := original.item (i);
					if name_list = Void then
						!!name_list.make;
					end;
					name_list.add_front (a_class.id);
				end;
				i := i + 1;
			end;
			if no_cycle then
					-- Update class ids
				finalize;
			else
					-- Cycle(s) in inheritance graph
				!!vhpr1;
				vhpr1.set_involved_classes (name_list);
				Error_handler.insert_error (vhpr1);
			end;
		end;

	finalize is
			-- Finalization of the topological sort: i.e change the
			-- class ids
		local
			i: INTEGER;
			cl: CLASS_C;
		do
			from
				i := 1
			until
				i > count
			loop
				cl := order.item (i);
debug ("ACTIVITY")
io.error.putint (i);
io.error.putstring (": ");
io.error.putstring (cl.class_name);
io.error.new_line;
end;
				cl.set_topological_id (i);
				i := i + 1
			end;
				-- Update system data.
			System.set_max_class_id (count);
		end;

end

-- History table controler

class HISTORY_CONTROL

inherit
	PROJECT_CONTEXT

	COMPILER_EXPORTER

	SHARED_SERVER

	SHARED_WORKBENCH

creation
	make

feature -- Initialization

	make is
		do
			!! new_units.make (500)
		end

feature

	new_units: EXTEND_TABLE [POLY_TABLE [ENTRY], INTEGER];
			-- New units 

	count: INTEGER;
			-- Count of new and obsolete units already recorded

	max_rout_id: INTEGER
			-- What it the highest assigned routine id?
			--| Needed in EIFFEL_HISTORY to create the tables.

	add_new (entry: ENTRY; rout_id: INTEGER) is
			-- Add a new unit for routine id `rout_id' to the controler
		require
			good_argument: entry /= Void
		local
			poly_table: POLY_TABLE [ENTRY];
		do
			poly_table := new_units.item (rout_id);
			if poly_table = Void then
				poly_table := entry.new_poly_table (rout_id);
				new_units.put (poly_table, rout_id);
				create_poly_table_with_entry (poly_table, entry);
			else
				extend_poly_table_with_entry (poly_table, entry);
			end
			count := count + 1
		end;

	create_poly_table_with_entry (poly_table: POLY_TABLE [ENTRY]; entry: ENTRY) is
			-- Add `entry' in newly created `poly_table' with the generic derivations.
		require
			poly_table_empty: poly_table.is_empty
		local
			associated_class: CLASS_C
			types: TYPE_LIST
			modified_entry: ENTRY
		do
			associated_class := System.class_of_id (entry.class_id)
			if associated_class /= Void then
					-- Classes could have been removed
				from
					types := associated_class.types
					types.start
					poly_table.create_block (types.count)
				until
					types.after
				loop
					modified_entry := clone (entry)
					modified_entry.update (types.item)
					poly_table.extend (modified_entry);
					types.forth
				end
			end
		end

	extend_poly_table_with_entry (poly_table: POLY_TABLE [ENTRY]; entry: ENTRY) is
			-- Extend `poly_table' with `entry'
		require
			not_poly_table_empty: not poly_table.is_empty
		local
			associated_class: CLASS_C
			types: TYPE_LIST
			modified_entry: ENTRY
		do
			associated_class := System.class_of_id (entry.class_id)
			if associated_class /= Void then
					-- Classes could have been removed
				from
					types := associated_class.types
					types.start
					poly_table.extend_block (types.count)
				until
					types.after
				loop
					modified_entry := clone (entry)
					modified_entry.update (types.item)
					poly_table.extend (modified_entry);
					types.forth
				end
			end
		end

	transfer is
			-- Transfer new recorded (and remove obsolete) units in the
			-- temporary server of polymorphic unit tables.
		local
			new_set, server_set: POLY_TABLE [ENTRY];
			id: INTEGER;
			mem: MEMORY
		do
debug ("TRANSFER")
			io.error.putstring("in transfer...%N")
end
			create mem

			from
				new_units.start
			until
				new_units.after
			loop
				new_set := new_units.item_for_iteration;
					-- We need to sort the data so we can work with them later
					-- either at degree 4 or degree 5.
				new_set.sort

				id := new_set.rout_id;
				if Tmp_poly_server.has (id) then
					server_set := Tmp_poly_server.item (id);
						-- Merge `new_set' with `server_set' and keep the order.
					server_set.merge (new_set);
				else
					server_set := new_set;
				end;
				Tmp_poly_server.put (server_set);
				new_units.forth;

					-- Get the maximum encountered routine id
				max_rout_id := max_rout_id.max (id)
			end;
debug ("TRANSFER")
			print ("%NIs transferring")
			print ("%NPoly_tables count: ")
			print (tmp_poly_server.count)
			print ("%Nnewunits size : ")
			print (new_units.count)
			print ("%N... out transfer")
end
			new_units.clear_all;
			count := 0;
			mem.full_collect
			mem.full_coalesce
		ensure
			count = 0;
			new_units.is_empty;
		end;

	check_overload is
			-- Transfer data on disk if overload
		do
			if count > Overload then
				transfer;
			end;
		end;

	Overload: INTEGER is 120000;

end

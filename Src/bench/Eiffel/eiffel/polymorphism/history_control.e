-- History table controler

class HISTORY_CONTROL

inherit

	SHARED_SERVER;
	SHARED_FILES;
	SHARED_WORKBENCH;

creation

	make

feature

	new_units: EXTEND_TABLE [POLY_UNIT_TABLE [POLY_UNIT], INTEGER];
			-- New units 

	obsolete_units: EXTEND_TABLE [POLY_UNIT_TABLE [POLY_UNIT], INTEGER];
			-- Obsolete units

	count: INTEGER;
			-- Count of new and obsolete units already recorded

	melted_rout_ids: LINKED_SET [INTEGER];
			-- Set of routine ids to melt

	changed_rout_ids: LINKED_SET [INTEGER];
			-- Set of the routine ids to change

	make is
		do
			!!new_units.make (500);
			!!obsolete_units.make (500);
			!!changed_rout_ids.make;
			!!melted_rout_ids.make;
		end;

	add_new (u: POLY_UNIT; rout_id: INTEGER; pattern_id: INTEGER) is
			-- Add a new unit for routine id `rout_id' to the controler
		require
			good_argument: u /= Void
		local
			old_count: INTEGER;
			poly_table: POLY_UNIT_TABLE [POLY_UNIT];
		do
			poly_table := new_units.item (rout_id);
			if poly_table = Void then
				poly_table := u.new_poly_table (pattern_id);
				poly_table.set_rout_id (rout_id);
				new_units.put (poly_table, rout_id);
			end;
			old_count := poly_table.count;
			poly_table.add (u);
			if poly_table.count > old_count then
				count := count + 1
			end;
		end;

	add_obsolete (u: POLY_UNIT; rout_id: INTEGER; pattern_id: INTEGER) is
			-- Record a new unit for routine id `rout_id' to the controler
		require
			good_argument: u /= Void
		local
			old_count: INTEGER;
			poly_table: POLY_UNIT_TABLE [POLY_UNIT]
		do
			poly_table := obsolete_units.item (rout_id);
			if poly_table = Void then
				poly_table := u.new_poly_table (pattern_id);	
				poly_table.set_rout_id (rout_id);
				obsolete_units.put (poly_table, rout_id);
			end;
			old_count := poly_table.count;
			poly_table.add (u);
			if poly_table.count > old_count then
				count := count + 1
			end;
		end;

	transfer is
			-- Transfer new recorded (and remove obsolete) units in the
			-- temporary server of polymorphic unit tables.
		local
			new_set, obsol_set, server_set: POLY_UNIT_TABLE [POLY_UNIT];
			rout_id: INTEGER;
		do
				-- First remove obsolete units from server
			from
				obsolete_units.start
			until
				obsolete_units.offright
			loop
				obsol_set := obsolete_units.item_for_iteration;
				rout_id := obsol_set.rout_id;
				server_set := Poly_server.item (rout_id);
				server_set.substract (obsol_set);
				if server_set.empty then
					Tmp_poly_server.desactive (rout_id);			
					changed_rout_ids.remove_item (rout_id);
				else
					changed_rout_ids.add (rout_id);
					Tmp_poly_server.put (server_set);
				end;
				obsolete_units.forth;
			end;
			obsolete_units.clear_all;

				-- Second add new units to the server tables
			from
				new_units.start
			until
				new_units.offright
			loop
				new_set := new_units.item_for_iteration;
				rout_id := new_set.rout_id;
				if Poly_server.has (rout_id) then
					server_set := Poly_server.item (rout_id);
					server_set.merge (new_set);
				else
					server_set := new_set;
				end;
				Tmp_poly_server.put (server_set);
				changed_rout_ids.add (rout_id);
				new_units.forth;
			end;
			new_units.clear_all;

			count := 0;
		ensure
			count = 0;
			new_units.empty;
			obsolete_units.empty;
		end;

	check_overload is
			-- Transfer data on disk if overload
		do
			if count > Overload then
				transfer;
			end;
		end;

	Overload: INTEGER is 10000;

	melt is
			-- Melt changed routine tables
		local
			changed_ids: LINKED_LIST [INTEGER];
		do
			changed_ids := changed_rout_ids;
			from
				changed_ids.start
			until
				changed_ids.offright
			loop
				Poly_server.item (changed_ids.item).poly_table.melt;
				changed_ids.forth;
			end;

			melted_rout_ids.merge (changed_rout_ids);
			changed_rout_ids.wipe_out;
		end;

	change_rout_id (rout_id: INTEGER) is
			-- Put `rout_id' in `changed_rout_ids'.
		do
			changed_rout_ids.put (rout_id);
		end;

	make_update (file: UNIX_FILE) is
			-- Update byte code file with melted routine table.
		local
			melted_ids: LINKED_LIST [INTEGER];
		do
				-- Max rout id
			write_int (file.file_pointer, System.routine_id_counter.value);
				-- Number of routine table to update
			write_int (file.file_pointer, melted_rout_ids.count);
			from
				melted_ids := melted_rout_ids;
				melted_ids.start;
			until
				melted_ids.offright
			loop
				M_rout_tbl_server.item (melted_ids.item).store (file);
				melted_ids.forth;
			end;
		end;
			
	freeze is
			-- Freze history controler
		do
			melted_rout_ids.wipe_out;
			changed_rout_ids.wipe_out;
		end;

feature {NONE} -- External

	write_int (f: POINTER; v: INTEGER) is
		external
			"C"
		end;

end

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

	count: INTEGER;
			-- Count of new and obsolete units already recorded

	make is
		do
			!!new_units.make (500);
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

	transfer is
			-- Transfer new recorded (and remove obsolete) units in the
			-- temporary server of polymorphic unit tables.
		local
			new_set, server_set: POLY_UNIT_TABLE [POLY_UNIT];
			rout_id: INTEGER;
		do
			from
				new_units.start
			until
				new_units.offright
			loop
				new_set := new_units.item_for_iteration;
				rout_id := new_set.rout_id;
				if Tmp_poly_server.has (rout_id) then
					server_set := Tmp_poly_server.item (rout_id);
					server_set.merge (new_set);
				else
					server_set := new_set;
				end;
				Tmp_poly_server.put (server_set);
				new_units.forth;
			end;
			new_units.clear_all;
			count := 0;
		ensure
			count = 0;
			new_units.empty;
		end;

	check_overload is
			-- Transfer data on disk if overload
		do
			if count > Overload then
				transfer;
			end;
		end;

	Overload: INTEGER is 10000;

feature {NONE} -- External

	write_int (f: POINTER; v: INTEGER) is
		external
			"C"
		end;

end

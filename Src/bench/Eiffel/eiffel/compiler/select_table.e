-- Right part of the hash table

class SELECT_TABLE

inherit

	EXTEND_TABLE [FEATURE_I, INTEGER];
	SHARED_HISTORY_CONTROL
		undefine
			twin
		end

creation

	make

feature

	check_obsolete_units (new_table: SELECT_TABLE; id: INTEGER) is
			-- Insert obsolete units of Current in the
			-- history table controler.
		require
			good_argument: new_table /= Void;
		local
			rout_id: INTEGER;
			feature_i: FEATURE_I;
			obsolete_unit: POLY_UNIT;
		do
			from
				start
			until
				offright
			loop
				feature_i := item_for_iteration;
				rout_id := key_for_iteration;
				if feature_i.has_poly_unit and then not new_table.has (rout_id)
				then
					obsolete_unit := feature_i.new_poly_unit (rout_id);
					obsolete_unit.set_id (id);
					History_control.add_obsolete
						(obsolete_unit, rout_id, feature_i.pattern_id);
				end;
				forth
			end
		end;

	check_changed_units (old_table: SELECT_TABLE; id: INTEGER) is
			-- Insert changed units of Current in the history
			-- controler
		require
			good_argument: old_table /= Void;
		local
			new_unit: POLY_UNIT;
			feature_i, old_feature: FEATURE_I;
			rout_id: INTEGER;
		do
			from
				start
			until
				offright
			loop
				feature_i := item_for_iteration;
				if feature_i.has_poly_unit then
					rout_id := key_for_iteration;
					old_feature := old_table.item (rout_id);
					if 	old_feature = Void
						or else
						not feature_i.poly_equiv (old_feature)
					then
						new_unit := feature_i.new_poly_unit (rout_id);
						new_unit.set_id (id);
						History_control.add_new
									(new_unit, rout_id, feature_i.pattern_id);
					end;
				end;
				forth;
			end;
		end;

	change_all_units (id: INTEGER) is
			-- Change all polymorphic units of the current table
		local
			feature_i: FEATURE_I;
			rout_id: INTEGER;
			new_unit: POLY_UNIT;
		do
			from
				start
			until
				offright
			loop
				feature_i := item_for_iteration;
				if feature_i.has_poly_unit then
					rout_id := key_for_iteration;
					History_control.change_rout_id (rout_id);
				end;
				forth;
			end;
		end;

end

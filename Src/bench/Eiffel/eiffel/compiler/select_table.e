-- Selection table.
-- Associates routine ids with execution units.
-- At generation time the select table leads to one
-- descriptor per associated class type.

class SELECT_TABLE

inherit
	HASH_TABLE [FEATURE_I, INTEGER]

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end
		
	SHARED_HISTORY_CONTROL
		undefine
			copy, is_equal
		end

creation

	make

feature -- Final mode

	add_units (id: INTEGER) is
			-- Insert units of Current in the history
			-- controler (routine table construction)
		local
			new_unit: ENTRY;
			feature_i: FEATURE_I;
			rout_id: INTEGER;
		do
			from
				start
			until
				after
			loop
				feature_i := item_for_iteration;
				if feature_i.has_entry then
					rout_id := key_for_iteration;
					new_unit := feature_i.new_entry (rout_id);
					new_unit.set_class_id (id);
					History_control.add_new (new_unit, rout_id);
				end;
				forth;
			end;
		end;

feature -- Incrementality

	equiv (other: like Current): BOOLEAN is
			-- Incrementality test on the select table in second pass.
		require
			good_argument: other /= Void
		local
			f2: FEATURE_I;
		do
			if other.count = count then
					-- At least the counts should be the same.
				from
					start;
					Result := True
				until
					after or else not Result
				loop
					f2 := other.item (key_for_iteration);
					if f2 = Void then
						Result := False
					else
						check
							item_for_iteration.feature_name.is_equal (f2.feature_name);
						end;
						Result := item_for_iteration.select_table_equiv (f2);					
					end;
					forth
				end;
			end;
		end;

feature -- Generation

	descriptors (c: CLASS_C): DESC_LIST is
			-- Descriptors of class types associated
			-- with class `c'
		do
			!! Result.make (c, count)
			if c.has_invariant then
				Result.put_invariant (c.invariant_feature)
			end

			from
				start
			until
				after
			loop
				Result.put (key_for_iteration, item_for_iteration);
				forth
			end;
		end;

	generate (c: CLASS_C) is
			-- Generate descriptor C tables of class 
			-- types associated with class `c'.
		local
			desc_list: DESC_LIST
			desc: DESCRIPTOR
		do
			from
				desc_list := descriptors (c);
				desc_list.start
			until
				desc_list.after
			loop
				desc := desc_list.item;
				if desc.class_type.is_modifiable then
					desc.generate
				end;
				desc_list.forth
			end;
		end;

feature -- Melting

	melt (c: CLASS_C) is
			-- Melt descriptors of class types
			-- associated with class `c'.
			--| (The result is put in the melted 
			--| descriptor server).
		do
			descriptors (c).melt
		end

end -- class SELECT_TABLE

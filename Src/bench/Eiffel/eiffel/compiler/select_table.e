-- Selection table.
-- Associates routine ids with execution units.
-- At generation time the select table leads to one
-- descriptor per associated class type.

class SELECT_TABLE

inherit

	EXTEND_TABLE [FEATURE_I, ROUTINE_ID];
	SHARED_HISTORY_CONTROL
		undefine
			copy, is_equal
		end;
	SHARED_GENERATOR
		undefine
			copy, is_equal
		end

creation

	make

feature -- Final mode

	add_units (id: CLASS_ID) is
			-- Insert units of Current in the history
			-- controler (routine table construction)
		local
			new_unit: POLY_UNIT;
			feature_i: FEATURE_I;
			rout_id: ROUTINE_ID;
		do
			from
				start
			until
				after
			loop
				feature_i := item_for_iteration;
				if feature_i.has_poly_unit then
					rout_id := key_for_iteration;
					new_unit := feature_i.new_poly_unit (rout_id);
					new_unit.set_id (id);
					History_control.add_new
								(new_unit, rout_id, feature_i.pattern_id);
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
			id: ROUTINE_ID;
			f1, f2: FEATURE_I;
		do
			if other.count = count then
					-- At least the counts should be the same.
				from
					start;
					Result := True
				until
					after or else not Result
				loop
					id := key_for_iteration;
					f2 := other.item (id);
					if f2 = Void then
						Result := False
					else
						f1 := item_for_iteration;
						check
							f1.feature_name.is_equal (f2.feature_name);
						end;
						Result := f1.select_table_equiv (f2);					
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
			!! Result.make (c, count);
			if c.has_invariant then
				Result.put_invariant (c.invariant_feature);
			end;
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
			desc_list := descriptors (c);
			from
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

	generate_precomp (c: CLASS_C) is
			-- Generate precompiled descriptor C tables of class 
			-- types associated with class `c'.
		local
			desc_list: DESC_LIST;
			desc_gen: DESC_GENERATOR
		do
			desc_gen := Desc_generator;
			desc_list := descriptors (c);
			from
				desc_list.start
			until
				desc_list.after
			loop
				desc_gen.generate (desc_list.item);
				desc_list.forth
			end;
		end;

feature -- Melting

	melt (c: CLASS_C) is
			-- Melt descriptors of class types
			-- associated with class `c'.
			--| (The result is put in the melted 
			--| descriptor server).
		local
			desc_list: DESC_LIST
		do
			desc_list := descriptors (c);
			desc_list.melt
		end;

end -- class SELECT_TABLE

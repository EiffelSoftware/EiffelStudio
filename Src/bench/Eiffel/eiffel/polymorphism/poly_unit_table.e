-- Table of polymorphic unit

deferred class POLY_UNIT_TABLE [T -> POLY_UNIT]

inherit

	SORTED_TWO_WAY_LIST [T]
		redefine
			add
		end;
	IDABLE
		rename
			id as rout_id,
			set_id as set_rout_id
		end;
	SHARED_WORKBENCH;
	COMPILER_EXPORTER

feature

	rout_id: ROUTINE_ID;
			-- Routine id of the polymorphic unit table

	set_rout_id (i: ROUTINE_ID) is
			-- Assign` i' to `rout_id'.
		do
			rout_id := i
		end;

	remove_unit_of_id (i: CLASS_ID) is
			-- Remove polymorhic unit of id `i'.
		local
			item_id: CLASS_ID;
			stop: BOOLEAN;
		do
			from
				start
			until
				after or else stop
			loop
				item_id := item.id;
				if item_id.is_equal (i) then
					remove;
					stop := True;
				elseif item_id > i then
					stop := True;
				else
					forth
				end;
			end;
		end;

	add (v: T) is
			-- Add polymorphic unit `u' to current table.
		local
			not_empty: BOOLEAN
		do
			not_empty := not empty;
			if not_empty then
				search_after (v)
			end;
			if off or else not item.id.is_equal (v.id) then
				put_left (v);
				if not_empty then
					back
				end
			else
				active.put (v)
			end
		end;

	substract (other: like Current) is
			-- Substract `other' from Current.
		require
			good_argument: other /= Void
		do
			from
				other.start
			until
				other.after
			loop
				remove_unit_of_id (other.item.id);
				other.forth;
			end;
		end;

	poly_table: POLY_TABLE [ENTRY] is
			-- Polymorphic table to generate in final mode
		local
			types: TYPE_LIST;
			unit: T;
			associated_class: CLASS_C;
		do
			Result := new_poly_table;
			from
				start
			until
				after
			loop
				unit := item;
				associated_class := System.class_of_id (unit.id);
				if associated_class /= Void then
						-- Classes could be removed
					from
						types := associated_class.types;
						types.start
					until
						types.after
					loop
						Result.extend (unit.entry (types.item));
						types.forth
					end;
				end;
				forth
			end;
		end;

	new_poly_table: POLY_TABLE [ENTRY] is
			-- New Polymorphic table
		deferred
		end;

feature -- Trace

	trace is
		do
			from
				start
			until
				after
			loop
				item.trace;
				forth
			end
		end;

feature -- DLE

	dle_poly_table: POLY_TABLE [ENTRY] is
			-- Polymorphic table to generate in final mode
			-- for the static system
		require
			dynamic_system: System.is_dynamic
		local
			types: TYPE_LIST;
			unit: T;
			associated_class: CLASS_C;
			cl_type: CLASS_TYPE
		do
			Result := new_poly_table;
			from
				start
			until
				after
			loop
				unit := item;
				associated_class := System.class_of_id (unit.id);
				if associated_class /= Void then
						-- Classes could be removed
					from
						types := associated_class.types;
						types.start
					until
						types.after
					loop
						cl_type := types.item;
						if cl_type.is_static then
								-- Generate only what was in the static system.
							Result.extend (unit.entry (cl_type))
						end;
						types.forth
					end
				end;
				forth
			end
		end

end

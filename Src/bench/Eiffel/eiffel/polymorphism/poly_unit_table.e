-- Table of polymorphic unit

deferred class POLY_UNIT_TABLE [T -> POLY_UNIT]

inherit

	SORTED_TWO_WAY_LIST [T]
		redefine
			add
		end;
	IDABLE
		rename
			id as rout_id
		end;
	SHARED_WORKBENCH;

feature

	rout_id: INTEGER;
			-- Routine id of the polymorphic unit table

	set_rout_id (i: INTEGER) is
			-- Assign` i' to `rout_id'.
		do
			rout_id := i
		end;

	remove_unit_of_id (i: INTEGER) is
			-- Remove polymorhic unit of id `i'.
		local
			item_id: INTEGER;
			stop: BOOLEAN;
		do
			from
				start
			until
				offright or else stop
			loop
				item_id := item.id;
				if item_id = i then
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
			if off or else item.id /= v.id then
				add_left (v);
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
				other.offright
			loop
				remove_unit_of_id (other.item.id);
				other.forth;
			end;
		end;

	poly_table: POLY_TABLE [ENTRY] is
			-- Polymorphic table to generate in final mode
		local
			types: TYPE_LIST;
			type_cursor: LINKABLE [CLASS_TYPE];
			unit: T;
			local_cursor: BI_LINKABLE [T];
			associated_class: CLASS_C;
		do
			Result := new_poly_table;
			from
				local_cursor := first_element
			until
				local_cursor = Void
			loop
				unit := local_cursor.item;
				associated_class := System.class_of_id (unit.id);
				if associated_class /= Void then
						-- Classes could be removed
					from
						types := associated_class.types;
						type_cursor := types.first_element
					until
						type_cursor = Void
					loop
						Result.add (unit.entry (type_cursor.item));
						type_cursor := type_cursor.right
					end;
				end;
				local_cursor := local_cursor.right
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

end

-- Table of polymorphic unit

deferred class POLY_UNIT_TABLE [T -> POLY_UNIT]

inherit

	SORTED_TWO_WAY_LIST [T];
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
					associated_class.types.generate_poly_table (unit, Result)
				end
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

end

indexing
	description: "Routine identifier sets indexed by routine id."
	date: "$Date$"
	revision: "$Revision$"

class
	ROUT_ID_SET
	
inherit

	ID_SET
		export
			{COMPILER_EXPORTER} put, force, extend, merge, wipe_out
		redefine
			extend
		end

	SHARED_COUNTER
		undefine
			is_equal, copy
		end
	
	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end
	
create
	make
	
feature {COMPILER_EXPORTER}

	extend (a_rout_id: like first) is
			-- Insert routine id `a_rout_id' in set if not already
			-- present.
		local
			l_rout_id: INTEGER
			l_pos: INTEGER
			l_area: like area
		do
			if not has (a_rout_id) then
				Precursor (a_rout_id)
					-- Processing for attribute table:
					-- Since the byte code inspect the first value of this	
					-- routine id set, if there are thw ids one for a routine
					-- table and another one for an attribute table, the one
					-- for the attribute table must be in first position
				if
					Routine_id_counter.is_attribute (a_rout_id) and then
					not Routine_id_counter.is_attribute (first)
				then
					if l_area /= Void then
						l_rout_id := first
						first := a_rout_id
						l_area.put (l_rout_id, l_pos)
					end
				end
			end
		end

	has_attribute_origin: BOOLEAN is
			-- Is in routine id set an attribute offset table id?
		require
			not_empty: not is_empty
		do
			Result := Routine_id_counter.is_attribute (first)
		end
			
	update (l: LINKED_LIST [INHERIT_INFO]) is
			-- Update through inherited features in `l'.
		require
			l_not_void: l /= Void
			l_not_empty: not l.is_empty
		do
			from
				l.start
			until
				l.after
			loop
				merge (l.item.a_feature.rout_id_set)
				l.forth
			end
		end

end -- class ROUT_ID_SET

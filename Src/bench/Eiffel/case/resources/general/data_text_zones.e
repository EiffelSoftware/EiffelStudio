indexing

	description: 
		"Sorted collection of DATA_TEXT_ZONEs associated to a textual display.";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATA_TEXT_ZONES

inherit
	TEXT_ZONES
		redefine
			anchor
		end

creation
	make

feature -- Access

	feature_clause_at_position (pos: INTEGER): FEATURE_CLAUSE_DATA is
			-- Feature clause to which position `pos' belongs.
			-- Void if no data of type FEATURE_CLAUSE contains 
			-- position `pos' 
		local
			zone: like anchor
			fc: like feature_clause_at_position
		do
			from
				zones_list.start
			variant
				remaining_elements: zones_list.count - zones_list.index
			until
				zones_list.off
			loop
				zone := zones_list.item
				if zone.start_position > pos then
						--| too far
					zones_list.finish
				elseif zone.end_position >= pos then
			 			--| good positions, check type
					fc ?= zone.data
					if fc /= Void then
						Result := fc
						zones_list.finish
					end
				end
				zones_list.forth
			end
		end

	i_th_feature_clause (i: INTEGER): like feature_clause_at_position is
			-- `i'_th data corresponding to a feature clause
			-- Void if less than `i' feature clauses
		require
			positive_i: i > 0
		local
			index: INTEGER
			zone: like i_th_feature_clause
		do
			from
				index := 0
				zones_list.start
			variant
				remaining_elements: zones_list.count - zones_list.index
			until
				zones_list.off
			loop
				zone ?= zones_list.item
				if zone /= Void then
					index := index + 1
					if index = i then
						zones_list.finish
					end
				end
				zones_list.forth
			end
			if index = i then
				Result := zone
			end
		end

feature {NONE} -- Inapplicable

	anchor: DATA_TEXT_ZONE is
			-- Anchor for the type of the zones
		do
			check
				not_called: False
			end
		end

end -- class DATA_TEXT_ZONES

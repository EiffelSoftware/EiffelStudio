indexing

	description: 
		"Sorted collection of TEXT_ZONE associated to a textual display.";
	date: "$Date$";
	revision: "$Revision$"

class 
	TEXT_ZONES

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty collection
		do
			!! zones_list.make
		ensure
			empty: empty
		end

feature -- Element change

	add (zone: like zone_at_position) is
			-- Add `zone' to its place in the collection
		do
			zones_list.extend (zone)
		ensure
			zone_added: has (zone)
			is_sorted: is_sorted
		end

	extend (zone: like zone_at_position) is
			-- Add `zone' at end of collection
			--| Cursor position not not guaranteed;
			--| collection may not be sorted.
		do
			zones_list.finish
			zones_list.put_right (zone)
		ensure
			zone_added: has (zone)
		end
	
	sort is
			-- Sort 
		do
			zones_list.sort
		ensure
			is_sorted: is_sorted
		end

	wipe_out is
			-- Remove all zones previously added
		do
			zones_list.wipe_out
		ensure
			empty: empty
		end

feature -- Access

	zone_at_position (pos: INTEGER): like anchor is
			-- First zone for which `start_position' <= `pos' <= `end_position' 
			-- Void if none.
		local
			text_zone: like anchor
		do
			from
				zones_list.start
			until
				zones_list.off
			loop
				text_zone := zones_list.item
				if text_zone.start_position <= pos then
					if text_zone.end_position >= pos then
						Result := text_zone
						zones_list.finish
					end
				end
				zones_list.forth
			end
		end


	has (zone: like zone_at_position): BOOLEAN is
			-- Is `zone' in the collection of recorded zones?
		require
			zone_exists: zone /= Void
		do
			Result := zones_list.has (zone)
		end

feature -- Properties

	empty: BOOLEAN is
			-- Is the collection of recorded zones empty?
		do
			Result := zones_list.empty
		end

	is_sorted: BOOLEAN is
			-- Is current collection sorted
		do
			Result := zones_list.sorted
		end

feature {NONE} -- Implementation

	zones_list: SORTED_TWO_WAY_LIST [like zone_at_position]
			-- Actual sorted list for the zones recorded through `add'

feature {NONE} -- Inapplicable

	anchor: TEXT_ZONE is
			-- Anchor for the type of the zones
		do
			check
				not_called: False
			end
		end

invariant
	zones_list_exists: zones_list /= Void

end -- class TEXT_ZONES

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Data-structures on which items a partial order relation is defined

indexing

	names: comparable_struct;
	access: min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE_STRUCT [G -> PART_COMPARABLE] inherit

	SEQUENTIAL [G]

feature -- Access

	min: like item is
			-- Minimum in `Current'
		local
			m: like item
		do
			from
				start;
				m := item;
				forth
			until
				off
			loop
				if item < m then
					m := item
				end;
				forth
			end
		ensure
		--	is_minimum:
		--		for all `elements in `Current': `Result <= element'
		end;
			
	max: like item is
			-- Maximum in `Current'
		local
			m: like item
		do
			from
				start;
				m := item;
				forth
			until
				off
			loop
				if item > m then
					m := item
				end;
				forth
			end
		ensure
		--	is_maximum:
		--		for all `elements in `Current': `element <= Result'
		end;

end -- class COMPARABLE_STRUCT

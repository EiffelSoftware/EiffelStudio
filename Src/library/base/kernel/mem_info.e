--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Memory statistics

indexing

	date: "$Date$";
	revision: "$Revision$"

class MEM_INFO

inherit

	MEM_CONST

creation

	make

feature

	total: INTEGER;
			-- Total number of bytes allocated for `type'
			-- before last call to `update'
	
	used: INTEGER;
			-- Number of bytes used for `type'
			-- before last call to `update'
	
	free: INTEGER is
			-- Number of bytes still free for `type'
			-- before last call to `update'
		do
			Result := total - used - overhead;
		ensure
			Computed: Result = total - used - overhead
		end;

	overhead: INTEGER;
			-- Number of bytes used by memory management scheme for `type'
			-- before last call to `update'
	
	type: INTEGER;
			-- Memory type (Total, Eiffel, C)

	make, update (memory: INTEGER) is
			-- Update Current for `memory' type.
		do
			mem_stat (memory);
			type := memory;
			total := mem_info (1);
			used := mem_info (2);
			overhead := mem_info (3);
		ensure
			Type_updated: type = memory
		end;
	
feature {NONE}

	mem_stat (mem: INTEGER) is
			-- Initialize run-time buffer used by mem_info to retrieve the
			-- statistics frozen at the time of this call.
		external
			"C"
		end;

	mem_info (field: INTEGER): INTEGER is
			-- Read memory accounting structure, field by field.
		external
			"C"
		end

invariant

	Consistent: total = free + used + overhead

end

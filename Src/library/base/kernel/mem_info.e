indexing

	description:
		"Properties of the memory management mechanism. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MEM_INFO inherit

	MEM_CONST

creation

	make

feature -- Initialization

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

feature -- Access

	type: INTEGER;
			-- Memory type (Total, Eiffel, C)

feature -- Measurement

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
			-- Number of bytes used by memory management
			-- scheme for `type' before last call to `update'


feature {NONE} -- Implementation

	mem_stat (mem: INTEGER) is
			-- Initialize run-time buffer used by mem_info to retrieve the
			-- statistics frozen at the time of this call.
		external
			"C | %"eif_memory.h%""
		end;

	mem_info (field: INTEGER): INTEGER is
			-- Read memory accounting structure, field by field.
		external
			"C | %"eif_memory.h%""
		end

invariant

	consistent_memory: total = free + used + overhead

end -- class MEM_INFO


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


-- Information about a routine.
-- A routine represents a feature with all its versions in descendant classes, 
-- obtained through renaming or adaptation. A new routine is introduced either 
-- when there are no precursors or trough duplication (in the case of repeated 
-- inheritance). A routine has an origin, which is the class in which it was 
-- introduced, and an offset which is an unique identification number of the 
-- routine in the origin class.
-- Currently the offset mechanism is only used in workbench mode since it is 
-- more incremental but yields less efficient feature call mechanism.

class ROUT_INFO 

inherit

	COMPILER_EXPORTER

creation

	make

feature -- Creation

	make (org: CLASS_C; offs: INTEGER) is
		do
			origin := org.class_id;
			offset := offs
		end;

feature -- Data

	origin: INTEGER;
		-- Class in which the routine was initially
		-- declared

	offset: INTEGER;
		-- Offset of the routine in the origin class.
		-- This offset is used at run-time to locate
		-- the routine in objects conforming to the 
		-- origin class.

	set_origin (o: like origin) is
			-- Set `origin' to `o'.
		do
			origin := o
		end;

	set_offset (i: INTEGER) is
			-- Set `offset' to `i'
		do
			offset := i
		end;

feature -- Trace

	trace is
		do
			io.putstring (" Origin: ");
			io.putint (origin);
			io.putstring (" Offset: ");
			io.putint (offset);
		end;

end

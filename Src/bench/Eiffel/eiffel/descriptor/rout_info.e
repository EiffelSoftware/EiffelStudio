indexing
	description: "[
		Information about a routine.
		A routine represents a feature with all its versions in descendant classes, 
		obtained through renaming or adaptation. a new routine is introduced either 
		when there are no precursors or trough duplication (in the case of repeated 
		inheritance). a routine has an origin, which is the class in which it was 
		introduced, and an offset which is an unique identification number of the 
		routine in the origin class.
		Currently the offset mechanism is only used in workbench mode since it is 
		more incremental but yields less efficient feature call mechanism.
		]"
	FIXME: "Manu 1/18/2002: should be made expanded when they work."	
	date: "$Date$"
	revision: "$Revision$"

class
	ROUT_INFO 

creation
	make

feature -- Initialization

	make (org: CLASS_C; offs: INTEGER) is
		require
			org_not_void: org /= Void
			valid_offset: offs > 0
		do
			origin := org.class_id
			offset := offs
		ensure
			origin_set: origin = org.class_id
			offset_set: offset = offs
		end

feature -- Access

	origin: INTEGER
			-- Class in which routine was initially declared.

	offset: INTEGER
			-- Offset of routine in origin class.
			-- This offset is used at run-time to locate
			-- routine in objects conforming to origin class.

end -- class ROUT_INFO

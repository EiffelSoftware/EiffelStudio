indexing
	description:
		"Stone representating a breakable point."
	date: "$Date$"
	revision: "$Revision $"

class
	BREAKABLE_STONE 

inherit
	STONE
		redefine
			stone_cursor,
			x_stone_cursor,
			is_storable
		end

	SHARED_APPLICATION_EXECUTION

creation
	make
	
feature {NONE} -- Initialization

	make (e_feature: E_FEATURE; break_index: INTEGER) is
		require
			not_feature_i_void: e_feature /= Void
		do
			routine := e_feature
			index := break_index
		end -- make
 
feature -- Properties

	routine: E_FEATURE
			-- Associated routine

	body_index: INTEGER is
			-- Breakpoint index in `routine'
		do
			Result := routine.body_index
		end

	index: INTEGER
			-- Breakpoint index in `routine'

feature -- Access

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end

	history_name: STRING is
		do
			Result := "Breakpoint in " + routine.name
		end

	is_storable: BOOLEAN is
			-- Breakpoint stones are not kept.
		do
			Result := False
		end

	stone_signature: STRING is
		do
			Result := routine.feature_signature
		end
 
	header: STRING is
		do
			Result := "Stop point in " + routine.name + " at line " + index.out
		end

end -- class BREAKABLE_STONE

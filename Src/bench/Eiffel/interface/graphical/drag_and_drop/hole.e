indexing
	description: "Object that accepts stones."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	HOLE

inherit
	STONE_TYPES

	WINDOWS

feature -- Properties

	button_data: BUTTON_DATA
			-- Context information on where stone was dropped
			-- relative to the main panel

	target: WIDGET is
			-- Target widget for stone to be dropped on
		deferred
		end

	stone_type: INTEGER is
			-- Stone_type that Current hole accepts
		deferred
		end

feature -- Access

	registered: BOOLEAN is
			-- Is the Current hole registered?
		do
			Result := Transporter.registered (Current)
		end

feature -- Element change

	register is
			-- Register current hole
		require
			not_registered: not registered
		do
			Transporter.register (Current)
		ensure
			registered: registered
		end

feature -- Removal

	unregister is
			-- Register current hole
		require
			registered: registered
		do
			Transporter.unregister (Current)
		ensure
			not_registered: not registered
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is 
			-- Is stone dropped compatible with Current hole?
		do 
			Result := dropped.stone_type = stone_type
		end

feature -- Implementation

	receive (dropped: STONE) is
			-- Receive dropped stone
		require
			valid_stone: dropped /= Void
		do
			if stone_type = Any_type then
				process_any (dropped)
			elseif compatible (dropped) then
				dropped.process (Current)
			end
		end

	set_button_data (b_data: like button_data) is
			-- Set `button_data' to `b_data'.
		do
			button_data := b_data
		end

feature -- Update

	process_ace_syntax (syn: ACE_SYNTAX_STONE) is
			-- Process ace syntax stone.
		require
			valid_stone: syn /= Void
		do
		end

	process_object (object_stone: OBJECT_STONE) is
			-- Process object stone.
		require
			valid_stone: object_stone /= Void
		do
		end

	process_class_syntax (syn: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
		require
			valid_stone: syn /= Void
		do
		end

	process_error (error_stone: ERROR_STONE) is
			-- Process error stone.
		require
			valid_stone: error_stone /= Void
		do
		end

	process_system (system_stone: SYSTEM_STONE) is
			-- Process system stone.
		require
			valid_stone: system_stone /= Void
		do
		end

	process_breakable (bk: BREAKABLE_STONE) is
			-- Process breakable stone
		require
			valid_stone: bk /= Void
		do
		end

	process_class (class_stone: CLASSC_STONE) is
			-- Process class stone.
		require
			valid_stone: class_stone /= Void
			is_valid: class_stone.is_valid
		do
		end

	process_classi (classi_stone: CLASSI_STONE) is
			-- Process class stone.
		require
			valid_stone: classi_stone /= Void
			is_valid: classi_stone.is_valid
		do
		end

	process_cluster (cluster_stone: STONE) is
			-- Process cluster stone.
		require
			valid_stone: cluster_stone /= Void
		do
		end

	process_feature (feature_stone: FEATURE_STONE) is
			-- Process feature stone.
		require
			valid_stone: feature_stone /= Void
			is_valid: feature_stone.is_valid
		do
		end

	process_any (dropped: STONE) is
			-- Accept all stone types.
		require
			valid_stone: dropped /= Void
		do
		end

	process_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept call stack stones.
		require
			valid_stone: dropped /= Void
		do
		end

	process_feature_error (dropped: FEATURE_ERROR_STONE) is
			-- Accept feature error stones.
			-- (By default, call `process_feature').
		require
			valid_stone: dropped /= Void
		do
			process_feature (dropped)
		end

end -- class HOLE

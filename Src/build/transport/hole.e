
deferred class HOLE 

inherit

	CONSTANTS;
	WINDOWS
	
feature 

	receive (dropped: STONE) is
			-- Receive dropped stone.
		require
			valid_argument: dropped /= Void
		do
			if stone_type = Stone_types.any_type then
				process_any (dropped);
			elseif compatible (dropped) then
				dropped.process (Current)
			end
		end;

	compatible (s: STONE): BOOLEAN is
		do
			Result := s.stone_type = stone_type;
		end;
	
	target: WIDGET is
			-- Actual widget the stone has
			-- to be dropped on for Current
			-- hole
		deferred
		end;

	unregister is
			-- Unregister Current as a hole
		do
			transporter.unregister (Current)
		end;

	register is
			-- Register Current as a hole
		do
			transporter.register (Current)
		end;

feature {STONE}

	stone_type: INTEGER is
			-- Stone type that Current hole accepts
		deferred
		end;

	process_new_state is
		do
		end;

	process_attribute (dropped: ATTRIB_STONE) is
			-- Accept all stone types
		require
			valid_stone: dropped /= Void
		do
		end;

	process_any (dropped: STONE) is
			-- Accept all stone types
		require
			valid_stone: dropped /= Void
		do
		end;

	process_behavior (dropped: BEHAVIOR_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_color (dropped: STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_command (dropped: CMD_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_context (dropped: CONTEXT_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_event (dropped: EVENT_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_label (dropped: LABEL_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_instance (dropped: CMD_INST_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_state (dropped: STATE_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_transition (dropped: TRANS_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

	process_type (dropped: TYPE_STONE) is
		require
			valid_stone: dropped /= Void
		do
		end;

end

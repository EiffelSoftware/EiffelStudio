
deferred class CMD_INST_STONE 

inherit

	STONE
		redefine
			data
		end
	
feature  -- Command type features

	stone_type: INTEGER is
		do
			Result := Stone_types.instance_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_instance (Current)
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.command_instance_cursor
		end;

	associated_command: CMD is
			-- Command type associated
			-- with current instance
		deferred
		end;

feature -- Command instance features

	data: CMD_INSTANCE is
		deferred
		end;

end


deferred class HOLE 

inherit

	WINDOWS
		export
			{NONE} all
		end
	
feature 

	stone: STONE;
			-- Stone present in current
			-- hole.

	receive (dropped: STONE) is
			-- Receive dropped stone.
		require
			valid_argument: dropped /= Void
		do
			if compatible (dropped) then
				process_stone;
			end;
		end;

	compatible (s: STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;
	
	target: WIDGET is
			-- Actual widget the stone has
			-- to be dropped on for Current
			-- hole
		deferred
		end;

feature {NONE}

	process_stone is
			-- Process stone in current hole.
		deferred
		end;
	
	register is
		do
			transporter.register (Current)
		end;

end

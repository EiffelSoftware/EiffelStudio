deferred class
	STONE 

inherit
	EB_CONSTANTS

feature -- Properties

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
			-- Default is Void, meaning no cursor is associated with `Current'.
		deferred
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
			-- Default is Void, meaning no cursor is associated with `Current'.
		deferred
		end

feature  -- Access

	help_text: STRING is
			-- Explaination of what current element means,
			-- "No help available" by default
		do
			Result := clone (Interface_names.h_No_help_available)
		end

	stone_signature: STRING is 
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		deferred 
		end

	header: STRING is 
			-- String to describe Current
			-- (as it may be described in the title of a development window).
		deferred 
		end

	history_name: STRING is 
			-- Name used in the history list,
			-- (By default, it is the stone_signature
			-- and a string to describe the type of stone (Class, feature,...)).
		deferred 
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := True
		end

	is_storable: BOOLEAN is
			-- Can `Current' be kept?
			-- True by default.
		do
			Result := True
		end

	synchronized_stone: STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			if is_valid then
				Result := Current
			end
		ensure
			valid_stone: Result /= Void implies Result.is_valid
		end

	same_as (other: STONE): BOOLEAN is
			-- Is `other' same as Current?
			--| By default: Result = equal (Current, other).
		local
			o: like Current
		do
				--| System level validity problems
			o ?= other
			Result := equal (Current, other)
		end

end -- class STONE

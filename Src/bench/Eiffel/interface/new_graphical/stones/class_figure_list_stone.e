indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_FIGURE_LIST_STONE

inherit
	STONE
	
create
	make_with_list
	
feature {NONE} -- Initialization

	make_with_list (a_list: LIST [EIFFEL_CLASS_FIGURE])  is
			-- 
		do
			classes := a_list
		end
		
feature -- Properties

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
			-- Default is Void, meaning no cursor is associated with `Current'.
		do
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
			-- Default is Void, meaning no cursor is associated with `Current'.
		do
		end

feature  -- Access

	classes: LIST [EIFFEL_CLASS_FIGURE]
			-- Classes transported with this stone.

	stone_signature: STRING is 
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		do
			Result := "List of classes"
		end

	header: STRING is 
			-- String to describe Current
			-- (as it may be described in the title of a development window).
		do
			Result := stone_signature
		end

	history_name: STRING is 
			-- Name used in the history list,
			-- (By default, it is the stone_signature
			-- and a string to describe the type of stone (Class, feature,...)).
		do
			Result := stone_signature
		end

--	synchronized_stone: STONE is
--			-- Clone of `Current' after a recompilation
--			-- (May be Void if not valid anymore)
--		do
--			if is_valid then
--				Result := Current
--			end
--		ensure
--			valid_stone: Result /= Void implies Result.is_valid
--		end

end -- class CLASS_FIGURE_LIST_STONE

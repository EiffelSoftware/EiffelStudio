indexing
	description: "Stone for configuration targets."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_STONE

inherit
	STONE
		redefine
			is_valid
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target) is
			-- Create.
		require
			a_target_ok: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Properties

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		once
			Result := cursors.cur_target
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		once
			Result := cursors.cur_x_target
		end

feature -- Access

	target: CONF_TARGET
			-- Target we are representing

	stone_signature: STRING is
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		do
			Result := target.name
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

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		local
			l_target: CONF_TARGET
		do
			l_target := eiffel_universe.conf_system.targets.item (target.name)
			Result := target = l_target
		end

end

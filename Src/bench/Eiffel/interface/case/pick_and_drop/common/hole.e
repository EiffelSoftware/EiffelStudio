indexing
	description: 
		"Abstract class representing a hole in which stones % 
		%may be dropped. No graphical representation. %
		%Associated to a command performing the appropriate actions.";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	HOLE 

inherit
	CONSTANTS
	ONCES
	STONE_TYPES

feature -- Properties

	--button_data: BUTTON_DATA
		-- Context information on where stone was dropped
		-- relative to the main panel

	command: EC_COMMAND is
			-- Command associated to Current hole
		deferred
		end

	stone_type: INTEGER is
			-- Stone type that Current hole accepts
		do
			Result := command.stone_type
		ensure
			valid_result:	Result >= Any_type and then
							Result <= Void_type
		end

	target: EV_WIDGET is
			-- Target widget for stone to be dropped on
			--| Most descendants will implement it as Result := Current
			--| Not done here, because this would imply inheriting from 
			--| WIDGET, which is a hassle.
			--| Body is not Result ?= Current here (which would be ok),
			--| because it's too expensive.
		deferred
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is 
			-- Is stone dropped compatible with Current hole?
		do 
			Result := command.compatible (dropped) 
		end

	registered: BOOLEAN is
			-- Is Current hole registered?
		do
		--	Result := Windows.screen.registered (Current)
		end

feature -- Element change

	register is
			-- Register Current hole
		--require
		--	not_registered: not registered
		do
			if	not registered
			then
			--	Windows.screen.register (Current)
			end
		ensure
			registered: registered
		end

feature -- Removal

	unregister is
			-- Unregister Current hole
		require
			registered: registered
		do
			--Windows.screen.unregister (Current)
		ensure
			not_registered: not registered
		end

feature {TRANSPORTER} -- Implementation

	--set_button_data (btd: like button_data) is
	--	do
		--	button_data := btd
		--ensure
	--	--	button_data_set: button_data =  btd
	--	end

	receive (dropped: STONE) is
			-- Receive dropped stone
		require
			valid_stone: dropped /= Void
		local
		--	composite: COMPOSITE;
		do
		--		-- Requesting and freeing info for rename stone:
		--	dropped.request_for_information
		--	if dropped.is_valid then
		--		if stone_type = Stone_types.any_type then
		--			command.process_any (dropped)
		--		elseif compatible (dropped) then
		--			dropped.process (command)
		--		end
		--	else
		--		display_invalid_stone_message
		--	end
		--	dropped.free_information
		end

feature {NONE} -- Implementation

	display_invalid_stone_message is
		local
		--	comp: COMPOSITE
		do
--			comp ?= target.parent
--			if comp = Void then
--				comp := Windows.main_graph_window -- 1812
--			end
--			Windows.error (comp, Message_keys.stone_invalid_er, Void)
		end

invariant
	command_exists: command /= Void

end -- class HOLE




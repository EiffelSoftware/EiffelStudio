indexing
	description: 
		"Common part for commands associated to a % 
		%hole/button/drag source in an editor window."
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	EDITOR_WINDOW_HOLE_COM

inherit
	--EC_LICENCED_COMMAND
		
	EV_COMMAND

	CONSTANTS

feature {NONE} -- Initialization

	make (ewin: like editor_window; b: like button) is
			-- Create Current command and associate 
			-- it to editor window `ewin'
		require
			ewin_exists: ewin /= Void
		do
			editor_window := ewin
			button := b
		ensure
			editor_window_set: editor_window = ewin
		end

feature -- Properties

	editor_window: EC_EDITOR_WINDOW [ANY]
			-- Associated editor window

	button: EV_TOOL_BAR_BUTTON

feature -- Setting

	set_entity (st: STONE) is
			-- Set entity to the `st' data.
		require
			stone_exists: st /= Void
		do
			editor_window.set_entity (st.data)
		end

feature -- Update

--	update_before_transport (not_used: BUTTON_DATA) is
--			-- Update Current before transportion of stone.
--		local
--			a_stone: STONE -- To speed up things...
--		do
--			--a_stone := stone
--			if a_stone /= Void then
--				set_focus_line_command.set_transporting (True)
--				--editor_window.focus_label.set_text (a_stone.data.focus)
--			end
--		end
--
--	update_after_transport (not_used: BUTTON_DATA) is
--			-- Update after the transportation of stone.
--		do
--			set_focus_line_command.set_transporting (False)
--			--editor_window.focus_label.set_text ("")
--		end
--
--feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Resync associated editor if button is pressed.
			-- Popup namer if specific key combinations are made.
		deferred
		end
--		local
--			namable: NAMABLE
		--	namer_window: NAMER_WINDOW

		--	new_cluster_stone: NEW_CLUSTER_STONE
-- 		do
-- 
-- -- 			if button /= Void then
-- -- 				!! new_cluster_stone
-- -- 				button.set_transported_data (new_cluster_stone)
-- -- 				button.set_data_type (stone_types.cluster_type_pnd)
-- -- 			end
-- 			
-- 
-- 			if args = Void then  
-- 					--| Left-clicked: we must resync the editor...
-- 				if editor_window.entity /= Void then
-- 						--| ... if the editor is targetted:
-- 					editor_window.set_entity (editor_window.entity)
-- 				end
-- 
-- 			else
-- 					--| Shift-right clicked: bring up a namer window...
-- 			--	namer_window ?= args
-- 			--	check
-- 			--		namer_window /= Void
-- 			--	end
-- 				--namable ?= stone;
-- 
-- 				if namable /= Void then 
-- 							--| ... if there is something that is namable:
-- 			--		namer_window.popup_at_current_position (namable)
-- 				end
-- 			end
--		end

feature {NONE} -- Implementation properties

	set_focus_line_command: STONE_SET_FOCUS_LINE_COM;
			-- Command to set focus

invariant
	valid_editor: editor_window /= Void

end -- class EDITOR_WINDOW_HOLE_COM

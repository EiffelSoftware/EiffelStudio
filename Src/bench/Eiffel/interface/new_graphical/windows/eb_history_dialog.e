indexing
	description: "Windows that allows the user to browse through undoable commands"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HISTORY_DIALOG

inherit
	EV_DIALOG
		rename
			wipe_out as wipe_out_dialog
		redefine
			initialize
		end

	UNDO_CONTEXT
		undefine
			default_create, copy
		redefine
			do_named_undoable,
			undo,
			redo,
			wipe_out
		end
	
	EB_CONSTANTS
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is 
			-- Build the dialog box.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			Precursor
			set_title (Interface_names.t_Diagram_history_tool)
			set_minimum_size (200, 230)

			create cancel_button.make_with_text_and_action (Interface_names.b_Close, ~close_action)
			create vb
			create hb
			create action_list
			action_list.select_actions.extend (~on_select)

			hb.extend (create {EV_CELL})
			hb.extend (cancel_button)
			hb.disable_item_expand (cancel_button)
			hb.extend (create {EV_CELL})

			vb.extend (action_list)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)

			set_default_cancel_button (cancel_button)

			close_request_actions.wipe_out
			close_request_actions.extend (~hide)

				-- Initialize history.
			create undo_list.make
			create do_actions
			create undo_actions
			create undo_exhausted_actions
			create redo_exhausted_actions
			user_selected := True
		end

feature -- Access

		--| Needed or not?
--	undo_button: EV_BUTTON
			-- Button to undo currently selected action.

--	redo_button: EV_BUTTON
			-- Button to redo currently selected action.

	cancel_button: EV_BUTTON
			-- Button with label "Close".

feature -- Element change

	set_strings (a_string_array: INDEXABLE [STRING, INTEGER]) is
			-- Wipe out `feature_list' and re-initialize with an item
			-- for each of `a_string_array'.
		do
			action_list.set_strings (a_string_array)
			previously_selected_item := action_list.last
		end

	wipe_out is
			-- Disgard all previous undoable commands.
		do
			undo_list.wipe_out
			action_list.wipe_out
			undo_exhausted_actions.call (Void)
			redo_exhausted_actions.call (Void)
		end

feature -- Basic operations

	do_named_undoable (a_name: STRING; action, undo_procedure: ANY) is
			-- Perform `action' and put an undo/redo pair on the undo list.
			-- Disgard pairs above the current position.
			-- Update `action_list' as well.
		local
			t: TUPLE
			action_proc: PROCEDURE [ANY, TUPLE []]
			action_array: ARRAY [ANY]
			undo_proc: PROCEDURE [ANY, TUPLE []]
			undo_array: ARRAY [ANY]
			do_agent: PROCEDURE [ANY, TUPLE []]
			undo_agent: PROCEDURE [ANY, TUPLE []]
			undo_pair: UNDO_PAIR
			new_graphical_item: EV_LIST_ITEM
		do
			from
			until
				undo_list.is_empty or undo_list.islast
			loop
				action_list.remove_right
				undo_list.remove_right
			end

			action_proc ?= action
			if action_proc /= Void then
				do_agent := action_proc
			else
				t ?= action
				check t /= Void end
				action_array ?= t.item (1)
				check action_array /= Void end
				do_agent := (~procedure_array_call (action_array))
			end
			undo_proc ?= undo_procedure
			if undo_proc /= Void then
				undo_agent := undo_proc
			else
				t ?= undo_procedure
				check t /= Void end
				undo_array ?= t.item (1)
				check undo_array /= Void end
				undo_agent := (~procedure_array_call (undo_array))
			end
			do_agent.call (Void)
			create undo_pair.make (undo_agent, do_agent)
			undo_pair.set_name (a_name)
			if undo_list.is_empty or not undo_list.last.is_inverse (undo_pair) then
				undo_list.extend (undo_pair)
				undo_list.forth
				create new_graphical_item.make_with_text (a_name)
				action_list.extend (new_graphical_item)
			else
				undo_list.remove
				undo_list.back
				action_list.remove
				action_list.back
			end
			do_actions.call (Void)
			redo_exhausted_actions.call (Void)
			action_list.go_i_th (undo_list.index)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
		end

	register_named_undoable (a_name: STRING; action, undo_procedure: ANY) is
			-- DO NOT perform `action' and put an undo/redo pair on the undo list.
			-- Disgard pairs above the current position.
			-- Update `action_list' as well.
			-- Must not be called if `undo' cannot be called just afterwards.
		local
			t: TUPLE
			action_proc: PROCEDURE [ANY, TUPLE []]
			action_array: ARRAY [ANY]
			undo_proc: PROCEDURE [ANY, TUPLE []]
			undo_array: ARRAY [ANY]
			do_agent: PROCEDURE [ANY, TUPLE []]
			undo_agent: PROCEDURE [ANY, TUPLE []]
			undo_pair: UNDO_PAIR
			new_graphical_item: EV_LIST_ITEM
		do
			from
			until
				undo_list.is_empty or undo_list.islast
			loop
				action_list.remove_right
				undo_list.remove_right
			end

			action_proc ?= action
			if action_proc /= Void then
				do_agent := action_proc
			else
				t ?= action
				check t /= Void end
				action_array ?= t.item (1)
				check action_array /= Void end
				do_agent := (~procedure_array_call (action_array))
			end
			undo_proc ?= undo_procedure
			if undo_proc /= Void then
				undo_agent := undo_proc
			else
				t ?= undo_procedure
				check t /= Void end
				undo_array ?= t.item (1)
				check undo_array /= Void end
				undo_agent := (~procedure_array_call (undo_array))
			end
			create undo_pair.make (undo_agent, do_agent)
			undo_pair.set_name (a_name)
			if undo_list.is_empty or not undo_list.last.is_inverse (undo_pair) then
				undo_list.extend (undo_pair)
				undo_list.forth
				create new_graphical_item.make_with_text (a_name)
				action_list.extend (new_graphical_item)
			else
				undo_list.remove
				undo_list.back
				action_list.remove
				action_list.back
			end
			do_actions.call (Void)
			redo_exhausted_actions.call (Void)
			action_list.go_i_th (undo_list.index)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
		end

	undo is
			-- Reverse the most recent reversable action.
		do
			undo_list.item.undo
			if not undo_list.is_empty then
				undo_list.back
			end
			undo_actions.call (Void)
			if undo_list.off then
				undo_exhausted_actions.call (Void)
			end
			action_list.go_i_th (undo_list.index)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
		end			

	redo is
			-- Reperform the most recently reversed action.
		do
			Precursor
			action_list.go_i_th (undo_list.index)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
		end

	remove_last is
			-- Remove last undoable action from history.
			-- Useful when last call to `do_undoable' was not successful.
		require
			history_non_empty: not undo_list.is_empty
		do
			undo_list.back
			undo_list.remove_right
			action_list.back
			action_list.remove_right
			if undo_exhausted then
				undo_exhausted_actions.call (Void)
			end
		end
	
feature {NONE} -- Implementation

	action_list: EV_LIST
			-- Graphical representation of `undo_list'.

	previously_selected_item: EV_LIST_ITEM
			-- Previously selected item of `action-list'.

	user_selected: BOOLEAN
			-- Was last selection made by the user?

feature {NONE} -- Events

	on_select is
			-- An action has been selected.
			-- Undo all younger actions.
		local
			to_undo, to_redo: INTEGER
		do
			if user_selected then
				if previously_selected_item /= Void then
			 		to_undo := action_list.index_of (previously_selected_item, 1) - 
						action_list.index_of (action_list.selected_item, 1)
					to_redo := - to_undo
				else
			 		to_undo := - action_list.index_of (action_list.selected_item, 1)
					to_redo := - to_undo	
				end
				previously_selected_item := action_list.selected_item
		
				from
				until
					to_undo <= 0
				loop
					undo
					to_undo := to_undo - 1
				end
				from
				until
					to_redo <= 0
				loop
					redo
					to_redo := to_redo - 1
				end			
			end
			user_selected := True
		end

	close_action is
			-- Close dialog.
		do
			hide
		end

end -- class EB_HISTORY_DIALOG

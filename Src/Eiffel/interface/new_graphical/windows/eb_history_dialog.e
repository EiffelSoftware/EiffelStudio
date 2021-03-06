note
	description: "Windows that allows the user to browse through undoable commands"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	initialize
			-- Build the dialog box.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
				-- Initialize history.
			create undo_list.make
			create do_actions
			create undo_actions
			create undo_exhausted_actions
			create redo_exhausted_actions

			Precursor
			set_title (Interface_names.t_Diagram_history_tool)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			set_minimum_size (200, 230)

			create cancel_button.make_with_text_and_action (Interface_names.b_Close, agent close_action)
			create vb
			create hb
			create action_list
			action_list.extend (create {EV_LIST_ITEM}.make_with_text (history_discarded_string))
			action_list.select_actions.extend (agent on_select)

			hb.extend (create {EV_CELL})
			hb.extend (cancel_button)
			hb.disable_item_expand (cancel_button)
			hb.extend (create {EV_CELL})

			vb.extend (action_list)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)

			set_default_cancel_button (cancel_button)

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

	set_strings (a_string_array: INDEXABLE [STRING, INTEGER])
			-- Wipe out `feature_list' and re-initialize with an item
			-- for each of `a_string_array'.
		do
			action_list.set_strings (a_string_array)
			previously_selected_item := action_list.last
		end

	wipe_out
			-- Disgard all previous undoable commands.
		do
			undo_list.wipe_out
			if not action_list.is_empty then
				action_list.wipe_out
				action_list.extend (create {EV_LIST_ITEM}.make_with_text (history_discarded_string))
			end
			undo_exhausted_actions.call (Void)
			redo_exhausted_actions.call (Void)
		end

feature -- Status report

	is_redo_undoing: BOOLEAN

feature -- Basic operations

	do_named_undoable (a_name: STRING_GENERAL; action, undo_procedure: ANY)
			-- Perform `action' and put an undo/redo pair on the undo list.
			-- Disgard pairs above the current position.
			-- Update `action_list' as well.
		local
			t: TUPLE
			action_proc: PROCEDURE
			action_array: ARRAY [ANY]
			undo_proc: PROCEDURE
			undo_array: ARRAY [ANY]
			do_agent: PROCEDURE
			undo_agent: PROCEDURE
			undo_pair: UNDO_PAIR
			new_graphical_item: EV_LIST_ITEM
			offset: INTEGER
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
				if action_array = Void and then attached {ARRAYED_LIST [ANY]} t.item (1) as l_arrayed_list then
					action_array := l_arrayed_list.to_array
				end
				check action_array /= Void end
				do_agent := (agent procedure_array_call (action_array))
			end
			undo_proc ?= undo_procedure
			if undo_proc /= Void then
				undo_agent := undo_proc
			else
				t ?= undo_procedure
				check t /= Void end
				undo_array ?= t.item (1)
				if undo_array = Void and then attached {ARRAYED_LIST [ANY]} t.item (1) as l_arrayed_list then
					undo_array := l_arrayed_list.to_array
				end
				check undo_array /= Void end
				undo_agent := (agent procedure_array_call (undo_array))
			end
			do_agent.call (Void)
			redo_exhausted_actions.call (Void)
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
			if action_list.first.text.is_equal (history_discarded_string) then
				offset := 1
			end
			action_list.go_i_th (undo_list.index + offset)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index + offset).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
			do_actions.call (Void)
		end

	register_named_undoable (a_name: STRING_GENERAL; action, undo_procedure: ANY)
			-- DO NOT perform `action' and put an undo/redo pair on the undo list.
			-- Disgard pairs above the current position.
			-- Update `action_list' as well.
			-- Must not be called if `undo' cannot be called just afterwards.
		local
			t: TUPLE
			action_proc: PROCEDURE
			action_array: ARRAY [ANY]
			undo_proc: PROCEDURE
			undo_array: ARRAY [ANY]
			do_agent: PROCEDURE
			undo_agent: PROCEDURE
			undo_pair: UNDO_PAIR
			new_graphical_item: EV_LIST_ITEM
			offset: INTEGER
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
				if action_array = Void and then attached {ARRAYED_LIST [ANY]} t.item (1) as l_arrayed_list then
					action_array := l_arrayed_list.to_array
				end
				check action_array /= Void end
				do_agent := agent procedure_array_call (action_array)
			end
			undo_proc ?= undo_procedure
			if undo_proc /= Void then
				undo_agent := undo_proc
			else
				t ?= undo_procedure
				check t /= Void end
				undo_array ?= t.item (1)
				if undo_array = Void and then attached {ARRAYED_LIST [ANY]} t.item (1) as l_arrayed_list then
					undo_array := l_arrayed_list.to_array
				end
				check undo_array /= Void end
				undo_agent := agent procedure_array_call (undo_array)
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
			if action_list.first.text.is_equal (history_discarded_string) then
				offset := 1
			end
			action_list.go_i_th (undo_list.index + offset)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index + offset).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
			do_actions.call (Void)
		end

	undo
			-- Reverse the most recent reversable action.
		local
			offset: INTEGER
		do
			is_redo_undoing := True
			undo_list.item.undo
			if not undo_list.is_empty then
				undo_list.back
			end
			undo_actions.call (Void)
			if undo_list.off then
				undo_exhausted_actions.call (Void)
			end
			if action_list.first.text.is_equal (history_discarded_string) then
				offset := 1
			end
			action_list.go_i_th (undo_list.index + offset)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index + offset).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
			is_redo_undoing := False
		end

	redo
			-- Reperform the most recently reversed action.
		local
			offset: INTEGER
		do
			is_redo_undoing := True
			Precursor
			if action_list.first.text.is_equal (history_discarded_string) then
				offset := 1
			end
			action_list.go_i_th (undo_list.index + offset)
			if undo_list.index > 0 then
				user_selected := False
				action_list.i_th (undo_list.index + offset).enable_select
				previously_selected_item := action_list.selected_item
			else
				action_list.remove_selection
				previously_selected_item := Void
			end
			is_redo_undoing := False
		end

	remove_last
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

	on_select
			-- An action has been selected.
			-- Undo all younger actions.
		local
			to_undo, to_redo: INTEGER
			offset: INTEGER
		do
			if user_selected then
				if previously_selected_item /= Void then
					to_undo := action_list.index_of (previously_selected_item, 1) -
						action_list.index_of (action_list.selected_item, 1)
					to_redo := - to_undo
				else
					if action_list.first.text.is_equal (history_discarded_string) then
						offset := 1
					end
					to_undo := - (action_list.index_of (action_list.selected_item, 1) - offset)
					to_redo := - to_undo
				end
				previously_selected_item := action_list.selected_item

					-- We process the undo stack, however some undo operations might
					-- discard the full history (case where something else outside
					-- EiffelStudio did modify some code).
				from
				until
					to_undo <= 0 or undo_list.is_empty
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

	close_action
			-- Close dialog.
		do
			hide
		end

	history_discarded_string: STRING_GENERAL
		once
			Result := interface_names.l_history_discarded_string
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_HISTORY_DIALOG

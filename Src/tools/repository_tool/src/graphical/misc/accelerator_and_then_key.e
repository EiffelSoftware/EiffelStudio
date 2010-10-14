note
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCELERATOR_AND_THEN_KEY

inherit
	EV_SHARED_APPLICATION

create
	make

convert
	accelerator: {EV_ACCELERATOR}

feature -- Initialization

	create_interface_objects
		do
			create actions_by_code.make (3)
			on_trigger_agent := agent on_trigger
		end

	make (acc: EV_ACCELERATOR; w: like widget)
		do
			create_interface_objects
			widget := w
			accelerator := acc
			acc.actions.extend (on_trigger_agent)
			set_timeout (Default_timeout)
		end

feature -- Access

	accelerator: EV_ACCELERATOR

	parent: detachable EV_ACCELERATOR_LIST

feature -- Status

	has_parent: BOOLEAN
			-- Is attached to an accelerators list?
		do
			Result := parent /= Void
		end

	merged: BOOLEAN
			-- Was Current merged during `attach_to' ?

	key_registered (k: EV_KEY): BOOLEAN
			-- Has any actions registered with `k' ?
		do
			Result := actions_by_code.has (k.code)
		end

	popup_enabled: BOOLEAN
			-- Visual notification to indicate "and key" is waited?

feature -- Change

	enable_popup
		do
			popup_enabled := True
		end

	disable_popup
		do
			popup_enabled := False
		end

	unattach
			-- Unattach `Current' from `parent' accelerators list
		require
			has_parent: has_parent
		do
			if attached parent as p then
				if merged then
					if attached associated_accelerator_from (p) as found then
						if found = accelerator then
							p.prune_all (found)
						else
							if attached accelerator_actions_before_merging as acts and then acts.count > 0 then
								found.actions.prune_all (on_trigger_agent)
								found.actions.fill (acts)
							end
							accelerator_actions_before_merging := Void
						end
					else
						check should_not_occur_since_merged: False end
					end
				else
					p.prune_all (accelerator)
				end
			end
		end

	attach_to (a_accelerators: EV_ACCELERATOR_LIST; a_merge_if_exist: BOOLEAN)
			-- Attach `Current' to list `a_accelerators'
			-- if an accelerator with similar key combination already exists
			--    if `a_merge_if_exist' is True, merge `Current' action with found item
			--        set True to `merged', and set the `parent'
			--    otherwise
			--        parent is not set  (i.e: Void), and has_parent is False
			-- else add the associated accelerator
		require
			not_has_parent: not has_parent
		local
			acc: like accelerator
		do
			acc := accelerator
			if attached associated_accelerator_from (a_accelerators) as found then
				--| `a_accelerators' contain an accelerator `found' with an identical key
				--| combination to `acc'
				if found = acc then
					parent := a_accelerators
				elseif a_merge_if_exist then
					merged := True
					acc.actions.prune_all (on_trigger_agent)
					accelerator_actions_before_merging := found.actions.twin
					found.actions.wipe_out
					found.actions.extend (on_trigger_agent)
					parent := a_accelerators
				else
					parent := Void
				end
			else
				a_accelerators.extend (acc)
				parent := a_accelerators
			end
			parent := a_accelerators
		end

	associated_accelerator_from (a_accelerators: EV_ACCELERATOR_LIST): detachable EV_ACCELERATOR
				--| Accelerator contained in `a_accelerators' and with an identical key
				--| combination to `acc', if it exists.
		local
			old_cursor: CURSOR
			acc: like accelerator
		do
			acc := accelerator
			old_cursor := a_accelerators.cursor
			from
				a_accelerators.start
			until
				Result /= Void or else a_accelerators.after
			loop
				Result := a_accelerators.item
				if not Result.is_equal (acc) then
					Result := Void
				end
				a_accelerators.forth
			end
			a_accelerators.go_to (old_cursor)
		end

	set_timeout (a_timeout: INTEGER)
			-- Set `timeout' to `a_timeout'
		require
			timeout_positive: a_timeout > 0
		do
			timeout := a_timeout
			if attached timer as t then
				t.set_interval (timeout)
			end
		end

	unregister_actions (k: EV_KEY)
			-- Unregister actions associated with "and_key" `k'	
		require
			k_not_void: k /= Void
		do
			actions_by_code.remove (k.code)
		end

	register_action	(k: EV_KEY; a_action: PROCEDURE [ANY, TUPLE]; a_details: like details)
			-- Register `a_action' for "and_key" `k'
		require
			k_not_void: k /= Void
			not_has_parent: not has_parent
		local
			l_actions: like actions

		do
			l_actions := actions (k)
			if l_actions = Void then
				create l_actions
				if a_details /= Void then
					actions_by_code.put ([l_actions, a_details], k.code)
				else
					actions_by_code.put ([l_actions, Void], k.code)
				end
			end
			l_actions.force_extend (a_action)
		end

feature -- Actions

	actions (k: EV_KEY): detachable EV_KEY_ACTION_SEQUENCE
			-- Actions registered for "and key" `k'
		do
			if attached actions_by_code.item (k.code) as d then
				Result := d.actions
			end
		end

	details (k: EV_KEY): detachable TUPLE [title: detachable STRING_GENERAL; description: detachable STRING_GENERAL]
			-- Actions registered for "and key" `k'
		do
			if attached actions_by_code.item (k.code) as d then
				Result := d.details
			end
		end

	data (k: EV_KEY): detachable TUPLE [actions: EV_KEY_ACTION_SEQUENCE; details: detachable TUPLE [title: detachable STRING_GENERAL; description: detachable STRING_GENERAL]]
			-- Actions registered for "and key" `k'
		do
			if attached actions_by_code.item (k.code) as d then
				Result := d
			end
		end

	actions_by_code: HASH_TABLE [attached like data, like {EV_KEY}.code]
			-- Registered actions indexed by "and key" `k.code'

feature -- Access

	widget: EV_WIDGET
			-- Associated widget to handle the "and key" key press actions

	timeout: INTEGER
			-- timeout delay

feature {NONE} -- Implementation

	focused_widget: detachable EV_WIDGET
			-- Focused widget when accelerator event occurred

	on_trigger_agent: PROCEDURE [ANY, TUPLE]
			-- Computed `on_trigger' agent

	Default_timeout: INTEGER = 1000
			-- Default delay

	timer: detachable EV_TIMEOUT
			-- Timeout between the accelerator and the "and key"

	accelerator_actions_before_merging: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Accelerator's actions when Current was `merged' during `attach_to'

	key_press_actions_backup: detachable EV_KEY_ACTION_SEQUENCE
			-- original key_press_actions from the widget
			-- backuped during Current execution

	prepare_key_press_actions (w: EV_POPUP_WINDOW)
			-- Backup the key_press_actions of `widget', before `on_trigger' processing
		do
			if w = widget then
				key_press_actions_backup := w.key_press_actions.twin
			end
			w.key_press_actions.wipe_out
			w.key_press_actions.extend (agent event_key_pressed (w, ?))
		end

	restore_key_press_actions (w: EV_POPUP_WINDOW)
			-- Restore the backuped key_press_actions of `widget', after `event_and_key_timer' been processed
		do
			if w /= widget then
				w.key_press_actions.wipe_out
			else
				w.key_press_actions.wipe_out
				if
					attached key_press_actions_backup as l_actions and then
					not l_actions.is_empty
				then
					w.key_press_actions.fill (l_actions)
				end
			end
		end

	stop_timer
		do
			if attached timer as t then
				t.actions.wipe_out
				t.set_interval (0)
				t.destroy
				timer := Void
			end
		end

	build_popup (pop: EV_POPUP_WINDOW)
		local
			k: INTEGER
			lab, dlab: EV_LABEL
			bb: EV_VERTICAL_BOX
			bd: detachable EV_VERTICAL_BOX
			bdi: detachable EV_VERTICAL_BOX
			b: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			wid: like widget
			l_actions_by_code: like actions_by_code
			l_acc_out: STRING
			s: STRING_32
		do
			pop.wipe_out
			pop.set_data (Void)
			create lab.make_with_text (accelerator.out + " + ... ?")
			create bd
			bd.set_border_width (3)
			bd.set_padding_width (2)
			bd.set_background_color (popup_info_color)
			from
				l_acc_out := accelerator.out
				l_actions_by_code := actions_by_code
				l_actions_by_code.start
			until
				l_actions_by_code.after
			loop
				k := l_actions_by_code.key_for_iteration
				if attached l_actions_by_code.item_for_iteration.details as l_details then
					if attached l_details.title as ti then
						create bdi
--						bdi.set_data (l_actions_by_code.key_for_iteration)
						bdi.set_border_width (2)
						create s.make_from_string (l_acc_out)
						s.append_character ('.')
						s.append_character ('.')
						s.append_string ((create {EV_KEY}.make_with_code (k)).out.as_upper)
						s.append_character (' ')
						s.append_character (':')
						s.append_character (' ')
						s.append_string_general (ti)
						create dlab.make_with_text (s)
						dlab.set_foreground_color (popup_border_color)
						dlab.align_text_left
						bdi.extend (dlab)
						if attached l_details.description as desc then
							create hb
							create s.make_from_string (desc)
							create dlab.make_with_text (s)
							dlab.align_text_right
							hb.extend (create {EV_CELL})
							hb.last.set_minimum_width (30)
							hb.disable_item_expand (hb.last)
							hb.extend (dlab)

							bdi.extend (hb)
						end
						if suggested_key_code = k then
							pop.set_data (k)
							bdi.set_background_color (popup_info_color)
							suggested_key_code := 0
						else
							if suggested_key_code = 0 then
								suggested_key_code := k
							end
							bdi.set_background_color (popup_background_color)
						end

						bdi.propagate_background_color
						bd.extend (bdi)
					end
				end
				l_actions_by_code.forth
			end
			if bd.count = 0 then
				bd.destroy
				bd := Void
			end

			create bb
			bb.set_border_width (1)
			bb.set_background_color (popup_border_color)
			create b
			b.set_background_color (popup_background_color)
			b.set_border_width (5)
			b.set_padding_width (3)
			bb.extend (b)

			pop.extend (bb)
			b.extend (lab)
			b.propagate_background_color
			if bd /= Void then
				b.extend (bd)
			end

			wid := widget
			pop.set_position (
				wid.x_position + (wid.width - pop.width) // 2,
				wid.y_position + (wid.height - pop.height) // 2
			)

			if attached {EV_WINDOW} wid as w then
				pop.show_relative_to_window (w)
			else
				pop.show
			end
		end

	on_trigger
		require
			widget_attached_if_popup_enabled: popup_enabled implies widget /= Void
		local
			t: like timer
			pop: detachable EV_POPUP_WINDOW
		do
			if actions_by_code.count > 0 then
				debug
					print ("on trigger%N")
				end
				suggested_key_code := 0
				focused_widget := ev_application.focused_widget
				last_key_pressed := Void
				create pop.make_with_shadow
				if popup_enabled then
					build_popup (pop)
				else
					pop.set_size (0, 0)
				end
				create t
				timer := t
				t.actions.extend (agent event_and_key_timer (pop))
				t.set_interval (timeout)

				prepare_key_press_actions (pop)

				set_focus (pop)
			end
		end

	set_focus (w: detachable EV_WIDGET)
		do
			if w /= Void and then not w.is_destroyed then
				w.set_focus
			end
		end

	popup_border_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 255)
		end

	popup_background_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		end

	popup_info_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (235, 235, 235)
		end

	last_key_pressed: detachable EV_KEY

	suggested_key_code: INTEGER

	selection_mode: BOOLEAN

	event_key_pressed (w: EV_POPUP_WINDOW; k: EV_KEY)
		do
			last_key_pressed := k
			event_and_key_timer (w)
		end

	event_and_key_timer (pop: EV_POPUP_WINDOW)
		local
			k: like last_key_pressed
			acc: like accelerator
			evapp: like ev_application
		do
			k := last_key_pressed
			acc := accelerator
			evapp := ev_application

			if selection_mode then
				debug
					print ("selection_mode=" + selection_mode.out + "%N")
				end
				if
					evapp.alt_pressed = acc.alt_required and
					evapp.ctrl_pressed = acc.control_required and
					evapp.shift_pressed = acc.shift_required
				then
					--| Continue
					if k /= Void then
						if k.code = {EV_KEY_CONSTANTS}.key_enter then
							if attached {INTEGER} pop.data as sk then
								create k.make_with_code (sk)
								process_and_then_key (pop, k)
							end
						elseif k ~ acc.key then
							pop.lock_update
							build_popup (pop)
							pop.unlock_update
						else
							process_and_then_key (pop, k)
						end
					end
				else
					if k = Void then
						if attached {INTEGER} pop.data as sk then
							create k.make_with_code (sk)
						end
					end
					process_and_then_key (pop, k)
				end
			else
				if
					(k = Void or else k ~ acc.key) and then (
						evapp.alt_pressed = acc.alt_required and
						evapp.ctrl_pressed = acc.control_required and
						evapp.shift_pressed = acc.shift_required
					)
				then
					if k ~ acc.key then
						if not popup_enabled then
	--						if pop.count = 0 then
	--							pop.hide
								pop.lock_update
								build_popup (pop)
								pop.unlock_update
	--							pop.show
	--						end
						end
--						enter_popup_selection_mode (pop)
						selection_mode := True
					end
					-- wait for key ..
				else
					process_and_then_key (pop, k)
				end
			end
			last_key_pressed := Void
		end

--	enter_popup_selection_mode (pop: EV_POPUP_WINDOW)
--		do
--			selection_mode := True
----			if selection_mode then
----				if k /= Void and then k.code = {EV_KEY_CONSTANTS}.key_enter then
----					if attached {EV_POPUP_WINDOW} w as pop then
----						if attached {INTEGER} pop.data as sk then
----							create k.make_with_code (sk)
----							process_and_then_key (w, k)
----						end
----					end
----				end
----			else
--		end

	exit_popup_selection_mode (w: EV_POPUP_WINDOW)
		do
			selection_mode := False
			process_and_then_key (w, Void)
		end

	process_and_then_key (w: EV_POPUP_WINDOW; k: detachable EV_KEY)
		do
			selection_mode := False
			suggested_key_code := 0
			w.destroy
			stop_timer
			restore_key_press_actions (w)
			if attached focused_widget as fw then
				set_focus (fw)
				focused_widget := Void
			end
			if k /= Void and then attached actions (k) as a then
				a.call ([k])
			else
				if attached accelerator_actions_before_merging as dft then
					dft.call (Void)
				end
			end
			last_key_pressed := Void
		end

end

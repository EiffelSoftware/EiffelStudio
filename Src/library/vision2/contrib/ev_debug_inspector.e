note
	description: "Basic debugging tool to inspect EiffelVision2 application layout."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEBUG_INSPECTOR

inherit
	EV_SHARED_APPLICATION

create
	make,
	make_and_register_for_window

feature {NONE} -- Initialization

	make
		local
			acc: EV_ACCELERATOR
		do
			create accelerators.make (2)
			create acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_d), True, False, True)
			acc.actions.extend (agent on_new_window_inspection)
			accelerators.extend (acc)

			create acc.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_i), True, False, True)
			acc.actions.extend (agent on_new_widget_inspection)
			accelerators.extend (acc)
		end

	make_and_register_for_window (a_window: EV_WINDOW)
		do
			make
			register_for_window (a_window)
		end

feature -- Element change

	set_main_accelerator (k: EV_KEY; a_require_ctrl, a_require_alt, a_require_shift: BOOLEAN)
			-- Change the shortcut to open the inspector window.
		require
			not has_associated_inspector
		local
			acc: EV_ACCELERATOR
		do
			acc := accelerators.i_th (1)
			acc.actions.wipe_out

			create acc.make_with_key_combination (k, a_require_ctrl, a_require_alt, a_require_shift)
			acc.actions.extend (agent on_new_window_inspection)
			accelerators.put_i_th (acc, 1)
		end

	set_target_accelerator (k: EV_KEY; a_require_ctrl, a_require_alt, a_require_shift: BOOLEAN)
			-- Change the shortcut to drop the focused widget into the inspector window, if any.
		require
			not has_associated_inspector
		local
			acc: EV_ACCELERATOR
		do
			acc := accelerators.i_th (2)
			acc.actions.wipe_out

			create acc.make_with_key_combination (k, a_require_ctrl, a_require_alt, a_require_shift)
			acc.actions.extend (agent on_new_widget_inspection)
			accelerators.put_i_th (acc, 2)
		end

feature -- Access

	register_for_window (win: EV_WINDOW)
		do
			if attached window as l_old_win then
				across
					accelerators as ic
				loop
					l_old_win.accelerators.prune_all (ic.item)
				end
			end
			window := win

			across
				accelerators as ic
			loop
				win.accelerators.extend (ic.item)
			end
		end

feature {NONE} -- Access

	window: detachable EV_WINDOW

	inspector: detachable EV_DEBUG_INSPECTOR_WINDOW

	accelerators: ARRAYED_LIST [EV_ACCELERATOR]

feature -- Status report

	has_associated_inspector: BOOLEAN
		do
			Result := inspector /= Void
		end

feature {NONE} -- Agents			

	on_new_window_inspection
		local
			l_new: EV_DEBUG_INSPECTOR_WINDOW
		do
			if attached window as l_obswin then
				create l_new.make (l_obswin)
				inspector := l_new
				l_new.drop_widget (l_obswin)
				l_new.show_relative_to_window (l_obswin)
			else
					--Ignore
				check has_window: False end
			end
		end

	on_new_widget_inspection
		local
			w: EV_IDENTIFIABLE
			sc: EV_SCREEN
			l_w: EV_WIDGET
		do
			if attached window as win then
				win.show
			end
			create sc
			l_w := sc.widget_at_mouse_pointer

			if l_w = Void then
				l_w := ev_application.focused_widget
			end
			if l_w /= Void then
				if attached {EV_IDENTIFIABLE} l_w as l_idw then
					w := l_idw
				end
			end
			if attached inspector as insp then
				insp.drop_widget (w)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

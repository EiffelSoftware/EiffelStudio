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
					accelerators as l_acc
				loop
					l_old_win.accelerators.prune_all (l_acc)
				end
			end
			window := win

			across
				accelerators as l_acc
			loop
				win.accelerators.extend (l_acc)
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
			l_inspector: EV_DEBUG_INSPECTOR_WINDOW
		do
			if attached window as l_obswin then
				create l_inspector.make (l_obswin)
				inspector := l_inspector
				l_inspector.drop_widget (l_obswin)
				l_inspector.show_relative_to_window (l_obswin)
			else
					--Ignore
				check has_window: False end
			end
		end

	on_new_widget_inspection
		local
			l_inspector: EV_DEBUG_INSPECTOR_WINDOW
			w: like widget_to_inspect
		do
			if attached window as win then
				win.set_focus
			end
			l_inspector := inspector
			w := widget_to_inspect (window)
			if l_inspector = Void then
				if attached window as l_obswin then
					create l_inspector.make (l_obswin)
					inspector := l_inspector
					if w = Void then
						w := l_obswin
					end
					l_inspector.drop_widget (w)
					l_inspector.show_relative_to_window (l_obswin)
				end
			else
				l_inspector.drop_widget (w)
			end
		end

	widget_to_inspect (a_window: detachable EV_WINDOW): detachable EV_ANY
		local
			sc: EV_SCREEN
		do
			create sc
			Result := sc.widget_at_mouse_pointer
			if Result = Void and a_window /= Void then
				Result := widget_at_position_from (a_window, sc.pointer_position)
			end
			if Result = Void then
				Result := ev_application.focused_widget
			end
		end

	widget_at_position_from (a_container: detachable EV_CONTAINER; a_position: EV_COORDINATE): detachable EV_ANY
		do
			if a_container /= Void and then is_position_over_item (a_position, a_container) then
				across
					a_container as l_any
				loop
					if attached {EV_CONTAINER} l_any as l_cont then
						Result := widget_at_position_from (l_cont, a_position)
					end
					if Result = Void then
						if is_position_over_item (a_position, l_any) then
							Result := l_any
						end
					end
				end
				if Result = Void then
					Result := a_container
				end
			end
		end

	is_position_over_item (a_position: EV_COORDINATE; a_any: EV_ANY): BOOLEAN
		do
			if attached {EV_POSITIONED} a_any as l_item then
				if
					a_position.x >= l_item.screen_x and then
					a_position.y >= l_item.screen_y and then
					a_position.x <= l_item.screen_x + l_item.width and then
					a_position.y <= l_item.screen_y + l_item.height
				then
					Result := True
				end
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

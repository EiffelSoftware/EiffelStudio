indexing
	description : "Objects that represents the special debug menu access point"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	ESTUDIO_DEBUG_CMD
inherit
	SYSTEM_CONSTANTS

	EB_SHARED_PREFERENCES

	SHARED_EXEC_ENVIRONMENT

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Creation

	make is
		do
			create windows_lists.make
		end

feature -- Status report

	preference_enable_menu: BOOLEAN is
			-- If the preference_want_to_show_estudio_debug_menu ?
		do
			Result := preferences.development_window_data.estudio_dbg_menu_allowed_preference.value
		end

	preference_debug_menu_enabled: BOOLEAN_PREFERENCE is
		do
			Result := preferences.development_window_data.estudio_dbg_menu_enabled_preference
		end

	preference_debug_menu_on_accelerator_enabled: BOOLEAN_PREFERENCE is
		do
			Result := preferences.development_window_data.estudio_dbg_menu_accelerator_allowed_preference
		end

feature -- Element change

	attach_window (w: EB_VISION_WINDOW) is
			-- Set main_window
		local
			lw: EB_VISION_WINDOW
		do
			if w /= Void then
				lw := w
			else
				lw := window_manager.last_focused_development_window.window
			end
			check lw /= Void end
			if preference_enable_menu then
				if preference_debug_menu_on_accelerator_enabled.value then
					add_accelerator (lw)
				end
				if preference_debug_menu_enabled.value then
					add_menu (lw)
				end
			end
		end

	unattach_window (w: EB_VISION_WINDOW) is
		local
			lw: EB_VISION_WINDOW
		do
			if w /= Void then
				lw := w
			else
				lw := window_manager.last_focused_development_window.window
			end
			check lw /= Void end

			remove_menu (lw)
			remove_accelerator (lw)
		end

feature {NONE} -- Implementation

	windows_lists: LINKED_LIST [TUPLE [EB_VISION_WINDOW, ESTUDIO_DEBUG_MENU, EV_ACCELERATOR]]

	menu (w: EB_VISION_WINDOW; remove_if_found: BOOLEAN): ESTUDIO_DEBUG_MENU is
		local
			t: TUPLE [window: EB_VISION_WINDOW; menu: ESTUDIO_DEBUG_MENU; acc: EV_ACCELERATOR]
		do
			from
				windows_lists.start
			until
				windows_lists.after or Result /= Void
			loop
				t := windows_lists.item
				if t.window = w then
					Result := t.menu
					if remove_if_found then
						if t.acc = Void then
							windows_lists.remove
						else
							t.menu := Void
							windows_lists.forth
						end
					else
						windows_lists.forth
					end
				else
					windows_lists.forth
				end
			end
		end

	accelerator (w: EB_VISION_WINDOW; remove_if_found: BOOLEAN): EV_ACCELERATOR is
		local
			t: TUPLE [window: EB_VISION_WINDOW; menu: ESTUDIO_DEBUG_MENU; acc: EV_ACCELERATOR]
		do
			from
				windows_lists.start
			until
				windows_lists.after or Result /= Void
			loop
				t := windows_lists.item
				if t.window = w then
					Result := t.acc
					if remove_if_found then
						if t.menu = Void then
							windows_lists.remove
						else
							t.acc := Void
							windows_lists.forth
						end
					else
						windows_lists.forth
					end
				else
					windows_lists.forth
				end
			end
		end

	add_details_for (w: EB_VISION_WINDOW; m: ESTUDIO_DEBUG_MENU; acc: EV_ACCELERATOR) is
		local
			t: TUPLE [window: EB_VISION_WINDOW; menu: ESTUDIO_DEBUG_MENU; acc: EV_ACCELERATOR]
		do
			from
				windows_lists.start
			until
				windows_lists.after or t /= Void
			loop
				t := windows_lists.item
				if t.window /= w then
					t := Void
				end
				windows_lists.forth
			end
			if t /= Void then
				if m /= Void then
					t.menu := m
				end
				if acc /= Void then
					t.acc := acc
				end
			else
				windows_lists.extend ([w, m, acc])
			end
		end

feature -- Command

	add_accelerator (w: EB_VISION_WINDOW) is
			-- Add accelerator related to Current command.
		require
			window_not_void: w /= Void
		local
			acc: like accelerator
			l_shortcut: EB_FIXED_SHORTCUT
		do
			if not w.is_destroyed then
				acc := accelerator (w, False)
				if acc = Void then
					l_shortcut := preferences.misc_shortcut_data.debug_menu_shortcut
					create acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
					acc.actions.extend (agent update_menu (w))
		    		add_details_for (w, Void, acc)
					w.accelerators.extend (acc)
				end
			end
		end

	remove_accelerator (w: EB_VISION_WINDOW) is
			-- Remove `accelerator' from main development window.
		local
			acc: like accelerator
		do
			if not w.is_destroyed then
				acc := accelerator (w, True)
	    		if acc /= Void then
					w.accelerators.prune_all (acc)
	    		end
			end
		end

	remove_menu (w: EB_VISION_WINDOW) is
			-- Remove menu from menu bar then change the preference.
		local
			m: like menu
		do
			if not w.is_destroyed and then w.menu_bar /= Void then
				m := menu (w, True)
	    		if m /= Void then
	    			m.set_text ("") -- to hide a refresh issue of vision2
					w.menu_bar.prune (m)
			    	m.wipe_out
	    		end
		    	preference_debug_menu_enabled.change_actions.block
				preference_debug_menu_enabled.set_value (False)
		    	preference_debug_menu_enabled.change_actions.resume
			end
		end

	add_menu (w: EB_VISION_WINDOW) is
			-- Add menu to menu bar then change the preference.
		require
			w_not_void: w /= Void
		local
			m: like menu
		do
			if not w.is_destroyed and then w.menu_bar /= Void and then w.menu_bar.count > 1 then
				m := menu (w, False)
				if m = Void then
		    		create m.make_with_window (w)
		    		add_details_for (w, m, Void)
		    	end
		    	if not w.menu_bar.has (m) then
				    w.menu_bar.extend (m)
		    	end
		    	preference_debug_menu_enabled.change_actions.block
				preference_debug_menu_enabled.set_value (True)
		    	preference_debug_menu_enabled.change_actions.resume
			end
		end

	update_menu (w: EB_VISION_WINDOW) is
		require
			window_not_void: w /= Void
		local
			m: like menu
		do
			if not w.is_destroyed and then w.menu_bar /= Void then
				m := menu (w, False)
				if m = Void then
					add_menu (w)
				else
					remove_menu (w)
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

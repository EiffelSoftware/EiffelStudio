note
	description: "Summary description for {CTR_WINDOW_WITH_TRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_APPLICATION

inherit
	CTR_WINDOW
		redefine
			initialize,
			on_quit,
			minimize,
			on_first_shown
		end

create
	default_create

feature {NONE} -- Initialization

	initialize
		local
			b: EV_PIXEL_BUFFER_IMP
			p: EV_PIXEL_BUFFER
		do
			Precursor
			initialize_tray_icon
			minimize_actions.extend (agent hide_window)
			if attached vpn_icon as i then
				create b.make
				b.set_from_icon (i)
				create p
				p.replace_implementation (b)
				set_icon_pixmap (p)
			end
		end

	initialize_tray_icon
			-- Add icon in tray.
		local
			tw: like tray_icon_window
		do
			create tw.make
			tray_icon_window := tw
			tw.notify_icon_actions.extend (agent status_menu)

			create vpn_icon.make_by_id (1)
			tw.set_icon (vpn_icon)
			tw.add_notify_icon
			tw.set_tooltip ("Repository Tool")
		end

	on_first_shown
		do
			Precursor
			if attached tray_icon_window as tw then
				tw.set_tooltip ("Repository Tool")
				tw.update_notify_icon
			end
		end

	on_quit
		do
			Precursor
			clear_tray_icon
		end

feature -- Basic operation

	minimize
		do
			Precursor
			hide_window
		end

	show_window
			-- Restore window if minimized and show it.
		do
			if is_minimized then
				restore
			end
			show
			set_focus
			raise
		end

	hide_window
		do
			if not is_minimized and then is_show_requested then
				minimize
			end
			hide
		end

feature -- Menu

	status_menu (a_message: INTEGER)
			-- Show status menu of connection.
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
		do
--			if attached tray_icon_window as tw then
--				tw.set_tooltip ("Repository Tool")
--			end
			inspect a_message
			when {WEL_WM_CONSTANTS}.wm_rbuttonup then
				create m
				create mi.make_with_text ("Check now")
				mi.select_actions.extend (agent check_all_repositories)
				m.extend (mi)
				create mi.make_with_text ("Show")
				mi.select_actions.extend (agent show_window)
				m.extend (mi)
				create mi.make_with_text ("Hide")
				mi.select_actions.extend (agent hide_window)
				m.extend (mi)
				create mi.make_with_text ("Quit")
				mi.select_actions.extend (agent quit)
				m.extend (mi)
				m.show
			when {WEL_WM_CONSTANTS}.Wm_lbuttondblclk then -- wm_lbuttonup  then
--				context_menu.show
--| Issue when hiding a not visible window, and restoring ..
--| the window is active, but not in the foreground
--|
				if is_minimized then
					show_window
				else
					hide_window
				end
			else
			end
		end

feature {NONE} -- Destroying

	clear_tray_icon
			-- Remove icon from tray.
		do
			if attached tray_icon_window as w then
				w.remove_notify_icon
			end
		end

feature {NONE} -- Implementation: Access

	context_menu: detachable EV_MENU

	tray_icon_window: detachable WEL_NOTIFY_WINDOW
			-- Window used for inserting

	vpn_icon: detachable WEL_ICON


end

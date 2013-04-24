note
	description: "[
					Same as EV_TITLED_WINDOW, and it works well with Ribbon
																			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_TITLED_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			implementation,
			create_implementation,
			initialize,
			destroy
		end

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		local
			l_res: EV_RIBBON_RESOURCES
		do
			Precursor
			create l_res
			l_res.register_ribbon_window (Current)
		end

	create_interface_objects
			-- <Precursor>
		do
			create mini_toolbars.make (5)
			create context_menus.make (5)
			create contextual_tabs.make (5)
		end

feature -- Command

	destroy
		do
			Precursor
			context_menus.wipe_out
			contextual_tabs.wipe_out
			data := Void
			help_button := Void
			internal_name := Void
			internal_pixmap_path := Void
			mini_toolbars.wipe_out
			quick_access_toolbar := Void
		end

feature -- Access

	ribbon: detachable EV_RIBBON
			-- Associated ribbon if any
		deferred
		end

	application_menu: detachable EV_RIBBON_APPLICATION_MENU
			-- Associated application menu if any

	help_button: detachable EV_RIBBON_HELP_BUTTON
			-- Associated help button if any

	quick_access_toolbar: detachable EV_RIBBON_QUICK_ACCESS_TOOLBAR
			-- Associated quick access toolbar if any

	mini_toolbars: ARRAYED_LIST [EV_RIBBON_MINI_TOOLBAR]
			-- Associated mini toolbars if any

	context_menus: ARRAYED_LIST [EV_RIBBON_CONTEXT_MENU]
			-- Associated context menu if any

	contextual_tabs: ARRAYED_LIST [EV_RIBBON_TAB_GROUP]
			-- Associated contextual tabs if any

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	implementation: EV_TITLED_WINDOW_I
			-- Responsible for interaction with native graphics toolkit

feature {NONE} -- Implementation

	create_implementation
			-- Responsible for interaction with native graphics toolkit.
		do
			create {EV_RIBBON_TITLED_WINDOW_IMP} implementation.make
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

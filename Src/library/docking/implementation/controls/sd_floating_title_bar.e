indexing
	description: "Objects that represent the title bar when a zon is floating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_TITLE_BAR

inherit
	EV_HORIZONTAL_BOX

create
	make

feature {NONE} -- Initlization
	make (a_pixmap: EV_PIXMAP; a_title: STRING) is
			--
		local
			l_toolbar: EV_TOOL_BAR
		do
			create internal_shared
			default_create
			internal_pixmap := a_pixmap.twin
			internal_pixmap.set_minimum_size (internal_pixmap.width, internal_pixmap.height)
			extend (internal_pixmap)
			disable_item_expand (internal_pixmap)
			create internal_title.make_with_text (a_title)
			internal_title.align_text_left
			extend (internal_title)
			internal_title.pointer_button_press_actions.extend (agent on_pointer_press_title)
			internal_title.pointer_button_release_actions.extend (agent on_pointer_release_title)
			internal_title.pointer_motion_actions.extend (agent on_pointer_motion_title)
			create l_toolbar
			extend (l_toolbar)
			disable_item_expand (l_toolbar)
			create close
			close.set_pixmap (internal_shared.icons.close)
			l_toolbar.extend (close)
			close.pointer_button_press_actions.force_extend (agent on_close)
		end

feature -- Basic operation

	set_title (a_title: STRING) is
			--
		do
			internal_title.set_text (a_title)
		end

feature -- Actions

	close_actions: like internal_close_actions is
			--
		do
			if internal_close_actions = Void then
				create internal_close_actions
			end
			Result := internal_close_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} --
	internal_title: EV_LABEL
			-- Title.
	internal_pixmap: EV_PIXMAP
			-- Pixmap shown at left side.
	close: EV_TOOL_BAR_BUTTON
			-- Close button at right side.
	internal_close_actions: EV_NOTIFY_ACTION_SEQUENCE

	internal_shared: SD_SHARED
			-- All singletons.

feature {NONE} -- Implementation

	on_close is
			--
		do
			if internal_close_actions /= Void then
				internal_close_actions.call ([])
			end
		end

	on_pointer_press_title (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			pointer_button_press_actions.call ([a_x, a_y,a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

	on_pointer_release_title (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			pointer_button_release_actions.call ([a_x, a_y,a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

	on_pointer_motion_title (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			pointer_motion_actions.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

end

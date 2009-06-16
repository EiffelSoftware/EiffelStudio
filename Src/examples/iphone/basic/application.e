indexing
	description : "basic application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

	SHARED_LOG

	EXCEPTION_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_app: UI_APPLICATION
		do
			create l_app
			l_app.post_launch_actions.extend (agent launch)
			l_app.launch
		rescue
			if attached last_exception as l_exception then
				put_string (l_exception.exception_trace)
			end
		end

feature -- Actions

	launch
		local
			window: UI_WINDOW
			l_label: UI_LABEL
			l_rect: CG_RECT
		do
			l_rect := (create {UI_SCREEN}.make).bounds
			create window.make (l_rect)
			create l_rect.make (10, 50, 300, 100)
			create l_label.make_with_text ("Hello World!", l_rect)
			l_label.set_background_color (create {UI_COLOR}.make_rgba (0, 1, 0, 1))
			l_label.set_foreground_color (create {UI_COLOR}.make_rgba (1, 0, 1, 1))
			l_label.align_text_center
			window.extend (l_label)
			window.touches_began_actions.extend (agent touch_began_action (l_label, ?))
			window.touches_moved_actions.extend (agent touch_moved_action (l_label, ?))
			window.touches_ended_actions.extend (agent touch_ended_action (l_label, ?))
			window.show
		end

	touch_began_action (a_label: UI_LABEL; a_event: UI_EVENT)
		local
			l_point: CG_POINT
		do
			if attached {UI_TOUCH} a_event.all_touches.item as l_touch then
				l_point := l_touch.location
				a_label.set_text ("Starting touch " + i.out + " ...")
				a_label.set_center (l_point)
				i := i + 1
			end
		end

	touch_moved_action (a_label: UI_LABEL; a_event: UI_EVENT)
		local
			l_point: CG_POINT
		do
			if attached {UI_TOUCH} a_event.all_touches.item as l_touch then
				l_point := l_touch.location
				a_label.set_text ("Moving touch " + i.out + " ...")
				a_label.set_center (l_point)
				i := i + 1
			end
		end

	touch_ended_action (a_label: UI_LABEL; a_event: UI_EVENT)
		local
			l_point: CG_POINT
		do
			if attached {UI_TOUCH} a_event.all_touches.item as l_touch then
				l_point := l_touch.location
				a_label.set_text ("Ending touch " + i.out + " ...")
				a_label.set_center (l_point)
				i := i + 1
			end
		end

	i: NATURAL_64

end

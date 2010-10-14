note
	description: "Summary description for {CTR_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CTR_TOOL

inherit
	ANY

	CTR_SHARED_RESOURCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_name: STRING)
		do
			create {EV_VERTICAL_BOX} container
			create sd_content.make_with_widget (container, a_name)
			build_interface (container)
		end

	build_interface (a_container: EV_CONTAINER)
		deferred
		end

feature -- Element change

	set_ctr_window (w: like ctr_window)
			-- Set `ctr_window' to `w'
		do
			ctr_window := w
		end

	set_focus
		do
			if
				attached sd_content as c and then
				c.is_visible and then
				not c.is_destroyed
			then
				c.set_focus
			end
			if
				attached focus_widget as f and then
				not f.is_destroyed
			then
				f.set_focus
			end
		end

	focus_widget: detachable EV_WIDGET
			-- Real widget to focus, when `set_focus' is called
		do
		end

feature {CTR_WINDOW} -- Implementation

	ctr_window: detachable CTR_WINDOW

	sd_content: SD_CONTENT

	container: EV_BOX

end

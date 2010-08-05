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

feature {CTR_WINDOW} -- Implementation

	ctr_window: detachable CTR_WINDOW

	sd_content: SD_CONTENT

	container: EV_BOX

end

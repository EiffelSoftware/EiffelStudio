indexing
	description: "[
		Widget showing status and control buttons for an {EIFFEL_TEST_FACTORY_I}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_FACTORY_WIDGET

inherit
	ES_TESTING_TOOL_PROCESSOR_WIDGET
		rename
			processor as factory
		redefine
			build_notebook_widget_interface
		end

create
	make

feature {NONE} -- Initialization

	build_notebook_widget_interface (a_widget: like widget)
			-- <Precursor>
		local
			l_label: EV_LABEL
		do
			create l_label.make_with_text ("Created tests")
			l_label.align_text_left
			a_widget.extend (l_label)
			a_widget.disable_item_expand (l_label)

			Precursor (a_widget)
		end

feature {NONE} -- Access

	title: !STRING_32
		do
			Result := locale_formatter.translation ("Test creation")
		end

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.overlay_new_icon_buffer
		end

	icon_pixmap: !EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.overlay_new_icon
		end

end

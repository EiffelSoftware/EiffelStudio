
feature {NONE} -- ToolBar Implementation

	standard_toolbar: EV_TOOL_BAR
			-- Standard toolbar for this window

	build_standard_toolbar is
			-- Create and populate the standard toolbar.
		require
			toolbar_not_yet_created: standard_toolbar = Void
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
				-- Create the toolbar.
			create standard_toolbar
			
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("open.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("save.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)
		ensure
			toolbar_created: standard_toolbar /= Void and then  not standard_toolbar.is_empty
		end

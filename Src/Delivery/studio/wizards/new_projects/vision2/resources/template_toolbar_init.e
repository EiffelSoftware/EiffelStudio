
feature {NONE} -- ToolBar Implementation

	standard_toolbar: EV_TOOL_BAR
			-- Standard toolbar for this window.

	build_standard_toolbar
			-- Populate the standard toolbar.
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
				-- Initialize the toolbar.
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
			toolbar_initialized: not standard_toolbar.is_empty
		end

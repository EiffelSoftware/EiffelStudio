
feature {NONE} -- ToolBar Implementation

	standard_toolbar: EV_TOOL_BAR
			-- Standard toolbar for this window.

	build_standard_toolbar
			-- Populate the standard toolbar.
		do
				-- Initialize the toolbar.
			standard_toolbar.extend (new_toolbar_item ("New", "new.png"))
			standard_toolbar.extend (new_toolbar_item ("Open", "open.png"))
			standard_toolbar.extend (new_toolbar_item ("Save", "save.png"))
		ensure
			toolbar_initialized: not standard_toolbar.is_empty
		end

	new_toolbar_item (name: READABLE_STRING_GENERAL; image: READABLE_STRING_GENERAL): EV_TOOL_BAR_BUTTON
			-- A new toolbar item with an image from a file `image' or with a text `name' if image is not available.
		local
			toolbar_pixmap: EV_PIXMAP
		do
			if attached Result then
					-- Image could not be loaded.
					-- Use a text label instead.
				Result.set_text (name)
			else
					-- The first attempt to create a button from an image file.
				create Result
				create toolbar_pixmap
				toolbar_pixmap.set_with_named_file (image)
					-- Make sure the image is effectively loaded by computing its dimention.
				toolbar_pixmap.height.do_nothing
					-- Everything is OK, associate image with the button.
				Result.set_pixmap (toolbar_pixmap)
			end
		rescue
			if attached Result then
					-- Image could not be loaded.
					-- Create a button by setting a label text instead.
				retry
			end
		end

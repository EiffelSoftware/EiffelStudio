
				-- Create and add the toolbar.
			build_standard_toolbar
			main_container.extend (create {EV_HORIZONTAL_SEPARATOR})
			main_container.disable_item_expand (main_container.first)
			main_container.extend (standard_toolbar)
			main_container.disable_item_expand (standard_toolbar)

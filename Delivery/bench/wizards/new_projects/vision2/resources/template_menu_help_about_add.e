

			create menu_item.make_with_text (Menu_help_about_item)
			menu_item.select_actions.extend (~on_about)
			help_menu.extend (menu_item)
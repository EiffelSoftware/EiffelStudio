note
	description: "An example application for internatioaliztion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	EV_APPLICATION

	SHARED_NAMES
		undefine
			default_create, copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
			n := 1
			amount_of_money := {REAL_32} 200000.0
			hovercraft_buy_cost := {REAL_32} 54199.95
			hovercraft_sell_cost := {REAL_32} 44020.30
			mortgage_rate := {REAL_32} 5.31
			default_create
			prepare
			launch
		end

	prepare
		local
			pixmap : EV_PIXMAP
		do
			create first_window.make_with_title (names.application)
			first_window.close_request_actions.extend (agent destroy)
			first_window.set_size (500,500)
			create pixmap
			pixmap.set_with_named_file (Operating_environment.current_directory_name_representation
					+ Operating_environment.directory_separator.out + "logo.png")
			first_window.set_icon_pixmap (pixmap)
			build_menu_bar
			build_main_box
			first_window.set_menu_bar (standard_menu_bar)
			first_window.extend (main_box)
			first_window.set_height (170)
			first_window.set_width (500)
			first_window.show
		end

feature -- Informations


	n : INTEGER
	amount_of_money: REAL_32
	hovercraft_buy_cost: REAL_32
	hovercraft_sell_cost: REAL_32
	mortgage_rate: REAL_32


feature -- Create window elements


	build_menu_bar
			-- build the menu bar
		local
			about,
			italian, arabic, greek, unknown, russian, chinese, english, french, hungarian : EV_MENU_ITEM
			file, language_selection: EV_MENU
		do
			create standard_menu_bar.default_create
		-- File
			create file.make_with_text (names.file)
			file.set_data (agent names.file)

			create about.make_with_text (names.about)
			about.set_data (agent names.about)
			about.select_actions.extend (agent on_about)

			file.extend (about)
			standard_menu_bar.extend (file)

		-- Language selection
			create language_selection.make_with_text (names.language)
			language_selection.set_data (agent names.language)

			-- The arabic mo file is an example
			-- of datasource that does not have a lot of translations
			create arabic.make_with_text (names.arabic)
			arabic.set_data (agent names.arabic)
			arabic.select_actions.extend (agent update_language ("ar_SA"))

			-- The chinese is an example of language
			-- with no distinction between the singular and plural form.
			create chinese.make_with_text (names.chinese)
			chinese.set_data (agent names.chinese)
			chinese.select_actions.extend (agent update_language ("zh_CN"))

			-- The following language are examples
			-- of completely translated language
			create english.make_with_text (names.english)
			english.set_data (agent names.english)
			english.select_actions.extend (agent update_language ("en_GB"))
			create greek.make_with_text (names.greek)
			greek.set_data (agent names.greek)
			greek.select_actions.extend (agent update_language ("el_GR"))
			create italian.make_with_text (names.italian)
			italian.set_data (agent names.italian)
			italian.select_actions.extend (agent update_language ("it_IT"))
			create hungarian.make_with_text (names.hungarian)
			hungarian.set_data (agent names.hungarian)
			hungarian.select_actions.extend (agent update_language ("hu_HU"))

			-- An example of locale with a skript
			-- in this case the file "fr.mo" will be used
			create french.make_with_text (names.french)
			french.set_data (agent names.french)
			french.select_actions.extend (agent update_language ("fr_FR@euro"))

			-- Russian is a language that has 4 different pluralforms			
			create russian.make_with_text (names.russian)
			russian.set_data (agent names.russian)
			russian.select_actions.extend (agent update_language ("ru_RU"))


			-- This is an example of locale that is (probably) not on the system
			-- in this case the translation will come from mo file "xx_XX.mo"
			-- and the formattings rules used are the predefined of the library
			create unknown.make_with_text (names.unknown)
			unknown.set_data (agent names.unknown)
			unknown.select_actions.extend (agent update_language ("xx_XX"))


			language_selection.extend (arabic)
			language_selection.extend (chinese)
			language_selection.extend (english)
			language_selection.extend (greek)
			language_selection.extend (unknown)
			language_selection.extend (italian)
			language_selection.extend (russian)
			language_selection.extend (french)
			language_selection.extend (hungarian)
			standard_menu_bar.extend (language_selection)

		end

	build_main_box
			-- create, initialize and add the labels
		local
			separator1, separator2: EV_HORIZONTAL_SEPARATOR
		do
			create main_box
			build_buttons_box
			main_box.extend (buttons_box)
			build_info_box
			main_box.extend (info_box)
			create separator1
			main_box.extend (separator1)

			create hovercraft_info.make_with_text (names.number_of_hovercraft (n))
			main_box.extend (hovercraft_info)
			create separator2
			main_box.extend (separator2)
			create explanation.make_with_text (names.explanation)
			main_box.extend (explanation)
		end

	build_buttons_box
		do
			create buttons_box
			create buy_button.make_with_text (names.buy)
			buy_button.select_actions.extend (agent buy)
			buy_button.select_actions.extend (agent update_money_labels)
			buy_button.select_actions.extend (agent update_labels)
			buttons_box.extend (buy_button)

			create sell_button.make_with_text (names.sell)
			sell_button.select_actions.extend (agent sell)
			sell_button.select_actions.extend (agent update_money_labels)
			sell_button.select_actions.extend (agent update_labels)
			buttons_box.extend (sell_button)

			create update_time_button.make_with_text_and_action (names.update_date_time, agent update_date_time_labels)
			buttons_box.extend (update_time_button)
		end

	build_info_box
		local
			separator: EV_VERTICAL_SEPARATOR
		do
			create info_box

			create date_time_info.make_with_text (names.time+"%N"+names.date+"%N"+names.date_time)
			date_time_info.align_text_left
			info_box.extend (date_time_info)

			create separator
			info_box.extend (separator)

			create money_label.make_with_text (names.amount_of_money (amount_of_money)+"%N"+
											   names.hovercraft_cost (hovercraft_buy_cost)+"%N"+
											   names.hovercraft_sell_cost (hovercraft_sell_cost)+"%N"+
											   names.mortage_rate (mortgage_rate))
			info_box.extend (money_label)
			money_label.align_text_left

		end


feature -- Actions

	buy
			-- increment `n'
		do
			n := n + 1
			amount_of_money := amount_of_money - hovercraft_buy_cost
		end

	sell
			-- decrement `n'
		do
			n := n - 1
			amount_of_money := amount_of_money + hovercraft_sell_cost
		end

feature -- Update features

	update_language (a_lang: STRING)
			-- Reload strings in a new language
		do
			names.set_locale (a_lang)
			first_window.set_title (names.application)
			update_menu_bar
			update_money_labels
			update_date_time_labels
			update_labels
			update_buttons
			first_window.refresh_now
		end

	update_menu (a_menu: EV_MENU_ITEM)
			-- update the menu
		do
			if attached {FUNCTION [STRING_32]} a_menu.data as l_func then
				a_menu.set_text (l_func.item([]))
			end
			if attached {EV_MENU} a_menu as l_menu then
					-- means l_menu is not just an item but a submenu
				l_menu.do_all (agent update_menu (?))
			end
		end

	update_menu_bar
			-- update the menu bar
		do
			standard_menu_bar.do_all (agent update_menu(?))
		end



	update_money_labels
			-- update all labels
		do
			money_label.set_text (names.amount_of_money (amount_of_money)+"%N"+
								  names.hovercraft_cost (hovercraft_buy_cost)+"%N"+
								  names.hovercraft_sell_cost (hovercraft_sell_cost)+"%N"+
								  names.mortage_rate (mortgage_rate))
		end

	update_date_time_labels
			-- update the date/time labels
		do
			date_time_info.set_text (names.time+"%N"+names.date+"%N"+names.date_time)
		end

	update_labels
		do
			hovercraft_info.set_text (names.number_of_hovercraft (n))
			explanation.set_text (names.explanation)
		end


	update_buttons
		do
			buy_button.set_text (names.buy)
			sell_button.set_text (names.sell)
			update_time_button.set_text (names.update_date_time)
		end

feature {NONE} -- About Dialog Implementation

	on_about
			-- Display the About dialog.
		local
			about_dialog: ABOUT_DIALOG
		do
			create about_dialog
			about_dialog.show
		end

feature {NONE} -- Implementation

	first_window: EV_TITLED_WINDOW
			-- Main window.
	standard_menu_bar: EV_MENU_BAR
			-- Menu bar

	main_box : EV_VERTICAL_BOX
	buttons_box: EV_HORIZONTAL_BOX
	info_box: EV_HORIZONTAL_BOX

	buy_button: EV_BUTTON
	sell_button: EV_BUTTON
	update_time_button: EV_BUTTON

	date_time_info: EV_LABEL

	money_label: EV_LABEL

	hovercraft_info: EV_LABEL

	explanation: EV_LABEL;


note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

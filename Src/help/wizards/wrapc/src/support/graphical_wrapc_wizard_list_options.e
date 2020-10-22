note
	description: "Summary description for {WRAPC_WIZARD_LIST_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WRAPC_WIZARD_LIST_OPTIONS

inherit
	GRAPHICAL_WIZARD_STYLER
	GRAPHICAL_WIZARD_PAGE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_item_id: like item_id; a_list_of_functions: ARRAYED_LIST [STRING]; a_header_path: STRING)
			-- Create field identified by `a_id', with title `a_title'
			-- and optional description `a_optional_description'.
		do
			item_id := a_item_id
			list_of_functions := a_list_of_functions
			header_path := a_header_path
			widget := create {EV_VERTICAL_BOX}
			initialize
		end

	initialize
		local
			list_item: EV_LIST_ITEM
		do
				-- Create interface and add actions
			create main_box

			create checkeable_list_box
			create checkeable_list

			create check_button_box
			create check_button.make_with_text ("Select all")

			create view_file_button_box
			create view_file_button.make_with_text ("View C Header")

			across list_of_functions as ic loop
				create list_item.make_with_text (ic.item)
				checkeable_list.extend (list_item)
			end

			check_button.select_actions.extend (agent  (a_check_button: EV_CHECK_BUTTON; a_list: EV_CHECKABLE_LIST)
				do
					if a_check_button.is_selected then
						across a_list as ic loop
							a_list.check_item (ic.item)
						end
					else
						across a_list as ic loop
							a_list.uncheck_item (ic.item)
						end
					end
				end (check_button, checkeable_list)
			)
			view_file_button.select_actions.extend (agent  (a_header_path: STRING)
				local
					str: STRING
				do
					if {PLATFORM}.is_windows then
						str := "notepad $target"
					else
						str := "vi +$line $target"
					end
					str.replace_substring_all ({STRING_32} "$target", a_header_path)
					{EXECUTION_ENVIRONMENT}.launch (str)

				end (header_path)
			)

				-- Assembly gui elements
				-- Adding the list of C functions
			main_box.extend (checkeable_list_box)
			checkeable_list_box.extend (checkeable_list)
			checkeable_list.set_minimum_size (300, 300)
			checkeable_list_box.set_border_width (5)
			checkeable_list_box.set_padding_width (5)
			checkeable_list.set_tooltip ("List of C functions availables")
			main_box.disable_item_expand (checkeable_list_box)

				-- Select all
			main_box.extend (check_button_box)
			check_button_box.extend (check_button)
			check_button_box.disable_item_expand (check_button)
			check_button_box.set_border_width (5)
			check_button_box.set_padding_width (5)
			main_box.disable_item_expand (check_button_box)

				-- View Header
			main_box.extend (view_file_button_box)
			view_file_button_box.extend (view_file_button)
			view_file_button_box.disable_item_expand (view_file_button)
			view_file_button_box.set_border_width (5)
			view_file_button_box.set_padding_width (5)
			main_box.disable_item_expand (view_file_button_box)

			widget := main_box
		end

feature -- Access

	list_of_functions: ARRAYED_LIST [STRING]

	header_path: STRING

feature -- Access Widgets

	main_box: EV_VERTICAL_BOX

	check_button_box: EV_VERTICAL_BOX
	check_button: EV_CHECK_BUTTON
			-- Widget to select all the C functions

	checkeable_list_box: EV_VERTICAL_BOX
	checkeable_list: EV_CHECKABLE_LIST;
		-- list with C function headers.

	view_file_button_box: EV_VERTICAL_BOX
	view_file_button: EV_BUTTON;
	-- Widget to open the target c header

feature -- Access

	item_id: detachable READABLE_STRING_8
			-- Optional id to identify related page item.

feature -- Element change

	set_item_id (a_id: like item_id)
			-- Set `item_id' to `a_id'.
		do
			item_id := a_id
		end

feature -- Conversion

	widget: EV_WIDGET

end

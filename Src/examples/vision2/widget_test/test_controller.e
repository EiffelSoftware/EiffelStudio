indexing
	description: "Objects that control the tests."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONTROLLER
	
inherit
	EV_HORIZONTAL_BOX
	
	WIDGET_TEST_SHARED
		undefine
			copy, default_create, is_equal
		end
		
	INTERNAL
		undefine
			copy, default_create, is_equal
		end
	
create
	make_with_text_control
	
feature {NONE} -- Initialization

	make_with_text_control (a_text_control: EV_TEXT) is
			-- Create `Current' and assign `a_text_control' to
			-- `text_control'.
		require
			text_control_not_void: a_text_control /= Void
		do
			default_create
			create test_notebook
			test_notebook.selection_actions.extend (agent update_displayed_test)
			create class_texts.make (4)
			create class_names.make (4)
				-- Register `update_for_type_change' so that it will be
				-- executed every time the selected widget is changed.
			register_type_change_agent (agent update_for_type_change)

			hide_interface
			class_text_output := a_text_control
		end		
		
feature -- Status setting

	update_for_type_change (a_widget: EV_WIDGET) is
			-- Test widget has changed to `a_widget', so
			-- update displayed tests accordingly.
		require
			widget_not_void: a_widget /= Void
		do
				-- We remove all entries from `class_texts' as the widget has changed.
				-- Future modification would be to expand `class_texts' to hold all
				-- classes loaded, so if we return to a previous widget, we do not have to
				-- reload.
			class_texts.clear_all
				-- Remove existing tabs from `test_notebook', and perform all other
				-- resetting ready for next set of tests.
				-- We must block `select_actions' as they may be fired during a wipeout.
			test_notebook.selection_actions.block
			test_notebook.wipe_out
			test_notebook.selection_actions.resume	
			class_names.wipe_out
				
				-- Build tests corresponding to `test_widget_type'.
			retrieve_texts (test_widget_type)
			
				-- Insert first entry in `class_texts' to `text_control'
			if not class_texts.is_empty then
				class_texts.start
				class_text_output.set_text (class_texts.item_for_iteration)
				class_texts.start
				build_interface
			else
				hide_interface
			end
			build_tests
			
		end

feature {NONE} -- Implementation

	build_interface is
			--
		do
			wipe_out
			extend (test_notebook)
			disable_item_expand (test_notebook)
			test_notebook.position_tabs_bottom
		end

	hide_interface is
			--
		local
			cell: EV_CELL
		do
			wipe_out
			create cell
			cell.set_minimum_size (300, 300)
			extend (cell)
		end

	build_tests is
			-- Construct current tests based on all items
			-- contained in `class_names'.
		local
			common_test: COMMON_TEST
			container: EV_CONTAINER
			temp: BOOLEAN
			test_scrollable_area: EV_SCROLLABLE_AREA
			temp_h_box: EV_HORIZONTAL_BOX
			temp_frame: EV_FRAME
		do
			from
				class_names.start
			until
				class_names.off
			loop
				temp := feature {ISE_RUNTIME}.check_assert (False)
				common_test ?= new_instance_of (dynamic_type_from_string (class_names.item.as_upper))
				common_test.default_create
				temp := feature {ISE_RUNTIME}.check_assert (True)
				check
					common_test_not_void: common_test /= Void
				end
				create test_scrollable_area
				test_scrollable_area.set_minimum_size (330, 330)
				test_scrollable_area.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (216, 213, 255))

					-- We need to provide a small border between the widget and the scrollable area,
					-- so that when the widget is bigger than the scrollable area, there is still a small visible
					-- border.
				create temp_h_box
				temp_h_box.set_border_width (5)
				test_scrollable_area.extend (temp_h_box)
				test_scrollable_area.propagate_background_color
				temp_h_box.extend (common_test.widget)

				create temp_h_box
				create temp_frame
				temp_h_box.extend (temp_frame)
				temp_frame.extend (test_scrollable_area)
				temp_h_box.disable_item_expand (temp_frame)
				test_notebook.extend (temp_h_box)
				
				test_notebook.set_item_text (temp_h_box, test_name_from_class (class_names.item))
				class_names.forth
			end
		ensure
			notebook_count_correct: test_notebook.count = class_names.count
		end
		
	test_name_from_class (a_class_name: STRING): STRING is
			-- `Result' is `a_class_name' with Vision2 type stripped from front,
			-- "test" removed from the front, and all "_" replaced with " ". The first
			-- letter is also converted to uppercase.
			-- For example, "fixed_set_item_position_test" will be converted to
			-- "Set item position"
		local
			temp_string: STRING
		do
			temp_string := test_widget_type.substring (4, test_widget_type.count)
			check
				class_name_matches_type: a_class_name.as_lower.substring_index (temp_string.as_lower, 1) = 1
				class_name_ends_in_test: a_class_name.as_lower.substring (a_class_name.count - 3, a_class_name.count).is_equal ("test")
			end
			Result := a_class_name.substring (temp_string.count + 2, a_class_name.count - 5)
			Result.replace_substring_all ("_", " ")
			Result.put (Result.item (1).as_upper, 1)
		ensure
			Result_not_void: Result /= Void
		end
		

	update_displayed_test is
			-- Assign class text for test correpsonding to
			-- currently selected notebook item to `text_control'.
		local
			retrieved_text: STRING
		do
			retrieved_text := class_texts.item (class_names @ (test_notebook.selected_item_index))
			class_text_output.set_text (retrieved_text)
		end

	store_text (filename: STRING; directory: DIRECTORY) is
			-- For a filename `filename' in the directory `directory'
			-- load the file, read the contents, and place in `class_texts'
			-- and `class_names'.
		require
			filename_not_void: filename /= Void
			directory_not_void: directory /= Void
		local
			full_filename: FILE_NAME
			file: PLAIN_TEXT_FILE
		do
			create full_filename.make_from_string (directory.name)
			full_filename.extend (filename)
			create file.make_open_read (full_filename)
			file.readstream (file.count)
			class_texts.extend (file.last_string, filename.substring (1, filename.count - 2))
			class_names.extend (filename.substring (1, filename.count - 2))
			file.close
		ensure
			class_texts_increased: class_texts.count = old class_texts.count + 1
			class_names_increased: class_names.count = old class_names.count + 1
		end
		
		
	retrieve_texts (a_type: STRING) is
			-- Retrieve all test class files, and
			-- store them in `class_texts'.
		local
			directory: DIRECTORY
			directory_name: DIRECTORY_NAME
			filenames: ARRAYED_LIST [STRING]
			current_file_name:  STRING
		do
			create directory_name.make_from_string (".")
			directory_name.extend ("tests")
			directory_name.extend (a_type.substring (4, a_type.count))
			create directory.make_open_read (directory_name)
			filenames := directory.linear_representation
			from
				filenames.start
			until
				filenames.off
			loop
				current_file_name := filenames.item
					-- 5 is an arbitary value to ensure that we ignore "." and ".." files.
				if current_file_name.count > 5 then 
					store_text (current_file_name, directory)
				end
				filenames.forth
			end
		end
		
	class_texts: HASH_TABLE [STRING, STRING]
		-- All texts of classes associated with each class filename.
	
	class_names: ARRAYED_LIST [STRING]
		-- All class names of tests, ordered as found in directory.
		
	test_notebook: EV_NOTEBOOK
		-- A notebook containing all the tests that are available.
		
	included_tests: WIDGET_TEST_INCLUDE
		-- All available tests are included via this class.
	
	class_text_output: EV_TEXT
		-- An EV_TEXT to display all test class texts.

invariant
	test_notebook_not_void: test_notebook /= Void
	
end -- class TEST_CONTROLLER

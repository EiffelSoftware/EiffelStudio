indexing
	description: "Objects that control the tests."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONTROLLER
	
inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize, is_in_default_state
		end
	
	WIDGET_TEST_SHARED
		export
			{NONE} all
		undefine
			copy, default_create, is_equal
		end
		
	INSTALLATION_LOCATOR
		undefine
			copy, default_create, is_equal
		end
		
feature {NONE} -- Initialization

	initialize is
			-- Create `Current' and assign `a_text_control' to
			-- `text_control'.
		do
			Precursor {EV_HORIZONTAL_BOX}
			create test_notebook
			test_notebook.selection_actions.extend (agent update_displayed_test)
			create class_texts.make (4)
			create class_names.make (4)
				-- Register `update_for_type_change' so that it will be
				-- executed every time the selected widget is changed.
			register_type_change_agent (agent update_for_type_change)

			hide_interface
		end		
		
feature -- Status setting

	set_class_output (a_text_control: EV_TEXT) is
			-- Assign `a_text_control' to `class_text_output'.
		require
			text_control_not_void: a_text_control /= Void
		do
			class_text_output := a_text_control
		ensure
			control_set: class_text_output = a_text_control
		end		
		

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
		end
		
feature -- Access

	selected_test_name: STRING is
			-- `Result' is name of currently selected test.
		do
			Result := (class_names @ test_notebook.selected_item_index).twin
		end
		

feature {GENERATION_DIALOG} -- Basic operations

	generate_current_test (directory: DIRECTORY) is
			-- Generate a stand alone test that may be compiled, based on
			-- the selected test in `test_notebook'.
		require
			installation_corret: installation_location /= Void
		do
			Test_generator.generate_project (directory, selected_test_name,
				test_widget_type.substring (4, test_widget_type.count))	
		end

feature {NONE} -- Implementation

	build_interface is
			-- Add constructed notebook to intface.
		do
			wipe_out
			extend (test_notebook)
			test_notebook.position_tabs_bottom
		ensure
			notebook_parented: test_notebook.parent = Current
		end

	hide_interface is
			-- Hide tests displayed in `Current', and replace with an empty cell.
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
			temp: BOOLEAN
			test_scrollable_area: EV_SCROLLABLE_AREA
			temp_h_box: EV_HORIZONTAL_BOX
			temp_frame: EV_FRAME
			l_dynamic_type: INTEGER
		do
			from
				class_names.start
			until
				class_names.off
			loop
				l_dynamic_type := dynamic_type_from_string (class_names.item.as_upper)
				if l_dynamic_type /= -1 then
					common_test ?= new_instance_of (l_dynamic_type)
				else
					common_test := Void
				end
					-- Although the files we put in there should never cause `common_test' to be Void,
					-- we must protect it, as if anybody else was to put a file in one of these directories,
					-- then it would crash the system.
				if common_test /= Void then
					temp := {ISE_RUNTIME}.check_assert (False)
					common_test.default_create
					temp := {ISE_RUNTIME}.check_assert (True)
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
					test_notebook.extend (temp_h_box)
					
					test_notebook.set_item_text (temp_h_box, test_name_from_class (class_names.item))
					class_names.forth
				else
					class_names.remove
				end
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
		do
			application.idle_actions.extend (agent real_load_texts (a_type))
				-- We defer this so that it is executed on the idle actions of EV_APPLICATION.
				-- This speeds up the appearence of the type change to a user, as they are not
				-- waiting for the file to load before being able to interact with the interface.
		end
		
	real_load_texts (a_type: STRING) is
			-- Actually perform the loading of the file.
		local
			directory: DIRECTORY
			directory_name: DIRECTORY_NAME
			directory_string: STRING
			filenames: ARRAYED_LIST [STRING]
			current_file_name:  STRING
			error_label: EV_LABEL
		do
			application.idle_actions.prune (application.idle_actions.first)
			if installation_location /= Void then
				create directory_name.make_from_string (installation_location)
				directory_name.extend ("tests")
				directory_string := a_type.substring (4, a_type.count)
				directory_string.to_lower
				directory_name.extend (directory_string)
				create directory.make_open_read (directory_name)
				filenames := directory.linear_representation
				from
					filenames.start
				until
					filenames.off
				loop
					current_file_name := filenames.item
						-- 5 is an arbitary value to ensure that we ignore "." and ".." files.
						-- No valid test will have a name that is shorter than 5 characters.
					if current_file_name.count > 5 then 
						store_text (current_file_name, directory)
					end
					filenames.forth
				end
					-- Construct each test, and add to `test_notebook'.
				build_tests
				
					-- Insert first entry in `class_texts' to `text_control'
				if not class_names.is_empty then
					class_names.start
					class_text_output.set_text (class_texts.item (class_names.item))
					build_interface
				else
					hide_interface
				end
			else
				build_interface
				create error_label.make_with_text ("Unable to locate the tests for " + test_widget_type + ".%N%N" + location_error_message)
				test_notebook.extend (error_label)
				test_notebook.set_item_text (error_label, "Error retrieving tests")
			end
		end
		
		
	class_texts: HASH_TABLE [STRING, STRING]
		-- All texts of classes associated with each class filename.
		
	test_notebook: EV_NOTEBOOK
		-- A notebook containing all the tests that are available.
		
	included_tests: WIDGET_TEST_INCLUDE
		-- All available tests are included via this class.
		
	class_names: ARRAYED_LIST [STRING]
		-- All class names of tests, ordered as found in directory.
	
	class_text_output: EV_TEXT
		-- An EV_TEXT to display all test class texts.
	
	test_generator: WIDGET_TEST_PROJECT_GENERATOR is
			-- Once access to a project generator.
		once
			create Result
		end
		
	is_in_default_state: BOOLEAN is True
		-- Is `Current' in its default state?

invariant
	test_notebook_not_void: test_notebook /= Void
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEST_CONTROLLER

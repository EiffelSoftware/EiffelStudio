note
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

feature {NONE} -- Initialization

	initialize
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

	set_class_output (a_text_control: EV_TEXT)
			-- Assign `a_text_control' to `class_text_output'.
		require
			text_control_not_void: a_text_control /= Void
		do
			class_text_output := a_text_control
		ensure
			control_set: class_text_output = a_text_control
		end


	update_for_type_change (a_widget: EV_WIDGET)
			-- Test widget has changed to `a_widget', so
			-- update displayed tests accordingly.
		require
			widget_not_void: a_widget /= Void
		do
				-- We remove all entries from `class_texts' as the widget has changed.
				-- Future modification would be to expand `class_texts' to hold all
				-- classes loaded, so if we return to a previous widget, we do not have to
				-- reload.
			class_texts.wipe_out
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

	selected_test_name: STRING
			-- `Result' is name of currently selected test.
		do
			Result := (class_names @ test_notebook.selected_item_index).twin
		end


feature {GENERATION_DIALOG} -- Basic operations

	generate_current_test (directory: DIRECTORY)
			-- Generate a stand alone test that may be compiled, based on
			-- the selected test in `test_notebook'.
		do
			Test_generator.generate_project (directory, selected_test_name,
				test_widget_type.substring (4, test_widget_type.count))
		end

feature {NONE} -- Implementation

	build_interface
			-- Add constructed notebook to intface.
		do
			wipe_out
			extend (test_notebook)
			test_notebook.position_tabs_bottom
		ensure
			notebook_parented: test_notebook.parent = Current
		end

	hide_interface
			-- Hide tests displayed in `Current', and replace with an empty cell.
		local
			cell: EV_CELL
		do
			wipe_out
			create cell
			cell.set_minimum_size (300, 300)
			extend (cell)
		end

	build_tests
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

	test_name_from_class (a_class_name: STRING): STRING
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


	update_displayed_test
			-- Assign class text for test correpsonding to
			-- currently selected notebook item to `text_control'.
		local
			retrieved_text: STRING
		do
			retrieved_text := class_texts.item (class_names @ (test_notebook.selected_item_index))
			class_text_output.set_text (retrieved_text)
		end

	store_text (a_filename: PATH; a_directory: DIRECTORY)
			-- For a filename `a_filename' in the directory `a_directory'
			-- load the file, read the contents, and place in `class_texts'
			-- and `class_names'.
		require
			filename_not_void: a_filename /= Void
			directory_not_void: a_directory /= Void
		local
			l_file_name: STRING_32
			file: PLAIN_TEXT_FILE
		do
			create file.make_with_path (a_directory.path.extended_path (a_filename))
			file.open_read
			file.readstream (file.count)
			l_file_name := a_filename.name
			class_texts.extend (file.last_string, l_file_name.substring (1, l_file_name.count - 2))
			class_names.extend (l_file_name.substring (1, l_file_name.count - 2))
			file.close
		ensure
			class_texts_increased: class_texts.count = old class_texts.count + 1
			class_names_increased: class_names.count = old class_names.count + 1
		end


	retrieve_texts (a_type: STRING)
			-- Retrieve all test class files, and
			-- store them in `class_texts'.
		do
			if real_load_texts_agent = Void then
				real_load_texts_agent := agent real_load_texts
			end
			type_to_retrieve := a_type
			application.do_once_on_idle (real_load_texts_agent)
				-- We defer this so that it is executed on the idle actions of EV_APPLICATION.
				-- This speeds up the appearence of the type change to a user, as they are not
				-- waiting for the file to load before being able to interact with the interface.
		end

	real_load_texts_agent: PROCEDURE
	type_to_retrieve: STRING

	real_load_texts
			-- Actually perform the loading of the file.
		local
			directory: DIRECTORY
			directory_name: PATH
			dir_str: STRING
			filenames: ARRAYED_LIST [PATH]
			current_file_name:  PATH
			l_type: STRING
		do
			l_type := type_to_retrieve
			dir_str := l_type.substring (4, l_type.count)
			dir_str.to_lower
			directory_name := eiffel_layout.shared_application_path.extended ("tests").extended (dir_str)
			create directory.make_with_path (directory_name)
			directory.open_read
			filenames := directory.entries
			from
				filenames.start
			until
				filenames.off
			loop
				current_file_name := filenames.item
				if not current_file_name.is_current_symbol and not current_file_name.is_parent_symbol then
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

	test_generator: WIDGET_TEST_PROJECT_GENERATOR
			-- Once access to a project generator.
		once
			create Result
		end

	is_in_default_state: BOOLEAN = True
		-- Is `Current' in its default state?

invariant
	test_notebook_not_void: test_notebook /= Void

note
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

indexing
	description	: "Dialog for choosing where to put a new class"
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_CODE_GENERATION_DIALOG

inherit
	EV_DIALOG

	EV_LAYOUT_CONSTANTS
		undefine
			default_create, copy
		end
	
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy
		end

create
	make_default

feature {NONE} -- Initialization

	make_default is
		local
			vb: EV_VERTICAL_BOX
			buttons_box, horizontal_box: EV_HORIZONTAL_BOX
			name_frame, directory_frame, file_frame: EV_FRAME
			cancel_b, directory_b: EV_BUTTON	-- Button to discard the class 
			
		do

			make_with_title ("Generate class text")

				-- Build the widgets
			create class_entry.make_with_text ("NEW_CLASS")
			class_entry.change_actions.extend (agent update_file_entry)
			create file_entry.make_with_text ("new_class.e")
			create horizontal_box
			create directory_entry.make_with_text ("None chosen")
			create directory_b.make_with_text_and_action ("Select", agent choose_directory)

				-- Build the frames
			create name_frame.make_with_text ("Class name")
			create directory_frame.make_with_text ("Directory")
			create file_frame.make_with_text ("File name")
			name_frame.extend (class_entry)
			file_frame.extend (file_entry)
			directory_frame.extend (horizontal_box)
			horizontal_box.extend (directory_entry)
			extend_no_expand (horizontal_box, directory_b)
			

				-- Build the buttons
			create create_button.make_with_text_and_action ("Create", agent create_new_class)
			create_button.disable_sensitive
			set_default_size_for_button (create_button)
			create cancel_b.make_with_text_and_action ("Cancel", agent cancel)
			set_default_size_for_button (cancel_b)

				-- Build the button box
			create buttons_box
			buttons_box.set_padding (Small_border_size)
			buttons_box.extend (create {EV_CELL}) -- Expandable item
			extend_no_expand (buttons_box, create_button)
			extend_no_expand (buttons_box, cancel_b)

				-- Build the vertical layout (Class name, File name, cluster, buttons)
			create vb
			vb.set_padding (Small_border_size)
			vb.set_border_width (Small_border_size)
			extend_no_expand (vb, name_frame)
			extend_no_expand (vb, file_frame)
			extend_no_expand (vb, directory_frame)
			extend_no_expand (vb, buttons_box)

				-- Add the main container to the dialog.
			extend (vb)

				-- Setup the default buttons and show actions.
			set_default_cancel_button (cancel_b)
			set_default_push_button (create_button)
			show_actions.extend (agent on_show_actions)

			cancelled := False
		end

feature -- Status Report

	cancelled: BOOLEAN
			-- Was `Current' closed by discarding the dialog 
			-- (by clicking the Cancel button for example)?

feature {NONE} -- Implementation

	class_name: STRING is
			-- Name of the class entered by the user.
		do
			Result := clone (class_entry.text)
			if Result /= Void then
				Result.to_lower
			end
		end

	file_name: FILE_NAME is
			-- File name of the class chosen by the user.
		local
			str, str2: STRING
			dotpos: INTEGER
		do
			str2 := file_entry.text
			if str2 /= Void then
				str2.right_adjust
				str2.left_adjust
			end
			if str2 = Void or else str2.count < 3 then
				update_file_entry
				str := file_entry.text
				if str /= Void then
					create Result.make_from_string (file_entry.text)
				else
					create Result.make_from_string ("")
				end
			else
				if
					str2 @ (str2.count) /= 'e' or else
					str2 @ (str2.count - 1) /= '.'
				then
					dotpos := str2.index_of ('.', 1) - 1
					str2.head (dotpos.max (0))
					create Result.make_from_string (str2)
					Result.add_extension ("e")
				else
					create Result.make_from_string (str2)
				end
			end
		end

	aok: BOOLEAN
		-- Is current class name valid?

	create_new_class is
			-- Create a new class
		local
			code_generator: GB_CODE_GENERATOR
		do
			create code_generator
				-- If we select a drive and not a directory, we already have the directory separator in the directory string.
			if (directory_entry.text @ (directory_entry.text.count)).is_equal (operating_environment.directory_separator) then
				code_generator.generate (directory_entry.text + file_entry.text, class_entry.text)
			else
				code_generator.generate (directory_entry.text + operating_environment.directory_separator.out + file_entry.text, class_entry.text)
			end
		end

	on_show_actions is
			-- The dialog has just been shown, set it up.
		do
				--| Make sure the text in the class entry is entirely visible
				--| and is selected.
			class_entry.set_focus
			class_entry.set_caret_position (1)
			class_entry.select_all
		end

	check_valid_class_name is
			-- Check that name `class_name' is a valid class name.
		require
			current_state_is_valid: aok
		local
			cn: STRING
			wd: EV_WARNING_DIALOG
			cchar: CHARACTER
			i: INTEGER
		do
			cn := class_name
			if cn = Void or else cn.is_empty or else not (cn @ 1).is_alpha then
				aok := False
			else
				from
					i := 2
				until
					i > cn.count or not aok
				loop
					cchar := (cn @ i)
					aok := cchar.is_alpha or cchar.is_digit or cchar = '_'
					i := i + 1
				end
			end
			if not aok then
				if cn = Void then
					cn := ""
				end
				create wd.make_with_text ("Invalid class name")
				wd.show_modal_to_window (Current)
			end
		end

	update_file_entry is
			-- Update the file name according to the class name.
		local
			str: STRING
		do
			str := class_entry.text
			if str /= Void then
				str.right_adjust
				str.left_adjust
			end
			if str = Void or else str.is_empty then
				file_entry.remove_text
			else
				str.to_lower
				str.append (".e")
				file_entry.set_text (str)
			end
		end

	cancel is
			-- User pressed `cancel_b'.
		do
			cancelled := True
			destroy
		ensure
			cancelled_set: cancelled
		end
		
	choose_directory is
			-- Allow the user to choose a directory for the new generated class,
			-- using a directory dialog.
		local
			directory_dialog: EV_DIRECTORY_DIALOG
		do
			create directory_dialog
			directory_dialog.show_modal_to_window (Current)
				-- If the user selected a directory, then use this.
			if not directory_dialog.directory.is_empty then
				directory_entry.set_text (directory_dialog.directory)
				create_button.enable_sensitive
			end
		end
		

feature {NONE} -- Vision2 widgets

	create_button: EV_BUTTON
			-- Button to create the class
			
	cluster_list: EV_LIST
			-- List of all available clusters.

	class_entry: EV_TEXT_FIELD
			-- Text field in which the user will type the name of the class.
			
	file_entry: EV_TEXT_FIELD
			-- Text field in which the user may type the file name of the class.
			
	directory_entry: EV_TEXT_FIELD
			-- Text field to display the directory chosen by the user.

feature {NONE} -- Constants

	Cluster_list_minimum_width: INTEGER is
			-- Minimum width for the cluster list.
		do
			Result := Dialog_unit_to_pixels (250)
		end
		
	Cluster_list_minimum_height: INTEGER is
			-- Minimum height for the cluster list.
		do
			Result := Dialog_unit_to_pixels (300)
		end

end -- class GB_CODE_GENERATION_DIALOG


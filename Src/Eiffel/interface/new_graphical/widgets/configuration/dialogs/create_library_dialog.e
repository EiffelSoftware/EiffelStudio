indexing
	description: "Dialog to add a library."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_LIBRARY_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	EB_LAYOUT_CONSTANTS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	EIFFEL_ENV
		undefine
			copy,
			default_create
		end

	CONF_VALIDITY
		undefine
			copy,
			default_create
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_factory: CONF_FACTORY) is
			-- Create.
		require
			a_target_not_void: a_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			target := a_target
			factory := a_factory
			default_create
			set_title (dialog_create_library_title)
		ensure
			target_set: target = a_target
			factory_set: factory = a_factory
		end

	initialize is
			-- Initialize.
		local
			l_btn: EV_BUTTON
			hb_out: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hb, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_dir: KL_DIRECTORY
			l_subdirs: ARRAY [STRING]
			i, cnt: INTEGER
			l_name: STRING
		do
			Precursor {EV_DIALOG}

			create hb_out
			extend (hb_out)
			append_margin (hb_out)
			create vb
			hb_out.extend (vb)

			append_margin (vb)

			create l_lbl.make_with_text (dialog_create_library_defaults)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create default_libraries
			vb.extend (default_libraries)

				-- look for configuration files under $ISE_LIBRARY/library or $ISE_LIBRARY/library/somedirectory
			create l_dir.make (Library_path)
			if l_dir.is_readable then
				add_configs_in_dir (Library_path, library_directory_name)
				l_subdirs := l_dir.directory_names
				if l_subdirs /= Void then
					from
						i := 1
						cnt := l_subdirs.count
					until
						i > cnt
					loop
						l_name := library_path.twin
						l_name.append_character (platform_constants.directory_separator)
						l_name.append (l_subdirs.item (i))
						add_configs_in_dir (l_name, library_directory_name+"\"+l_subdirs.item (i))
						i := i +1
					end
				end
			end

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_library_name)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb.extend (name)
			vb.disable_item_expand (name)

			append_small_margin (vb)

			create l_lbl.make_with_text (dialog_create_library_location)
			vb.extend (l_lbl)
			vb.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb.extend (hb2)
			vb.disable_item_expand (hb2)

			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (ellipsis_text, agent browse)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			append_small_margin (vb)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})

			create l_btn.make_with_text (ev_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)

			create l_btn.make_with_text (ev_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)

			append_margin (vb)

			append_margin (hb_out)

			set_minimum_size (400, 400)
		end

feature {NONE} -- GUI elements

	default_libraries: EV_LIST
			-- Libraries provided by ISE.

	location: EV_TEXT_FIELD
			-- Location of the library configuration file, choosen by the user.

	name: EV_TEXT_FIELD
			-- Name of the library.

feature {NONE} -- Actions

	browse is
			-- Browse for a location.
		local
			l_brows_dial: EV_FILE_OPEN_DIALOG
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
		do
			create l_brows_dial
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make (l_loc.evaluated_directory)
				if l_dir.exists then
					l_brows_dial.set_start_directory (l_dir.name)
				end
			end

			l_brows_dial.open_actions.extend (agent set_location (l_brows_dial))
			l_brows_dial.show_modal_to_window (Current)
		end

	set_location (a_dial: EV_FILE_DIALOG) is
			-- Set location from `a_dial'.
		require
			a_dial_not_void: a_dial /= Void
		do
			location.set_text (a_dial.file_name)
		end

	fill_library (a_name, a_location: STRING) is
			-- Fill in library informations.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_location_ok: a_location /= Void and then not a_location.is_empty
		do
			name.set_text (a_name)
			location.set_text (a_location)
		end

	on_cancel is
			-- Close the dialog.
		do
			destroy
		end

	on_ok is
			-- Add library and close the dialog.
		local
			l_loc: CONF_FILE_LOCATION
			wd: EV_WARNING_DIALOG
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if target.groups.has (name.text) then
					create wd.make_with_text (group_already_exists (name.text))
					wd.show_modal_to_window (Current)
				else
					l_loc := factory.new_location_from_full_path (location.text, target)
					target.add_library (factory.new_library (name.text, l_loc, target))
					destroy
				end
			end
		end


feature {NONE} -- Implementation

	target: CONF_TARGET
			-- Target where we add the library.

	factory: CONF_FACTORY
			-- Factory to create a library.

	add_configs_in_dir (a_path, a_subdir: STRING) is
			-- Add config files in `a_path' to `default_libraries'.
		require
			a_path_not_void: a_path /= Void
		local
			l_dir: KL_DIRECTORY
			l_files: ARRAY [STRING]
			i, cnt: INTEGER
			l_file_name, l_name: STRING
			l_item: EV_LIST_ITEM
		do
			create l_dir.make (a_path)
			if l_dir.is_readable then
				l_files := l_dir.filenames
				if l_files /= Void then
					from
						i := l_files.lower
						cnt := l_files.upper
					until
						i > cnt
					loop
						l_file_name := l_files.item (i)
						if valid_config_extension (l_file_name) then
							l_name := l_file_name.substring (1, l_file_name.last_index_of ('.', l_file_name.count)-1)
							create l_item.make_with_text (l_name)
							l_item.select_actions.extend (agent fill_library (l_name, "$ISE_LIBRARY\"+a_subdir+"\"+l_file_name))
							default_libraries.extend (l_item)
						end
						i := i + 1
					end
				end
			end
		end

invariant
	target_not_void: target /= Void
	factory_not_void: factory /= Void

end

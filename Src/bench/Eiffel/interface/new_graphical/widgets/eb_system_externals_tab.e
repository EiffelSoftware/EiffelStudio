indexing
	description: "Graphical representation of Externals tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_EXTERNALS_TAB

inherit
	EV_VERTICAL_BOX

	EB_SYSTEM_TAB
		rename
			make as tab_make
		undefine
			default_create, is_equal, copy
		redefine
			reset
		end

	EIFFEL_ENV
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end
		
create
	make

feature -- Access

	name: STRING is "Externals"
			-- Name of tab in System Window.

feature -- External access

	include_path_list: EV_ADD_REMOVE_PATH_LIST
			-- List of include path.
			
	object_file_list: EV_ADD_REMOVE_PATH_LIST
			-- List of object file.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			cl: LACE_LIST [LANG_TRIB_SD]
		do
			if not include_path_list.is_empty or not object_file_list.is_empty then
				cl := root_ast.externals
				if cl = Void then
						-- No default option, we need to create them.
					create cl.make (2)
					root_ast.set_externals (cl)
				end
				if not include_path_list.is_empty then
					cl.extend (new_lang_trib_sd (
						new_language_name_sd (new_id_sd ("include_path", False)),
						new_lace_list (include_path_list.list)))
				end
				
				if not object_file_list.is_empty then
					cl.extend (new_lang_trib_sd (
						new_language_name_sd (new_id_sd ("object", False)),
						new_lace_list (object_file_list.list)))
				end
			end
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		do
			initialize_from_ast (root_ast)
		end

feature {NONE} -- Filling

	initialize_from_ast (root_ast: ACE_SD) is
			-- Initialize window with all data taken from `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		local
			cl: LACE_LIST [LANG_TRIB_SD]
			lace_list: LACE_LIST [ID_SD]
			list_item: EV_LIST_ITEM
			list: EV_LIST
			text_field: EV_TEXT_FIELD
		do
			cl := root_ast.externals
			if cl /= Void then
				from
					cl.start
				until
					cl.after
				loop
					if cl.item.language_name.is_include_path then
						from
							lace_list := cl.item.file_names
							lace_list.start
							list := include_path_list.list
							text_field := include_path_list.text_field
						until
							lace_list.after
						loop
							create list_item.make_with_text (lace_list.item)
							list_item.select_actions.extend (text_field~set_text (lace_list.item))
							list.extend (list_item)
							lace_list.forth
						end
						cl.remove
					elseif cl.item.language_name.is_object then
						from
							lace_list := cl.item.file_names
							lace_list.start
							list := object_file_list.list
							text_field := object_file_list.text_field
						until
							lace_list.after
						loop
							create list_item.make_with_text (lace_list.item)
							list_item.select_actions.extend (text_field~set_text (lace_list.item))
							list.extend (list_item)
							lace_list.forth
						end
						cl.remove
					else
						cl.forth
					end
				end
			end
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Initialization

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			include_path_list.reset
			object_file_list.reset
		ensure then
			include_path_list_empty: include_path_list.is_empty
			object_file_list: object_file_list.is_empty
		end

feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `Externals' tab in notebook.
		local
			frame: EV_FRAME
		do
			system_window := top
			tab_make

			default_create
			set_border_width (5)
			set_padding (3)
			
			create include_path_list.make_with_parent (top.window)
			include_path_list.set_browse_for_directory
			create frame.make_with_text ("Include path")
			frame.extend (include_path_list)
			extend (frame)

			create object_file_list.make_with_parent (top.window)
			object_file_list.set_browse_for_file (Void)
			create frame.make_with_text ("Object file")
			frame.extend (object_file_list)
			extend (frame)

				-- Add C specific widgets
			c_specific_widgets.extend (Current)
		end

invariant
	include_path_list_not_void: include_path_list /= Void
	object_file_list_not_void: object_file_list /= Void
	
end -- class EB_SYSTEM_EXTERNALS_TAB


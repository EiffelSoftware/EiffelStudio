indexing
	description: "Graphical representation of .NET assembly information tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_MSIL_RESOURCES_TAB

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

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end
		
	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_Create, is_equal, copy
		end

create
	make

feature -- Access

	name: STRING is "Resources"
			-- Name of tab in System Window.

	resource_file_list: EV_ADD_REMOVE_PATH_LIST
			-- List of object file.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.
			
feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store Resources in Ace files.
		local
			cl: LACE_LIST [LANG_TRIB_SD]
		do
			if msil_widgets_enabled and then not resource_file_list.is_empty then
				cl := root_ast.externals
				if cl = Void then
						-- No default option, we need to create them.
					create cl.make (2)
					root_ast.set_externals (cl)
				end
				if not resource_file_list.is_empty then
					cl.extend (create {LANG_TRIB_SD}.initialize (
						create {LANGUAGE_NAME_SD}.initialize (new_id_sd ("dotnet_resource", False)),
						new_lace_list (resource_file_list.list)))
				end
			end
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		do
			if msil_widgets_enabled then
				initialize_from_ast (root_ast)
			end
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
					if cl.item.language_name.is_dotnet_resource then
						from
							lace_list := cl.item.file_names
							lace_list.start
							list := resource_file_list.list
							text_field := resource_file_list.text_field
						until
							lace_list.after
						loop
							create list_item.make_with_text (lace_list.item)
							list_item.select_actions.extend (
								agent text_field.set_text (lace_list.item))
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

feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		require
			top_not_void: top /= Void
		local
			l_frame: EV_FRAME
		do
			system_window := top
			tab_make
			default_create

			set_border_width (5)
			set_padding (3)
			
			create resource_file_list.make_with_parent (top.window)
			resource_file_list.set_browse_for_file ("*.resx")
			resource_file_list.set_is_entry_valid (agent is_resource_name_valid)
			resource_file_list.set_display_error_message (agent display_error_message)
			create l_frame.make_with_text ("Resources")
			l_frame.extend (resource_file_list)
			
			extend (l_frame)
			msil_specific_widgets.extend (Current)
		end

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			resource_file_list.reset
		ensure then
			resource_file_list_empty: resource_file_list.is_empty
		end

feature {NONE} -- Implementation: actions

	is_resource_name_valid (n: STRING): BOOLEAN is
			-- Is `n' valid as a resource name? It can only accept files with
			-- extensions `.resX, .txt, or .resources'.
		require
			n_not_void: n /= Void
		do
			Result := (n.count > 5) and n.substring (n.count - 4, n.count).as_lower.is_equal (".resx")
			if not Result then
				Result := (n.count > 4) and n.substring (n.count - 3, n.count).as_lower.is_equal (".txt")
				if not Result then
					Result := (n.count > 10) and n.substring (n.count - 9, n.count).as_lower.is_equal (".resources")
				end
			end
		end

	display_error_message (n: STRING) is
			-- Display error message associated with incorrect resource file name `n'.
		require
			n_not_void: n /= Void
		local
			l_error: EV_ERROR_DIALOG
			l_text: STRING
		do
			l_text := "Invalid resource file name %"" + n + "%".%N%N"
			l_text.append ("Make sure it has either the extension `.resX', `.txt' or `.resources'.")
			create l_error.make_with_text (l_text)
			l_error.set_buttons (<<ev_ok>>)
			l_error.set_default_push_button(l_error.button (ev_ok))
			l_error.set_default_cancel_button(l_error.button (ev_ok))
			l_error.show_modal_to_window (system_window.window)
		end

invariant
	resource_file_list_not_void: resource_file_list /= Void

end -- class EB_SYSTEM_MSIL_RESOURCES_TAB

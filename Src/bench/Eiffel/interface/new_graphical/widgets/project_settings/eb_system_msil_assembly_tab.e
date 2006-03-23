indexing
	description: "Graphical representation of .NET assembly information tab in EB_SYSTEM_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_MSIL_ASSEMBLY_TAB

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
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Access

	name: STRING is "Assemblies"
			-- Name of tab in System Window.

	gac_assembly_list: EV_EDITABLE_LIST
			-- List of GAC assemblies used in Current project.

	local_assembly_list: EV_EDITABLE_LIST
			-- List of assembly used in Current project.

	md_cache_path: EV_PATH_FIELD
			-- Alternative metadata cache path.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			--
		local
			al: LACE_LIST [ASSEMBLY_SD]
			l_assembly_sd: ASSEMBLY_SD
			l_row: EV_MULTI_COLUMN_LIST_ROW
			pref_string: ID_SD
			l_defaults: LACE_LIST [D_OPTION_SD]
		do
			if msil_widgets_enabled then

				l_defaults := root_ast.defaults
				if l_defaults = Void then
					create l_defaults.make (1)
					root_ast.set_defaults (l_defaults)
				end
				if not md_cache_path.text.is_empty then
					l_defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.metadata_cache_path, md_cache_path.text, False))
				end

				al := root_ast.assemblies
				check
					correctly_retrieved: al = Void or else al.is_empty
				end
				if al = Void then
					create al.make (gac_assembly_list.count + local_assembly_list.count)
				end
					-- Store local references
				from
					local_assembly_list.start
				until
					local_assembly_list.after
				loop
					l_row := local_assembly_list.item
					if not (l_row @ 2).is_empty then
						pref_string := new_id_sd (l_row @ 2, True)
					else
						pref_string := Void
					end
					create l_assembly_sd.initialize (new_id_sd (l_row @ 1, True),
						new_id_sd (l_row @ 3, True),
						pref_string,
						Void,
						Void,
						Void)
					al.extend (l_assembly_sd)
					local_assembly_list.forth
				end
					-- Store GAC references
				from
					gac_assembly_list.start
				until
					gac_assembly_list.after
				loop
					l_row := gac_assembly_list.item
					if not (l_row @ 2).is_empty then
						create pref_string.initialize (l_row @ 2)
					else
						pref_string := Void
					end
					create l_assembly_sd.initialize (new_id_sd (l_row @ 1, True),
						new_id_sd (l_row @ 3, True),
						pref_string,
						new_id_sd (l_row @ 4, True),
						new_id_sd (l_row @ 5, True),
						new_id_sd (l_row @ 6, True))
					al.extend (l_assembly_sd)
					gac_assembly_list.forth
				end
				root_ast.set_assemblies (al)
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
			al: LACE_LIST [ASSEMBLY_SD]
			assembly: ASSEMBLY_SD
			list_row: EV_MULTI_COLUMN_LIST_ROW
			l_defaults: LACE_LIST [D_OPTION_SD]
			l_free_opt: FREE_OPTION_SD
			l_removed: BOOLEAN
		do
			l_defaults := root_ast.defaults
			if l_defaults /= Void then
				from
					l_defaults.start
				until
					l_defaults.after
				loop
					l_free_opt ?= l_defaults.item.option
					if l_free_opt /= Void and then l_free_opt.code = {FREE_OPTION_SD}.metadata_cache_path then
						if l_defaults.item.value.is_name then
							md_cache_path.set_text (l_defaults.item.value.value)
							l_defaults.remove
							l_removed := True
						end
					end
					if not l_removed then
						l_defaults.forth
					end
					l_removed := False
				end
			end

			al ?= root_ast.assemblies
			if al /= Void then
				from
					al.start
				until
					al.after
				loop
					assembly := al.item
					if is_local_assembly (assembly) then
							-- Add local reference row
						create list_row
						list_row.extend (assembly.cluster_name.to_string_8)
						if (assembly.prefix_name /= Void and not assembly.prefix_name.is_empty) then
							list_row.extend (assembly.prefix_name.to_string_8)
						else
							list_row.extend ("")
						end
						list_row.extend (assembly.assembly_name.to_string_8)
						if assembly.public_key_token /= Void then
							list_row.extend (assembly.version.to_string_8)
							list_row.extend (assembly.culture.to_string_8)
							list_row.extend (assembly.public_key_token.to_string_8)
						end
						local_assembly_list.extend (list_row)
						local_assembly_list.resize_column_to_content (3)
					else
							-- Add GAC reference row
						create list_row
						list_row.extend (assembly.cluster_name.to_string_8)
						if (assembly.prefix_name /= Void and not assembly.prefix_name.is_empty) then
							list_row.extend (assembly.prefix_name.to_string_8)
						else
							list_row.extend ("")
						end
						list_row.extend (assembly.assembly_name.to_string_8)
						list_row.extend (assembly.version.to_string_8)
						list_row.extend (assembly.culture.to_string_8)
						list_row.extend (assembly.public_key_token.to_string_8)
						gac_assembly_list.extend (list_row)
						gac_assembly_list.resize_column_to_content (1)
						gac_assembly_list.resize_column_to_content (3)
						gac_assembly_list.resize_column_to_content (4)
					end
					al.forth
				end
				al.wipe_out
			end
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Actions

	add_local_assembly_reference is
			-- Open the browse dialog for adding of local assembly reference
		local
			fd: EB_FILE_OPEN_DIALOG
			l_dir: STRING
			list_row: EV_MULTI_COLUMN_LIST_ROW
			l_ass_path: STRING
			l_exec: EXECUTION_ENVIRONMENT
			l_error: EV_INFORMATION_DIALOG
			l_assembly_info: IL_ASSEMBLY_FACADE
			l_prefix: STRING
			l_has_error: BOOLEAN
		do
			create l_exec
			l_dir := l_exec.current_working_directory
			create fd.make_with_preference (preferences.dialog_data.last_opened_local_assembly_directory_preference)
			set_dialog_filters (fd, <<dll_files_filter, exe_files_filter, all_assemblies_filter>>)
			fd.set_title ("Select an assembly")
			fd.show_modal_to_window (system_window.window)
			l_exec.change_working_directory (l_dir)
				-- If it is empty, it means that user chose the `Cancel' button.
			if not fd.file_name.is_empty then
				l_ass_path := fd.file_name
				if
					(l_ass_path.substring_index (".dll", l_ass_path.count - 4) > 0)
					or (l_ass_path.substring_index (".exe", l_ass_path.count - 4) > 0)
				then
					create l_assembly_info.make
					if l_assembly_info.exists then
						l_assembly_info.get_assembly_info_from_assembly (l_ass_path)
						if l_assembly_info.is_valid then
							l_prefix := assembly_prefix (l_assembly_info.assembly_name)
						else
							l_has_error := True
						end
					else
						l_prefix := ""
					end
					if not l_has_error then
						create list_row
						list_row.extend (l_ass_path)
						list_row.extend (l_prefix)
						list_row.extend (l_ass_path)
						local_assembly_list.extend (list_row)
					end
				else
					l_has_error := True
				end
			end
			if l_has_error then
				create l_error.make_with_text ("Selected file is not an assembly and has not been added.")
				l_error.show_modal_to_window (system_window.window)
			end
		end

	remove_reference (is_gac_assembly: BOOLEAN) is
			-- Remove selected reference from list
		do
			if is_gac_assembly then
				gac_assembly_list.remove_selected_item
			else
				local_assembly_list.remove_selected_item
			end
		end

feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		require
			top_not_void: top /= Void
		local
			l_frame: EV_FRAME
			l_hbox: EV_HORIZONTAL_BOX
		do
			system_window := top
			tab_make
			default_create

			set_border_width (5)
			set_padding (3)

			create l_frame.make_with_text ("Eiffel Assembly Cache Options")
			create md_cache_path.make_with_text_and_parent ("Cache Path:", system_window.window)
			create l_hbox
			l_hbox.set_border_width (Layout_constants.Small_border_size)
			l_hbox.set_padding (Layout_constants.Small_padding_size)
			l_hbox.extend (md_cache_path)
			l_frame.extend (l_hbox)
			extend (l_frame)
			disable_item_expand (l_frame)

				-- As soon as we do a successful compilation we cannot
				-- change some options.
			widgets_set_before_has_compilation_started.extend (md_cache_path)

			extend (msil_assembly_info (True, Void, agent remove_reference (True)))
			extend (msil_assembly_info (False, agent add_local_assembly_reference, agent remove_reference (False)))

			msil_specific_widgets.extend (Current)
		end

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			gac_assembly_list.wipe_out
			local_assembly_list.wipe_out
		ensure then
			gac_assembly_list_empty: gac_assembly_list.is_empty
			local_assembly_list_empty: local_assembly_list.is_empty
		end

	msil_assembly_info (is_gac_assembly: BOOLEAN; add_proc, remove_proc: PROCEDURE [ANY, TUPLE]): EV_FRAME is
			-- MSIL information about assembly references
		local
			vbox, item_box: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			add_button, remove_button: EV_BUTTON
		do
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)

			if is_gac_assembly then
				create Result.make_with_text ("GAC Assembly References")
				create gac_assembly_list.make (system_window.window)
				gac_assembly_list.set_column_titles
					(<<"Cluster Name", "Prefix", "Name", "Version", "Culture", "Public Key">>)
				gac_assembly_list.disable_multiple_selection
				gac_assembly_list.set_column_editable (True, 1)
				gac_assembly_list.set_column_editable (True, 2)
				gac_assembly_list.set_unique_column_values (True)
				gac_assembly_list.deselect_actions.force_extend (agent check_cluster_names_valid)
				item_box.extend (gac_assembly_list)
			else
				create Result.make_with_text ("Assembly References")
				create local_assembly_list.make (system_window.window)
				local_assembly_list.set_column_titles
					(<<"Cluster Name", "Prefix", "Path">>)
				local_assembly_list.disable_multiple_selection
				local_assembly_list.set_column_editable (True, 1)
				local_assembly_list.set_column_editable (True, 2)
				local_assembly_list.set_unique_column_values (True)
				local_assembly_list.deselect_actions.force_extend (agent check_cluster_names_valid)
--				local_assembly_list.new_item_actions.extend
--					(local_assembly_list.set_column_width (local_assembly_list.resize_column_to_content (1)))
				item_box.extend (local_assembly_list)
			end

			if add_proc /= Void then
				create add_button.make_with_text_and_action ("Add", add_proc)
			end
			if remove_proc /= Void then
				create remove_button.make_with_text_and_action ("Remove", remove_proc)
			end
			vbox.extend (item_box)
			create hbox
			hbox.set_padding (Layout_constants.Tiny_padding_size)
			create cell
			hbox.extend (cell)
			if add_proc /= Void then
				add_button.set_minimum_width (80)
				hbox.extend (add_button)
				hbox.disable_item_expand (add_button)
			end
			if remove_proc /= Void then
				remove_button.set_minimum_width (80)
				hbox.extend (remove_button)
				hbox.disable_item_expand (remove_button)
			end
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)
			Result.extend (vbox)
		end

feature -- Implementation

	is_local_assembly (a_assembly: ASSEMBLY_SD): Boolean is
			-- Is `a_assembly' a local assembly?
		require
			a_assembly_not_void: a_assembly /= Void
		local
			l_file: RAW_FILE
			l_name: ID_SD
		do
			if
				(a_assembly.public_key_token /= Void and
				not a_assembly.public_key_token.is_empty)
			then
				l_name := a_assembly.assembly_name
				create l_file.make (l_name)
				if l_file.exists then
					if l_name.count >= 4 then
						if l_name.substring_index (".dll", l_name.count - 4) > 0 then
							Result := True
						elseif l_name.substring_index (".exe", l_name.count - 4) > 0 then
							Result := True
						end
					end
				else
					Result := False
				end
			else
				Result := True
			end
		end

	check_cluster_names_valid is
			-- Are the assembly cluster names valid?
		local
			names: ARRAYED_LIST [STRING]
			valid: BOOLEAN
			error_dialog: EV_INFORMATION_DIALOG
			name_error_message: STRING
		do
			names := cluster_names
			names.compare_objects
			name_error_message := " is an invalid assembly cluster name.%NPlease enter a new cluster name."
			from
				names.start
				valid := True
			until
				names.after or not valid
			loop
				if names.occurrences (names.item) > 1 then
					valid := False
				else
					names.forth
				end
			end
			if not valid then
				create error_dialog.make_with_text (names.item + name_error_message)
					error_dialog.show_modal_to_window (system_window.window)
				if gac_assembly_list.has_focus then
					gac_assembly_list.set_with_previous_text
				elseif local_assembly_list.has_focus then
					local_assembly_list.set_with_previous_text
				end
			end
		end

	assembly_prefix (a_name: STRING): STRING is
			-- Return the required prefix for the assembly with name 'a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			if a_name.is_equal ("System") then
				Result := "system_dll_"
			elseif a_name.is_equal ("System.Xml") then
				Result := "xml_"
			elseif a_name.is_equal ("System.Windows.Forms") then
				Result := "winforms_"
			else
				Result := ""
			end
		ensure
			result_not_void: Result /= Void
  		end

	cluster_names: ARRAYED_LIST [STRING] is
			-- Get the cluster names for referenced assemblies
		do
			create Result.make (gac_assembly_list.count + local_assembly_list.count)
			from
				gac_assembly_list.start
			until
				gac_assembly_list.after
			loop
				Result.extend (gac_assembly_list.item @ (1))
				gac_assembly_list.forth
			end
			from
				local_assembly_list.start
			until
				local_assembly_list.after
			loop
				Result.extend (local_assembly_list.item @ (1))
				local_assembly_list.forth
			end
		end

	reserved_words: ARRAYED_LIST [STRING] is
			-- List of Lace reserved words which cannot be used for cluster names
		once
			create Result.make (37)
			Result.compare_objects
			Result.extend ("adapt")
			Result.extend ("all")
			Result.extend ("as")
			Result.extend ("assembly")
			Result.extend ("assertion")
			Result.extend ("check")
			Result.extend ("cluster")
			Result.extend ("create")
			Result.extend ("creation")
			Result.extend ("debug")
			Result.extend ("disable_debug")
			Result.extend ("default")
			Result.extend ("end")
			Result.extend ("ensure")
			Result.extend ("exclude")
			Result.extend ("depend")
			Result.extend ("export")
			Result.extend ("external")
			Result.extend ("generate")
			Result.extend ("ignore")
			Result.extend ("include")
			Result.extend ("invariant")
			Result.extend ("library")
			Result.extend ("loop")
			Result.extend ("no")
			Result.extend ("optimize")
			Result.extend ("option")
			Result.extend ("precompiled")
			Result.extend ("prefix")
			Result.extend ("rename")
			Result.extend ("require")
			Result.extend ("root")
			Result.extend ("system")
			Result.extend ("trace")
			Result.extend ("use")
			Result.extend ("visible")
			Result.extend ("yes")
		end

invariant
	widgets_not_void:
		gac_assembly_list /= Void and
		local_assembly_list /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_SYSTEM_MSIL_ASSEMBLY_TAB

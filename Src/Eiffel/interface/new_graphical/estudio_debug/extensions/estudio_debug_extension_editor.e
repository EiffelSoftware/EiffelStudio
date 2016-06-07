note
	description: "Editor extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_EXTENSION_EDITOR

inherit
	ESTUDIO_DEBUG_EXTENSION
		redefine
			new_menu_item
		end

	SYSTEM_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Execution

	execute
		do
		end

	build_debug_sub_menu (a_menu: EV_MENU)
			-- Builds the debug submenu
		require
			not_a_menu_is_destroyed: not a_menu.is_destroyed
		local
			l_menu_item: EV_MENU_ITEM
		do
				--| Force compilation
			create l_menu_item.make_with_text_and_action ("Force Compilation", agent on_force_compile_class)
			a_menu.extend (l_menu_item)

				--| Force compilation
			create l_menu_item.make_with_text_and_action ("Force Compilation On All Open", agent on_force_compile_all_classes)
			a_menu.extend (l_menu_item)

				--| Save all classes though the editor in current project
			create l_menu_item.make_with_text_and_action ("Save All Classes In The Project Through The Editor", agent on_resave_all_classes)
			a_menu.extend (l_menu_item)
		end

feature {NONE} -- Actions

	on_force_compile_class
			-- Forces the active editor's class to be compiled.
		local
			l_error: ES_ERROR_PROMPT
		do
			if not eiffel_project.is_compiling then
					-- Do not process this whilst compiling
				if
					attached window_manager.last_focused_development_window as l_window and then
					l_window.is_interface_usable
				then
					if
						attached active_editor as l_editor and then
						attached {CLASSI_STONE} l_editor.stone as l_class
					then
							-- We have the class stone
						if attached l_class.class_i as l_class_i then
							if l_class_i.is_compiled then
								create l_error.make_standard ("The class " + l_class_i.name + " is already compiled!")
								l_error.show_on_active_window
							else
									-- Add the class
								l_class_i.system.add_unref_class (l_class_i)
							end
						end
					end
				end
			else
				create l_error.make_standard ("Unable to force compilation whilst compiling.")
				l_error.show_on_active_window
			end
		end

	on_force_compile_all_classes
			-- Forces the active editor's class to be compiled.
		local
			l_error: ES_ERROR_PROMPT
			l_classes: STRING
			l_nb: INTEGER
		do
			if not eiffel_project.is_compiling then
					-- Do not process this whilst compiling
				if attached window_manager.windows as l_windows then
					if attached {EB_DEVELOPMENT_WINDOW} l_windows.item as l_window and then l_window.is_interface_usable then
						if attached l_window.editors_manager.editors as l_editors then
							create l_classes.make (256)
							from l_editors.start until l_editors.after loop
								if
									attached l_editors.item as l_editor and then
									l_editor.is_interface_usable and then
									attached {CLASSI_STONE} l_editor.stone as l_class
								then
										-- We have the class stone
									if attached l_class.class_i as l_class_i then
										if l_class_i.is_compiled then
											l_classes.append_string_general (l_class_i.name)
											l_classes.append_character ('%N')
											l_nb := l_nb + 1
										else
												-- Add the class
											l_class_i.system.add_unref_class (l_class_i)
										end
									end
								end
								l_editors.forth
							end

							if not l_classes.is_empty then
								l_classes.prune_all_trailing ('%N')
								if l_classes.index_of ('%N', 1) > 0 then
									create l_error.make_standard ("The classes%N%N" + l_classes + "%N%Nare already compiled!")
								else
									create l_error.make_standard ("The class " + l_classes + " is already compiled!")
								end
								l_error.show_on_active_window
							end
						end
					end
				end
			else
				create l_error.make_standard ("Unable to force compilation whilst compiling.")
				l_error.show_on_active_window
			end
		end

	on_resave_all_classes
			-- Resave all classes in current project through the editor,
			-- excluding classes in libraries.
			-- This applies all automatic behaviors enabled though the preferences in the editor to classes.
			-- Trailing space removing, copyright info, for example.
		local
			l_window: detachable EB_DEVELOPMENT_WINDOW
			l_target: detachable CONF_TARGET
			l_clusters: STRING_TABLE [CONF_CLUSTER]
			l_classes_in_cluster: PROCEDURE [CONF_CLUSTER]
			l_stone: detachable STONE
		do
			l_window := window_manager.last_focused_development_window

			if l_window /= Void and then l_window.eiffel_project.initialized then
				l_stone := l_window.stone
				l_target := l_window.eiffel_universe.target
				check l_target_not_void: l_target /= Void end

				l_classes_in_cluster :=
				agent (a_cluster: detachable CONF_CLUSTER; a_window: EB_DEVELOPMENT_WINDOW)
					local
						l_classes: STRING_TABLE [CONF_CLASS]
						l_class_stone: CLASSI_STONE
						l_editor: EB_SMART_EDITOR
					do
						check a_cluster_not_void: a_cluster /= Void end
						l_classes := a_cluster.classes
						if l_classes /= Void then
							from
								l_classes.start
							until
								l_classes.after
							loop
								if attached {CLASS_I} l_classes.item_for_iteration as lt_class then
									create l_class_stone.make (lt_class)
									a_window.set_stone (l_class_stone)
									l_editor := a_window.editors_manager.current_editor
									if l_editor /= Void then
										l_editor.flush
										if l_editor.is_editable then
											l_editor.set_changed (True)
											a_window.save_cmd.execute
										end
									end
								end
								l_classes.forth
							end
						end
					end (?, l_window)

				l_clusters := l_target.clusters
				l_clusters.linear_representation.do_all (l_classes_in_cluster)
				l_clusters := l_target.overrides
				l_clusters.linear_representation.do_all (l_classes_in_cluster)
				if l_stone /= Void then
					l_window.set_stone (l_stone)
				end
			end
		end

feature {NONE} -- Query

	active_editor: detachable EB_SMART_EDITOR
			-- Attempts to locate the last active editor.
		do
			if attached window_manager.last_focused_development_window as l_window and then l_window.is_interface_usable then
				if attached l_window.editors_manager.current_editor as l_editor and then l_editor.is_interface_usable then
					Result := l_editor
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature -- Access

	menu_path: ARRAY [STRING]
		do
			Result := <<"Editor">>
		end

feature {NONE} -- Implementation

	new_menu_item (a_title: STRING): EV_MENU
		do
			Result := imp_new_menu_item (a_title)
			build_debug_sub_menu (Result)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

note
	description: "[
			Box containing the list of available iron package, 
			with name, location, repository and available extra informations.

			It also provides control on iron package such as
				- install
				- remove
				- update
			It indicates if there are any name conflicts, remember that order of repositories matters.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_COLLECTION_BOX

inherit
	EIFFEL_LAYOUT

	CONF_GUI_INTERFACE_CONSTANTS

	SHARED_BENCH_NAMES

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_target: like target)
		do
			target := a_target
			create box
			build_interface (box)
		end

	build_interface (b: EV_VERTICAL_BOX)
		local
			l_iron_layout: IRON_LAYOUT
			l_iron_url_builder: IRON_URL_BUILDER
			g: like packages_grid
			hsp: EV_VERTICAL_SPLIT_AREA
			vb: EV_VERTICAL_BOX;
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
			l_filter: like filter_text
		do
			create l_iron_layout.make_with_path (eiffel_layout.iron_path, eiffel_layout.installation_iron_path)
			create l_iron_url_builder
			create installation_api.make_with_layout (l_iron_layout, l_iron_url_builder)

				-- toolbar/filter/..
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.set_border_width (layout_constants.small_border_size)

			b.extend (hb)
			b.disable_item_expand (hb)
			hb.extend (create {EV_LABEL}.make_with_text ("Packages"))
			hb.extend (create {EV_CELL})

			hb.extend (create {EV_LABEL}.make_with_text (Names.l_filter))
			hb.disable_item_expand (hb.last)
			create l_filter
			filter_text := l_filter
			hb.extend (l_filter)
			l_filter.change_actions.extend (agent request_update_filter)

			create but
			but.select_actions.extend (agent l_filter.remove_text)
			but.set_pixmap (conf_pixmaps.general_remove_icon)
			but.set_tooltip (names.b_reset)
			hb.extend (but)
			hb.disable_item_expand (but)

				-- Split area
			create hsp
			b.extend (hsp)

			create g
			hsp.set_first (g)
			packages_grid := g
			g.set_column_count_to (4)
			g.column (1).set_title ("Package")
			g.column (2).set_title ("Location")
			g.column (3).set_title ("Repository")
			g.column (4).set_title ("Information")
			create on_iron_package_selected_actions
			g.enable_single_row_selection
			g.pointer_double_press_item_actions.extend (agent on_grid_double_pressed)
			g.row_select_actions.extend (agent on_single_row_selected)
			g.row_deselect_actions.extend (agent on_single_row_deselected)
			g.set_row_count_to (1)
			g.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("waiting for data ..."))

			create vb
			hsp.set_second (vb)

			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.set_border_width (layout_constants.small_border_size)

			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_LABEL}.make_with_text ("Package Information"))
			hb.extend (create {EV_CELL})

			create but.make_with_text ("Install")
			but.set_minimum_size (layout_constants.default_button_width, layout_constants.default_button_height)
			but.select_actions.extend (agent install_selected_package)
			but.disable_sensitive
			install_button := but
			hb.extend (but)

			create but.make_with_text ("Remove")
			but.set_minimum_size (layout_constants.default_button_width, layout_constants.default_button_height)
			but.select_actions.extend (agent remove_selected_package)
			but.disable_sensitive
			remove_button := but
			hb.extend (but)

			create but.make_with_text ("Update")
			but.set_minimum_size (layout_constants.default_button_width, layout_constants.default_button_height)
			but.select_actions.extend (agent update_iron)
			update_button := but
			hb.extend (but)

			create info_box
			vb.extend (info_box)
			info_box.set_minimum_height (50)

			b.resize_actions.extend_kamikaze (agent (s: EV_SPLIT_AREA; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER)
					do
						s.set_split_position (s.height - 50)
					end (hsp, ?,?,?,?))

			b.focus_in_actions.extend_kamikaze (agent populate)
		end

	installation_api: IRON_INSTALLATION_API

	target: CONF_TARGET
			-- Associated target.

feature -- Callback	

	package_from_row (a_row: EV_GRID_ROW): detachable IRON_PACKAGE
		do
			if
				attached {IRON_PACKAGE} a_row.data as p
			then
				Result := p
			end
		end

	on_single_row_deselected (a_row: EV_GRID_ROW)
		do
			on_iron_package_selected (Void)
		end

	on_single_row_selected (a_row: EV_GRID_ROW)
		do
			on_iron_package_selected (package_from_row (a_row))
		end

	on_iron_package_selected (p: detachable IRON_PACKAGE)
		local
			lst: ARRAYED_LIST [STRING_32]
			l_inst_path: PATH
			txt: like info_box
		do
			txt := info_box
			txt.remove_text
			if p = Void then
				install_button.disable_sensitive
				remove_button.disable_sensitive
			else
				txt.append_text ("Package ")
				txt.append_text (p.human_identifier)
				txt.append_text ("%N")
				if attached p.description as desc and then not desc.is_empty then
					txt.append_text (desc)
					txt.append_text ("%N")
					txt.append_text ("%N")
				end
				if attached p.tags as p_tags and then not p_tags.is_empty then
					txt.append_text ("Tags:")
					across
						p_tags as ic
					loop
						txt.append_text (" ")
						txt.append_text (ic.item)
					end
					txt.append_text ("%N")
				end

				if installation_api.is_package_installed (p) then
					install_button.disable_sensitive
					remove_button.enable_sensitive

					if attached installation_api.projects_from_installed_package (p) as l_projects then
						l_inst_path := installation_api.package_installation_path (p)
						txt.append_text ("Installed in folder %"")
						txt.append_text (l_inst_path.name)
						txt.append_text ("%"%N")
						txt.append_text ("Associated ecf files:%N")
						create lst.make (l_projects.count)
						across
							l_projects as ic
						loop
							txt.append_text (" - ")
							txt.append_text (l_inst_path.extended_path (ic.item).name)
							txt.append_text ("%N")
						end
					end
				else
					install_button.enable_sensitive
					remove_button.disable_sensitive

					txt.append_text ("To install:%N")
					txt.append_text (" - use the UI%N")
					if installation_api.conflicting_available_package (p) /= Void then
						txt.append_text (" - or command: %"iron install ")
						txt.append_text (p.location.string)
						txt.append_text ("%"%N")
					else
						txt.append_text (" - or command: %"iron install ")
						txt.append_text (p.identifier)
						txt.append_text ("%"%N")
					end
				end
			end
			on_iron_package_selected_actions.call ([p])
		end

	on_iron_package_selected_actions: ACTION_SEQUENCE [TUPLE [package: detachable IRON_PACKAGE]]
			-- Actions to be triggered when a package is selected.

feature {NONE} -- Update filter

	update_filter_timeout: detachable EV_TIMEOUT

	request_update_filter
		local
			l_update_filter_timeout: like update_filter_timeout
		do
			cancel_delayed_update_filter
			l_update_filter_timeout := update_filter_timeout
			if l_update_filter_timeout = Void then
				create l_update_filter_timeout
				update_filter_timeout := l_update_filter_timeout
				l_update_filter_timeout.actions.extend_kamikaze (agent delayed_update_filter)
			end
			l_update_filter_timeout.set_interval (700)
		end

	cancel_delayed_update_filter
		do
			if attached update_filter_timeout as l_update_filter_timeout then
				l_update_filter_timeout.destroy
				update_filter_timeout := Void
			end
		end

	delayed_update_filter
		do
			cancel_delayed_update_filter
			update_filter
		end

	update_filter
		local
			l_style: EV_POINTER_STYLE
		do
			l_style := widget.pointer_style
			widget.set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

			update

			widget.set_pointer_style (l_style)
		end

	filter_matcher: detachable KMP_WILD
		local
			l_filter: STRING_32
		do
				-- And filter if pattern specified
			l_filter := filter_text.text
			if l_filter /= Void then
				l_filter.left_adjust
				l_filter.right_adjust
				if l_filter.is_empty then
					l_filter := Void
				end
			end
			if l_filter /= Void then
				if l_filter.item (1) /= '*' then
					l_filter.prepend_character ('*')
				end
				if l_filter.item (l_filter.count) /= '*' then
					l_filter.append_character ('*')
				end
				create Result.make_empty
				Result.set_pattern (l_filter)
				Result.disable_case_sensitive
			end
		end

feature -- Basic operations

	is_populated: BOOLEAN

	reload
		do
			is_populated := False
			populate
		end

	update
		local
			i,n: INTEGER
			g: like packages_grid
			f: like filter_matcher
			l_row: EV_GRID_ROW
		do
			if is_populated then
				f := filter_matcher
				from
					g := packages_grid
					i := 1
					n := g.row_count
				until
					i > n
				loop
					l_row := g.row (i)
					if f = Void then
						l_row.show
					else
						if attached package_from_row (l_row) as p then
							f.set_text (p.identifier)
							if f.pattern_matches then
								l_row.show
							else
								l_row.hide
							end
						else
							l_row.show
						end
					end
					i := i + 1
				end
			else
				populate
			end
		end

	populate
		local
			api: like installation_api
			i: INTEGER
			l_package: IRON_PACKAGE
			l_names: STRING_TABLE [IRON_PACKAGE]
			g: EV_GRID
			f: like filter_matcher
			l_row: EV_GRID_ROW
		do
			if is_populated then
					-- Already populated.
			else
				g := packages_grid
				g.clear

				api := installation_api

				if attached api.available_packages as l_packages then
					g.set_row_count_to (g.row_count + l_packages.count)
					create l_names.make_caseless (l_packages.count)
					f := filter_matcher
					across l_packages as ic loop
						l_package := ic.item
						i := i + 1
						l_row := g.row (i)
						l_row.set_data (l_package)
						if attached l_names.item (l_package.identifier) as l_conflicting_package then
							build_row (l_row, l_conflicting_package) -- Conflicting
						else
							l_names.put (l_package, l_package.identifier)
							build_row (l_row, Void)
						end
						if f = Void then
							l_row.show
						else
							f.set_text (l_package.identifier)
							if f.pattern_matches then
								l_row.show
							else
								l_row.hide
							end
						end
					end
				end
				if g.column_count > 1 then
					g.column (2).resize_to_content
				end
				is_populated := True
			end
		end

	clear_row (a_row: EV_GRID_ROW)
		require
			a_row_exists: not a_row.is_destroyed
		do
			a_row.clear
		end

	refresh_row_associated_with_package (p: IRON_PACKAGE)
		local
			i,n: INTEGER
			g: like packages_grid
		do
			from
				g := packages_grid
				i := 1
				n := g.row_count
			until
				i > n
			loop
				if
					attached package_from_row (g.row (i)) as l_package and then
					p.is_same_package (l_package)
				then
					clear_row (g.row (i))
					build_row (g.row (i), installation_api.conflicting_available_package (l_package))
				end
				i := i + 1
			end
		end

	build_row (a_row: EV_GRID_ROW; in_conflict_with: detachable IRON_PACKAGE)
		require
			a_row_exists: not a_row.is_destroyed
			coherent_data: attached {IRON_PACKAGE} a_row.data
		local
			api: like installation_api
			glab: EV_GRID_LABEL_ITEM
			s,t: STRING_32
			g: EV_GRID
			i: INTEGER
			is_installed: BOOLEAN
		do
			api := installation_api
			i := a_row.index
			g := a_row.parent
			if attached {IRON_PACKAGE} a_row.data as l_package then
				clear_row (a_row)

				create glab.make_with_text (l_package.identifier)
				g.set_item (1, i, glab)
				g.row (i).set_data (l_package)

				is_installed := installation_api.is_package_installed (l_package)

				if attached l_package.description as desc and then not desc.is_empty then
					glab.set_tooltip (desc)
				end

				if is_installed then
					if attached api.package_installation_path (l_package) as p then
						create glab.make_with_text (p.name)
					else
						create glab
					end
					if in_conflict_with /= Void then
						glab.set_pixmap (conf_pixmaps.general_warning_icon)
					else
						glab.set_pixmap (conf_pixmaps.general_tick_icon)
					end
				else
					if in_conflict_with /= Void then
						create glab.make_with_text ({STRING_32} "Conflicting with " + in_conflict_with.location.string)
						glab.set_pixmap (conf_pixmaps.general_warning_icon)
					else
						create glab.make_with_text ("double-click to install " + l_package.location.string)
						glab.set_pixmap (conf_pixmaps.general_add_icon)
					end
				end
				glab.set_data (l_package)
				g.set_item (2, i, glab)


				create glab.make_with_text (l_package.repository.location_string)
				g.set_item (3, i, glab)

				create s.make_empty
				if attached l_package.tags as l_tags and then not l_tags.is_empty then
					s.append ("tags:")
					create t.make_empty
					across
						l_tags as tags_ic
					loop
						if not t.is_empty then
							t.append_character (',')
						end
						t.append (tags_ic.item)
					end
					s.append (t)
					s.append_character (' ')
				end

				if s.is_empty then
					create glab
				else
					create glab.make_with_text (s)
				end
				g.set_item (4, i, glab)
			else
				clear_row (a_row)

				a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Error: missing package"))
			end
		end

feature {NONE} -- Callbacks

	on_grid_double_pressed (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_grid_item: EV_GRID_ITEM)
		local
			l_id: READABLE_STRING_32
		do
			if
				a_button = {EV_POINTER_CONSTANTS}.left and then
				not a_grid_item.is_destroyed and then
				a_grid_item.has_parent and then
				attached {IRON_PACKAGE} a_grid_item.data as l_package
			then
				if installation_api.is_package_installed (l_package) then
						-- already installed
				else
					if attached installation_api.conflicting_available_package (l_package) as l_conflicting_package then
						l_id := l_package.location.string
					else
						l_id := l_package.identifier
					end
						-- Let's install this package
					launch_iron_installation (l_id, agent (ia_item: EV_GRID_ITEM; ia_package: READABLE_STRING_GENERAL; ia_succeed: BOOLEAN)
						do
							if
								not ia_item.is_destroyed and then
								attached ia_item.parent as g and then
								not g.is_destroyed
							then
								installation_api.refresh_installed_packages
								if
									attached {IRON_PACKAGE} ia_item.data as ot_package and then
									installation_api.is_package_installed (ot_package)
								then
									check ia_package.same_string (ot_package.identifier) end
									g.row (ia_item.row.index).set_data (ot_package)
									build_row (g.row (ia_item.row.index), Void)
								end
							end
						end(a_grid_item, l_id, ?)
					)
				end
			end
		end

feature -- Actions

	selected_package: detachable IRON_PACKAGE
		do
			if attached packages_grid.selected_rows as lst then
				if lst.count = 1 then
					Result := package_from_row (lst.first)
				end
			end
		end

	install_selected_package
		local
			l_id: READABLE_STRING_32
		do
			installation_api.refresh
			if
				attached selected_package as p and then
				not installation_api.is_package_installed (p)
			then
				if installation_api.conflicting_available_package (p) /= Void then
					l_id := p.location.string
				else
					l_id := p.identifier
				end
				launch_iron_command ({STRING_32} "iron install " + l_id, <<{STRING_32} "install", {STRING_32} "--batch", l_id>>, agent (ia_p: IRON_PACKAGE; ia_succeed: BOOLEAN)
					do
						installation_api.refresh
						refresh_row_associated_with_package (ia_p)
					end(p, ?))
			end
		end

	remove_selected_package
		local
			l_id: READABLE_STRING_32
		do
			installation_api.refresh
			if
				attached selected_package as p and then
				installation_api.is_package_installed (p)
			then
				if installation_api.conflicting_available_package (p) /= Void then
					l_id := p.location.string
				else
					l_id := p.identifier
				end
				launch_iron_command ({STRING_32} "iron remove " + l_id, <<{STRING_32} "remove", {STRING_32} "--batch", l_id>>, agent (ia_p: IRON_PACKAGE; ia_succeed: BOOLEAN)
					do
						installation_api.refresh
						refresh_row_associated_with_package (ia_p)
					end(p, ?))
			end
		end

	update_iron
			-- Install iron package `a_package' and call associated callback `cb'.
		do
			launch_iron_command ({STRING_32} "iron update", <<{STRING_32} "update", {STRING_32} "--batch">>, agent (ia_succeed: BOOLEAN)
				do
					installation_api.refresh
					if ia_succeed then
						reload
					end
				end)
		end

	launch_iron_installation (a_package: READABLE_STRING_GENERAL; cb: detachable PROCEDURE [ANY, TUPLE [succeed: BOOLEAN]])
			-- Install iron package `a_package' and call associated callback `cb'.
		do
			launch_iron_command ({STRING_32} "Installation of iron package: " + a_package.to_string_32, <<"install", "--batch", a_package>>, cb)
		end

	launch_iron_command (a_title: READABLE_STRING_32; a_args: ITERABLE [READABLE_STRING_GENERAL]; cb: detachable PROCEDURE [ANY, TUPLE [succeed: BOOLEAN]])
			-- Execute externally iron command with argument `args' and call associated callback `cb'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_dialog: IRON_OUTPUT_DIALOG
			l_done_handler: ROUTINE [ANY, TUPLE]
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			create args.make (3)
			across
				a_args as ic
			loop
				args.force (ic.item)
			end
			create l_prc_factory
			l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.iron_command_name.name, args, Void)
			l_prc_launcher.set_separate_console (False)
			l_prc_launcher.set_hidden (True)
			create l_dialog
			l_dialog.set_process (l_prc_launcher)
			l_dialog.set_title (a_title)
			l_prc_launcher.redirect_input_to_stream
			l_prc_launcher.redirect_output_to_agent (agent l_dialog.append_in_gui_thread)
			l_prc_launcher.redirect_error_to_same_as_output

			l_done_handler := agent  (ia_dlg: IRON_OUTPUT_DIALOG; ia_prc_launcher: PROCESS)
					do
						if ia_prc_launcher.exit_code = 0 then
							ia_dlg.close_in_gui_thread
						else
								-- error occured!
						end
					end(l_dialog, l_prc_launcher)

			l_prc_launcher.set_on_exit_handler (l_done_handler)
			l_prc_launcher.set_on_terminate_handler (l_done_handler)
			l_prc_launcher.set_on_fail_launch_handler (l_done_handler)
			l_prc_launcher.launch
			if l_prc_launcher.launched then
				if attached parent_window_of (widget) as win then
					l_dialog.show_modal_to_window (win)
				else
					l_dialog.show
				end
				if cb /= Void then
					cb.call ([l_prc_launcher.exit_code = 0])
				end
			end
		end

feature -- Access

	parent_window_of (w: EV_WIDGET): EV_WINDOW
			-- Parent for all dialogs shown.
		do
			if attached w.parent as p then
				if attached {EV_WINDOW} p as win then
					Result := win
				else
					Result := parent_window_of (p)
				end
			end
		end

feature -- Access

	widget: EV_WIDGET
		do
			Result := box
		end

	filter_text: EV_TEXT_FIELD

	install_button: EV_BUTTON

	remove_button: EV_BUTTON

	update_button: EV_BUTTON

feature -- Widgets		

	box: EV_VERTICAL_BOX

	packages_grid: ES_GRID

	info_box: EV_RICH_TEXT

feature -- Events	

	hide
		do
			widget.hide
		end

	show
		do
			widget.show
		end

	set_focus
		do
			if packages_grid.is_show_requested then
				packages_grid.set_focus
			end
		end

invariant

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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

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
	CONF_GUI_INTERFACE_CONSTANTS

	SHARED_BENCH_NAMES

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_iron_service: ES_IRON_SERVICE)
		do
			iron_service := a_iron_service
			create box
			build_interface (box)
		end

	build_interface (b: EV_VERTICAL_BOX)
		local
			g: like packages_grid
			lst: like repositories_grid
			hsp: EV_VERTICAL_SPLIT_AREA
			vb: EV_VERTICAL_BOX;
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
			l_filter: like filter_text
		do
				-- Create attached attributes.
			create info_widget.make (iron_service)
			create packages_grid
			create update_button
			create on_iron_package_selected_actions
			create on_iron_packages_changed_actions

				-- Repositories
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.set_border_width (layout_constants.small_border_size)

			b.extend (hb)
			b.disable_item_expand (hb)
			hb.extend (create {EV_LABEL}.make_with_text (conf_interface_names.iron_box_repositories_label))
			hb.disable_item_expand (hb.last)
			hb.extend (create {EV_CELL})

			create lst
			b.extend (lst)
			repositories_grid := lst
			lst.set_column_count_to (1)
			lst.enable_single_row_selection
			lst.set_row_count_to (0)
			b.disable_item_expand (lst)
			lst.hide_header

				-- toolbar/filter/..
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.set_border_width (layout_constants.small_border_size)

			b.extend (hb)
			b.disable_item_expand (hb)
			hb.extend (create {EV_LABEL}.make_with_text (conf_interface_names.iron_box_packages_label))
			hb.disable_item_expand (hb.last)
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

				-- First part of the split area
			g := packages_grid
			create vb
			vb.set_border_width (3)
			vb.extend (g)
			hsp.set_first (vb)
			g.set_column_count_to (4)
			g.column (1).set_title (conf_interface_names.iron_box_package_label)
			g.column (2).set_title (conf_interface_names.iron_box_installation_label)
			g.column (3).set_title (conf_interface_names.iron_box_location_label)
			g.column (4).set_title (conf_interface_names.iron_box_information_label)
			g.enable_single_row_selection
			g.row_select_actions.extend (agent on_single_row_selected)
			g.row_deselect_actions.extend (agent on_single_row_deselected)
			g.set_row_count_to (1)
			g.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text (conf_interface_names.iron_box_package_waiting_for_data_message))

				-- Second part of the split area.
			create vb
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.set_border_width (layout_constants.small_border_size)

			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_LABEL}.make_with_text (conf_interface_names.iron_box_package_status_label))
			hb.disable_item_expand (hb.last)
			hb.extend (create {EV_CELL})

			but := update_button
			but.set_text (conf_interface_names.iron_box_update_label)
			layout_constants.set_default_size_for_button (but)
			but.select_actions.extend (agent update_iron)
			hb.extend (but)

--			create info_widget.make (iron_service)
			info_widget.on_install_actions.extend (agent install_selected_package)
			info_widget.on_uninstall_actions.extend (agent remove_selected_package)
			vb.extend (info_widget.widget)

			hsp.set_second (vb) -- Set the second part of the split area.
			hsp.disable_item_expand (vb)
			hsp.set_split_position (hsp.height - vb.minimum_height)

			b.focus_in_actions.extend_kamikaze (agent populate)
		end

	iron_service: ES_IRON_SERVICE

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
		do
			info_widget.set_package (p)
			on_iron_package_selected_actions.call ([p])
		end

	on_iron_package_selected_actions: ACTION_SEQUENCE [TUPLE [package: detachable IRON_PACKAGE]]
			-- Actions to be triggered when a package is selected.

	on_iron_packages_changed_actions: ACTION_SEQUENCE [TUPLE [package: detachable IRON_PACKAGE]]
			-- Actions to be triggered when there is a change in iron data,
			-- if `package' is attached, the change is related to that package.
			--| trigger: when a package is installed, or removed, and when update is executed.

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
			widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

			update

			widget.set_pointer_style (l_style)
		end

	filter_string: detachable STRING_32
		do
			Result := filter_text.text
			if Result /= Void then
				Result.left_adjust
				Result.right_adjust
				if Result.is_empty then
					Result := Void
				end
			end
			if Result /= Void then
				if Result.item (1) /= '*' then
					Result.prepend_character ('*')
				end
				if Result.item (Result.count) /= '*' then
					Result.append_character ('*')
				end
			end
		end

	filter_matcher: detachable KMP_WILD
		do
				-- And filter if pattern specified
			if attached filter_string as l_filter then
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
		do
			reload
		end

	populate
		local
			api: IRON_INSTALLATION_API
			i: INTEGER
			l_package: IRON_PACKAGE
			l_names: STRING_TABLE [IRON_PACKAGE]
			g: like packages_grid
			repos: like repositories_grid
			l_row: EV_GRID_ROW
		do
			if is_populated then
					-- Already populated.
			else
				repos := repositories_grid
				repos.clear

				api := iron_service.installation_api
				if attached api.repositories as l_repositories then
					repos.set_row_count_to (l_repositories.count)
					i := 0
					across
						api.repositories as ic
					loop
						i := i + 1
						repos.set_item (1, i, create {EV_GRID_LABEL_ITEM}.make_with_text (ic.location_string))
					end
				end
				repos.set_minimum_height (i.min (5).max (1) *  repos.row_height)

				g := packages_grid
				g.clear

				if attached scored_available_packages as l_packages then
					g.set_row_count_to (g.row_count + l_packages.count)
					create l_names.make_caseless (l_packages.count)
					i := 0
					across l_packages as ic loop
						l_package := ic.value
						i := i + 1
						l_row := g.row (i)
						l_row.set_data (l_package)
						if attached l_names.item (l_package.identifier) as l_conflicting_package then
							build_row (l_row, l_conflicting_package) -- Conflicting
						else
							l_names.put (l_package, l_package.identifier)
							build_row (l_row, Void)
						end
						if ic.score_is_zero then
							l_row.hide
						else
							l_row.show
						end
					end
				end
				if g.column_count >= 2 then
					g.column (2).resize_to_content
					if g.column_count >= 3 then
						g.column (3).resize_to_content
					end
				end
				is_populated := True
			end
		end

	scored_available_packages: LIST [SCORED_VALUE [IRON_PACKAGE]]
		local
			lst: LIST [IRON_PACKAGE]
			prov: ES_LIBRARY_IRON_PACKAGE_PROVIDER
		do
			create prov.make (iron_service)
			lst := iron_service.installation_api.available_packages
			if attached filter_string as f then
				Result := prov.scorer.sorted_scored_list (f, lst, True)
			else
				create {ARRAYED_LIST [SCORED_VALUE [IRON_PACKAGE]]} Result.make (lst.count)
				across
					lst as ic
				loop
					Result.force (create {SCORED_VALUE [IRON_PACKAGE]}.make (ic, 1.0))
				end
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
			l_api: IRON_INSTALLATION_API
		do
			l_api := iron_service.installation_api
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
					build_row (g.row (i), l_api.conflicting_available_package (l_package))
				end
				i := i + 1
			end
		end

	build_row (a_row: EV_GRID_ROW; in_conflict_with: detachable IRON_PACKAGE)
		require
			a_row_exists: not a_row.is_destroyed
			coherent_data: attached {IRON_PACKAGE} a_row.data
		local
			api: IRON_INSTALLATION_API
			glab: EV_GRID_LABEL_ITEM
			s,t: STRING_32
			i: INTEGER
			is_installed: BOOLEAN
		do
			api := iron_service.installation_api
			i := a_row.index
			if attached {IRON_PACKAGE} a_row.data as l_package then
				clear_row (a_row)

					-- Package identifier
				create glab.make_with_text (l_package.identifier)
				a_row.set_item (1, glab)
				a_row.set_data (l_package)

				is_installed := api.is_package_installed (l_package)

				if attached l_package.description as desc and then not desc.is_empty then
					glab.set_tooltip (desc)
				end

					-- Installation info
				if is_installed then
					if attached api.package_installation_path (l_package) as p then
						create glab.make_with_text ({STRING_32} "Installed in " + p.name)
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
						create glab.make_with_text (conf_interface_names.iron_box_conflicting_with_package_message (in_conflict_with.location.string))
						glab.set_pixmap (conf_pixmaps.general_warning_icon)
					else
						create glab.make_with_text (conf_interface_names.iron_box_how_to_install_selected_package_message)
						glab.set_pixmap (conf_pixmaps.general_add_icon)
					end
				end
				glab.set_data (l_package)
				a_row.set_item (2, glab)

					-- Location
				create glab.make_with_text (l_package.location.string)
				a_row.set_item (3, glab)

					-- Information
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
						t.append (tags_ic)
					end
					s.append (t)
					s.append_character (' ')
				end

				if s.is_empty then
					create glab
				else
					create glab.make_with_text (s)
				end
				a_row.set_item (4, glab)
			else
				clear_row (a_row)

				a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (conf_interface_names.iron_box_missing_package_error_message))
			end
		end

feature -- Iron package management

	install_package (p: IRON_PACKAGE; cb: detachable PROCEDURE [TUPLE [succeed: BOOLEAN]])
		do
			iron_service.install_package (p, cb)
		end

	uninstall_package (p: IRON_PACKAGE; cb: detachable PROCEDURE [TUPLE [succeed: BOOLEAN]])
		do
			iron_service.uninstall_package (p, cb)
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

	install_selected_package (p: IRON_PACKAGE)
		do
			install_package (p,
					agent (ia_p: IRON_PACKAGE; ia_succeed: BOOLEAN)
								do
									iron_service.installation_api.refresh_installed_packages
									refresh_row_associated_with_package (ia_p)
									on_iron_packages_changed_actions.call ([ia_p])
								end(p, ?)
				)
		end

	remove_selected_package (p: IRON_PACKAGE)
		do
			uninstall_package (p,
					agent (ia_p: IRON_PACKAGE; ia_succeed: BOOLEAN)
								do
									iron_service.installation_api.refresh_installed_packages
									refresh_row_associated_with_package (ia_p)
									on_iron_packages_changed_actions.call ([ia_p])
								end(p, ?)
				)
		end

	update_iron
			-- Install iron package `a_package' and call associated callback `cb'.
		do
			iron_service.update_iron (
						agent (ia_succeed: BOOLEAN)
							do
								iron_service.installation_api.refresh
								if ia_succeed then
									reload
								end
								on_iron_packages_changed_actions.call ([Void])
							end
				)
		end

feature -- Access

	parent_window_of (w: EV_WIDGET): detachable EV_WINDOW
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

	update_button: EV_BUTTON

feature -- Widgets		

	box: EV_VERTICAL_BOX

	packages_grid: ES_GRID

	repositories_grid: ES_GRID

	info_widget: IRON_PACKAGE_WIDGET

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

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

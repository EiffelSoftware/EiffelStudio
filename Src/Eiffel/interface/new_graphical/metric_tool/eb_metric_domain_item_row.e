indexing
	description: "A row used in scope selector"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DOMAIN_ITEM_ROW

inherit
	EB_GRID_ROW

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY

	EB_SHARED_ID_SOLUTION

	EB_METRIC_INTERFACE_PROVIDER

	EB_SHARED_WRITER

create
	make

feature{NONE} -- Initialization

	make (a_domain_item: EB_METRIC_DOMAIN_ITEM) is
			-- Initialize `domain_item' with `a_domain_item'.
		require
			a_domain_item_attached: a_domain_item /= Void
		local
			l_conf_class: CONF_CLASS
			l_feature: E_FEATURE
			l_group: CONF_GROUP
			l_folder: EB_FOLDER
			l_classi: CLASS_I
		do
			domain_item := a_domain_item
			if is_valid then
				if domain_item.is_class_item then
					l_conf_class := class_of_id (domain_item.id)
					l_classi ?= l_conf_class
					check
						l_classi /= Void
					end
					if l_classi.compiled_representation /= Void then
						create {CLASSC_STONE} class_stone.make (l_classi.compiled_representation)
					else
						create class_stone.make (l_classi)
					end
					index := 5
				elseif domain_item.is_feature_item then
					l_feature := feature_of_id (domain_item.id)
					create feature_stone.make (l_feature)
					index := 6
				elseif domain_item.is_group_item then
					l_group := group_of_id (domain_item.id)
					create cluster_stone.make (l_group)
					if l_group.is_assembly then
						index := 4
					elseif l_group.is_library then
						index := 3
					else
						index := 2
					end
				elseif domain_item.is_folder_item then
					l_folder := folder_of_id (domain_item.id)
					create cluster_stone.make_subfolder (l_folder.cluster, l_folder.path, folder_name (l_folder.path))
					index := 2
				elseif domain_item.is_target_item then
					index := 1
					if a_domain_item.id.is_empty then
						create target_stone.make (universe.target)
					else
						create target_stone.make (target_of_id (a_domain_item.id))
					end
				end
			end
		ensure
			domain_item_set: domain_item = a_domain_item
		end

feature -- Status report

	is_cluster_scope: BOOLEAN is
			-- Is current row a cluster scope?
		do
			Result := domain_item.is_group_item
		end

	is_class_scope: BOOLEAN is
			-- Is current row a class scope?
		do
			Result := domain_item.is_class_item
		end

	is_feature_scope: BOOLEAN is
			-- Is current row a feature scope?
		do
			Result := domain_item.is_feature_item
		end

	is_subfolder: BOOLEAN is
			-- Is current row a subfolder scope?
		do
			Result := domain_item.is_folder_item
		end

	is_target: BOOLEAN is
			-- Is current row a target row?
		do
			Result := domain_item.is_target_item
		end

	is_delayed: BOOLEAN is
			-- Is current row a delayed item row?
		do
			Result := domain_item.is_delayed_item
		end

	is_valid: BOOLEAN is
			-- Is `domain_item' valid?
		do
			Result := domain_item.is_valid
		end

feature -- Access

	domain_item: EB_METRIC_DOMAIN_ITEM
			-- Domain item in current row

	stone: STONE is
			-- Stone of current row
		do
			if is_valid then
				if is_target then
					Result := target_stone
				elseif is_class_scope then
					Result := class_stone
				elseif is_feature_scope then
					Result := feature_stone
				elseif is_subfolder or is_cluster_scope then
					Result := cluster_stone
				end
			end
		ensure
			result_attached: is_valid implies Result /= Void
		end

	cluster_stone: CLUSTER_STONE
			-- Cluster stone

	class_stone: CLASSI_STONE
			-- Class stone

	feature_stone: FEATURE_STONE
			-- Feature stone

	target_stone: TARGET_STONE
			-- Target stone

	name: STRING is
			-- Name of current row
		do
			Result := domain_item.string_representation
		ensure
			result_attached: Result /= Void
		end

	token_name: LIST [EDITOR_TOKEN] is
			-- Editor token representation of current domain item
		local
			l_domain_item: like domain_item
			l_writer: like token_writer
			l_item: QL_ITEM
		do
			l_writer := token_writer
			l_writer.new_line
			l_domain_item := domain_item
			if l_domain_item.is_valid then
				if l_domain_item.is_delayed_item then
					l_writer.add_string (l_domain_item.string_representation)
				else
					l_item := l_domain_item.query_language_item
					if l_item /= Void then
						add_editor_token_representation (l_item, False, True, l_writer)
					else
						l_writer.add_string (l_domain_item.string_representation)
					end
				end
			else
				l_writer.add_error (create{SYNTAX_ERROR}.init, l_domain_item.string_representation)
			end
			Result := l_writer.last_line.content
		ensure
			result_attached: Result /= Void
		end

	index: INTEGER
			-- Index used in sorting

	pixmap: EV_PIXMAP is
			-- Pixmap for current stone
		do
			if is_valid then
				if is_cluster_scope then
					Result := pixmap_from_group (cluster_stone.group)
				elseif is_subfolder then
					Result := pixmap_from_group_path (cluster_stone.group, subfolder_path)
				elseif is_class_scope then
					Result := pixmap_from_class_i (class_stone.class_i)
				elseif is_feature_scope then
					Result := pixmap_from_e_feature (feature_stone.e_feature)
				elseif is_target then
					Result := pixmaps.icon_pixmaps.metric_unit_target_icon
				elseif is_delayed then
					Result := pixmaps.icon_pixmaps.metric_domain_delayed_icon
				end
			else
				if is_cluster_scope then
					Result := pixmaps.icon_pixmaps.folder_cluster_icon
				elseif is_subfolder then
					Result := pixmaps.icon_pixmaps.folder_cluster_icon
				elseif is_class_scope then
					Result := pixmaps.icon_pixmaps.class_normal_icon
				elseif is_feature_scope then
					Result := pixmaps.icon_pixmaps.feature_routine_icon
				elseif is_target then
					Result := pixmaps.icon_pixmaps.metric_unit_target_icon
				elseif is_delayed then
					Result := pixmaps.icon_pixmaps.metric_domain_delayed_icon
				end
			end
		ensure
			result_attached: Result /= Void
		end

	tooltip: STRING is
			-- Tooltip of current scope
			-- Only return non Void value when `is_subfolder' is True
		do
			if not is_valid then
				Result := metric_names.f_domain_item_invalid
			else
				if is_subfolder then
					Result := cluster_stone.group.name + subfolder_path
				elseif is_feature_scope then
					Result := interface_names.l_version_in + " " + feature_stone.e_feature.associated_class.name
				end
			end
		end

	pebble: ANY is
			-- Pebble for current stone
		do
			Result := stone
		ensure
			result_attached: Result /= Void
		end

	pebble_cursor: EV_CURSOR is
			-- Cursor for current stone used as a pebble
		do
			if is_cluster_scope or is_subfolder then
				Result := cursors.cur_cluster
			elseif is_class_scope then
				Result := cursors.cur_class
			elseif is_feature_scope then
				Result := cursors.cur_feature
			end
		ensure
			result_attached: Result /= Void
		end

	pebble_x_cursor: EV_CURSOR is
			-- Veto cursor for current stone used as a pebble
		do
			if is_cluster_scope or is_subfolder then
				Result := cursors.cur_x_cluster
			elseif is_class_scope then
				Result := cursors.cur_x_class
			elseif is_feature_scope then
				Result := cursors.cur_x_feature
			end
		ensure
			result_attached: Result /= Void
		end

	text_color: EV_COLOR is
			-- Text color for current row
		do
			if not is_valid then
				Result := (create{EV_STOCK_COLORS}).red
			else
				if is_cluster_scope or is_subfolder then
					Result := (create{EDITOR_TOKEN_CLUSTER}.make ("")).text_color
				elseif is_class_scope then
					Result := (create{EDITOR_TOKEN_CLASS}.make ("")).text_color
				elseif is_feature_scope then
					Result := (create{EDITOR_TOKEN_FEATURE}.make ("")).text_color
				else
					Result := (create{EV_STOCK_COLORS}).black
				end
			end
		ensure
			result_attached: Result /= Void
		end

	subfolder_path: STRING is
			-- Subfolder path of current `cluster_stone'
		require
			is_subfolder: is_subfolder
		do
			Result := cluster_stone.path
		end

feature -- Grid binding

	bind_grid (a_grid: EV_GRID) is
			-- Bind current row in `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		local
			l_grid_row: EV_GRID_ROW
			l_tooltip: STRING
			l_editor_token_item: EB_GRID_EDITOR_TOKEN_ITEM
		do
			create l_editor_token_item
			l_editor_token_item.set_pixmap (pixmap)
			l_editor_token_item.set_spacing (3)
			l_editor_token_item.set_text_with_tokens (token_name)
			l_editor_token_item.set_data (Current)
			l_editor_token_item.set_overriden_fonts (label_font_table)
			a_grid.insert_new_row (a_grid.row_count + 1)
			l_grid_row := a_grid.row (a_grid.row_count)
			l_tooltip := tooltip
			if tooltip /= Void then
				l_editor_token_item.set_tooltip (l_tooltip)
			end
			l_grid_row.set_item (1, l_editor_token_item)
			set_grid_row (l_grid_row)
		end

feature{NONE} -- Implementation

	folder_name (a_path: STRING): STRING is
			-- Last folder name from `a_path'
		require
			a_path_attached: a_path /= Void
		local
			l_index: INTEGER
		do
			l_index := a_path.last_index_of ('/', a_path.count)
			if l_index = 0 then
				Result := a_path
			else
				Result := a_path.substring (l_index + 1, a_path.count)
			end
		ensure
			result_attached: Result /= Void
		end

invariant
	domain_item_attached: domain_item /= Void
	name_attached: name /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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


end

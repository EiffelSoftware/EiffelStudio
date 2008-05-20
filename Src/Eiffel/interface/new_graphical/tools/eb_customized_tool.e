indexing
	description: "Customized tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL

inherit
	ES_FORMATTER_TOOL_PANEL_BASE
		rename
			make as old_make
		redefine
			is_customized_tool,
			title,
			title_for_pre,
			pixmap,
			pixel_buffer
		end

create
	make

feature{NONE} -- Initialization

	make (a_develop_window: like develop_window; a_title: like title; a_id: like id; a_pixmap_location: like pixmap_location; a_handlers: like stone_handlers) is
			-- Initialize.
		require
			a_develop_window_attached: a_develop_window /= Void
			a_title_valid: a_title /= Void
			a_id_attached: a_id /= Void
			a_pixmap_location_attached: a_pixmap_location /= Void
			a_handlers_attached: a_handlers /= Void
		do
			develop_window := a_develop_window
			set_id (a_id)
			set_title (a_title)
			set_pixmap_location (a_pixmap_location)
			set_stone_handlers (a_handlers)
			build_interface
		end

feature -- Access

	id: STRING
			-- ID of current tool

	title_for_pre: STRING is
			-- Title of the tool
		do
			Result := id
		ensure then
			good_result: Result = id
		end

	title: STRING_GENERAL is
			-- Title of the tool which for show, it maybe not in English.
		do
			Result := title_internal
		ensure then
			good_result: Result = title_internal
		end

	predefined_formatters: like formatters is
			-- Predefined formatters
			-- An empty list will be returned as customized tool doesn't have and predefined formatters.
		do
			create {LINKED_LIST [EB_FORMATTER]} Result.make
		ensure then
			good_result: Result.is_empty
		end

	no_target_message: STRING_GENERAL is
			-- Message to be displayed in `output_line' when no stone is set
		do
			Result := interface_names.l_no_info_of_element
		end

	stone: STONE is
			-- Stone representing Current
		do
			Result := last_stone
		end

	pixmap_location: STRING
			-- Location of icon file for Currnet tool

	pixmap: EV_PIXMAP is
			-- Pixmap as it appears in toolbars and menu, there is no pixmap by default.
		do
			if (not is_pixmap_loaded) or else pixmap_internal = Void  then
				load_pixmap
			end
			Result := pixmap_internal
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer as it appears in toolbars and menu, there is no pixmap by default.
		do
			if (not is_pixmap_loaded) or else pixmap_internal = Void  then
				load_pixmap
			end
			Result := pixel_buffer_internal
		end

	stone_handlers: HASH_TABLE [STRING, STRING]
			-- Stone handlers [tool_id, stone_name]

feature -- Status report

	is_customized_tool: BOOLEAN is
			-- Is Current tool a customized tool?
		do
			Result := True
		end

	is_pixmap_loaded: BOOLEAN
			-- Has pixmap specified by `pixmap_location' been loaded?

feature -- Setting

	pop_default_formatter is
			-- Popup default formatter specified by `default_formatter'.
		do

		end

	suitable_tool_for_stone (a_stone: like stone): STRING is
			-- ID of tool which is suitable for `a_stone' defined by handlers of Current tool
			-- Void if no suitable stone is found.
		local
			l_testers: like stone_testers
			l_cursor: CURSOR
			l_stone_name: STRING
		do
				-- Decide what kind of stone is `a_stone'.
			l_testers := stone_testers
			l_cursor := l_testers.cursor
			from
				l_testers.start
			until
				l_testers.after or l_stone_name /= Void
			loop
				if l_testers.item.a_tester.item ([a_stone]) then
					l_stone_name := l_testers.item.a_stone_name
				end
				l_testers.forth
			end
			l_testers.go_to (l_cursor)

			if l_stone_name /= Void then
				Result := stone_handlers.item (l_stone_name)
			end
		end

	drop_stone (st: like stone) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		local
			l_tool_id: STRING
			l_tool: EB_STONABLE_TOOL
		do
			l_tool_id := suitable_tool_for_stone (st)
			if l_tool_id /= Void then
				l_tool ?= develop_window.tools.customizable_tool_by_id (l_tool_id)
				if l_tool /= Void then
					l_tool.show_with_setting
				end
			end

			if develop_window.unified_stone then
				develop_window.set_stone (st)
			elseif develop_window.link_tools then
				develop_window.tools.set_stone (st)
			else
				if l_tool /= Void then
					l_tool.set_stone (st)
				end
			end
		end

	set_stone (new_stone: STONE) is
			-- Send a stone to class formatters.
		local
			l_stone: like stone
		do
			l_stone ?= new_stone
			if l_stone = Void or else stone = Void or else not stone.same_as (l_stone) then
					-- Set the stones.
				set_last_stone (l_stone)
				develop_window.tools.set_last_stone (last_stone)
			end
			
			if widget.is_displayed or else is_auto_hide or else develop_window.link_tools then
				force_last_stone
			end
		end

	set_id (a_id: like id) is
			-- Set `id' with `a_id'.
		require
			a_id_attached: a_id /= Void
		do
			create id.make_from_string (a_id)
		ensure
			id_set: id /= Void and then id.is_equal (a_id)
		end

	set_pixmap_location (a_location: like pixmap_location) is
			-- Set `pixmap_location' with `a_location'.
		require
			a_location_attached: a_location /= Void
		do
			create pixmap_location.make_from_string (a_location)
			set_is_pixmap_loaded (False)
		ensure
			pixmap_location_set: pixmap_location /= Void and then pixmap_location.is_equal (a_location)
		end

	set_title (a_title: like title) is
			-- Set `title' with `a_title'.
		require
			a_title_valid: a_title /= Void
		do
			if a_title.is_empty then
				title_internal := default_title
			else
				title_internal := a_title
			end
		ensure
			title_internal_set: (a_title.is_empty implies title_internal = default_title) and then (not a_title.is_empty implies title_internal = a_title)
		end

	set_is_pixmap_loaded (b: BOOLEAN) is
			-- Set `is_pixmap_loaded' with `b'.
		do
			is_pixmap_loaded := b
		ensure
			is_pixmap_loaded_set: is_pixmap_loaded = b
		end

	set_stone_handlers (a_handlers: like stone_handlers) is
			-- Set `stone_handlers' with `a_handlers'.
		require
			a_handlers_attached: a_handlers /= Void
		do
			stone_handlers := a_handlers.twin
		end

feature{NONE} -- Implementation/Data

	title_internal: like title
			-- Implementation of `title'

	default_title: STRING is "Unnamed tool"
			-- Default tool title

	pixmap_internal: like pixmap
			-- Implementation of `pixmap'

	pixel_buffer_internal: like pixel_buffer
			-- Implementation of `pixel_buffer'

feature{NONE} -- Implementation

	load_pixmap is
			-- Load pixmap.
		local
			l_pixmap_loader: EB_PIXMAP_LOAD_HELPER
			l_result: TUPLE [a_pixmap: EV_PIXMAP; a_buffer: EV_PIXEL_BUFFER]
		do
			create l_pixmap_loader
			l_result := l_pixmap_loader.loaded_pixmap_from_file (pixmap_location, pixmaps.icon_pixmaps.diagram_export_to_png_icon, pixmaps.icon_pixmaps.diagram_export_to_png_icon_buffer)
			pixmap_internal := l_result.a_pixmap
			pixmap_internal.stretch (16, 16)
			pixel_buffer_internal := l_result.a_buffer
			set_is_pixmap_loaded (True)
		ensure
			pixmap_internal_attached: pixmap_internal /= Void
			pixel_buffer_attached: pixel_buffer_internal /= Void
		end

feature{NONE} -- Stone handler matching

	stone_names: EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS is
			-- Name for stone
		do
			if stone_names_internal = Void then
				create stone_names_internal
			end
			Result := stone_names_internal
		ensure
			result_attached: Result /= Void
		end

	stone_testers: LINKED_LIST [TUPLE [a_stone_name: STRING; a_tester: FUNCTION [ANY, TUPLE [STONE], BOOLEAN]]] is
			-- List of stone testers.
			-- `a_stone_name' is the name of the stone,
			-- `a_tester' is a predicate with a stone as argument and evaluates to True if the stone is of certain type.
			-- Note: More specific stone testers should appear before more general stone testers in current list,
			-- for example, tester for feature stones should be before tester for class stones.
		do
			if stone_testers_internal = Void then
				create stone_testers_internal.make

				stone_testers_internal.extend ([stone_names.n_feature_stone, agent is_feature_stone])
				stone_testers_internal.extend ([stone_names.n_compiled_class_stone, agent is_compiled_class_stone])
				stone_testers_internal.extend ([stone_names.n_uncompiled_class_stone, agent is_uncompiled_class_stone])
				stone_testers_internal.extend ([stone_names.n_group_stone, agent is_group_stone])
				stone_testers_internal.extend ([stone_names.n_target_stone, agent is_target_stone])
			end
			Result := stone_testers_internal
		ensure
			result_attached: Result /= Void
		end

	stone_testers_internal: like stone_testers
			-- Implementation of `stone_testers'

	stone_names_internal: like stone_names
			-- Implementation of `stone_names'

feature{NONE} -- Stone testers

	is_feature_stone (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' a feature stone?
		local
			l_stone: FEATURE_STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void
		end

	is_uncompiled_class_stone (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' a uncompiled class stone?
		local
			l_stone: CLASSI_STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void
		end

	is_compiled_class_stone (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' a compiled class stone?
		local
			l_stone: CLASSC_STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void
		end

	is_group_stone (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' a group stone?
		local
			l_stone: CLUSTER_STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void
		end

	is_target_stone (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' a target stone?
		local
			l_stone: TARGET_STONE
		do
			l_stone ?= a_stone
			Result := l_stone /= Void
		end

invariant
	id_attached: id /= Void

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


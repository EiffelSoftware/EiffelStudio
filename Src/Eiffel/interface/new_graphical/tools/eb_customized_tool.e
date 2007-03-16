indexing
	description: "Customized tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL

inherit
	EB_FORMATTER_BASED_TOOL
		rename
			make as old_make
		redefine
			is_customized_tool,
			pixmap,
			pixel_buffer
		end

create
	make

feature{NONE} -- Initialization

	make (a_develop_window: like develop_window; a_title: like title; a_id: like id; a_pixmap_location: like pixmap_location) is
			-- Initialize.
		require
			a_develop_window_attached: a_develop_window /= Void
			a_title_valid: a_title /= Void and then not a_title.is_empty
			a_id_attached: a_id /= Void
			a_pixmap_location_attached: a_pixmap_location /= Void
		do
			set_id (a_id)
			set_title (a_title)
			set_pixmap_location (a_pixmap_location)
			develop_window := a_develop_window
			build_interface
		end


	make_with_tool (a_tool: EB_DEVELOPMENT_WINDOW) is
			-- Initialize `development_window' with `a_too'.
		do
			initialize
			fill_in
			on_select
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
			Result := ""
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

	drop_stone (st: like stone) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		do
			develop_window.tools.set_stone (st)
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
			end
			if widget.is_displayed or else is_auto_hide then
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
			a_title_valid: a_title /= Void and then not a_title.is_empty
		do
			title_internal := a_title
		ensure
			title_internal_set: title_internal = a_title
			title_set: title = a_title
		end

	set_is_pixmap_loaded (b: BOOLEAN) is
			-- Set `is_pixmap_loaded' with `b'.
		do
			is_pixmap_loaded := b
		ensure
			is_pixmap_loaded_set: is_pixmap_loaded = b
		end

feature{NONE} -- Implementation/Data

	title_internal: like title
			-- Implementation of `title'

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

invariant
	id_attached: id /= Void

end

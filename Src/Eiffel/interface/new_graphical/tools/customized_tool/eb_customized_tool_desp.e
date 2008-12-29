note
	description: "Descriptor containing definition information for customized tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_TOOL_DESP

inherit
	HASHABLE

create
	make

feature{NONE} -- Initialization

	make (a_name: like name; a_id: like id)
			-- Initialize `name' with `a_name' and `id' with `a_id'.
		require
			a_name_attached: a_name /= Void
			a_id_attached: a_id /= Void
			a_id_valid: not a_id.is_empty
		do
			set_name (a_name)
			set_id (a_id)
			set_pixmap_location ("")
			create handlers.make (2)
		end

feature -- Access

	name: STRING_GENERAL
			-- Name of current tool

	id: STRING
			-- Id of current tool

	pixmap_location: STRING
			-- Location of the icon file for current tool

	handlers: HASH_TABLE [STRING, STRING]
			-- Table of handlers in form of [tool_id, stone_name]
			-- This means that if a stone is dropped in Current tool,
			-- we popup that tool specified by `tool_id' instead of handle the stone in current tool.

	new_tool (a_develop_window: EB_DEVELOPMENT_WINDOW): EB_CUSTOMIZED_TOOL
			-- New customized tool based upon information from Current descriptor
		require
			a_develop_window_attached: a_develop_window /= Void
		do
			create Result.make (a_develop_window, name.as_string_32, id, pixmap_location, handlers)
		ensure
			result_attached: Result /= Void
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code value
		do
			Result := id.hash_code
		end

feature -- Setting

	set_name (a_name: like name)
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			name := a_name.twin
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

	set_id (a_id: like id)
			-- Set `id' with `a_id'.
		require
			a_id_attached: a_id /= Void
			a_id_valid: not a_id.is_empty
		do
			id := a_id.twin
		ensure
			id_set: id /= Void and then id.is_equal (a_id)
		end

	set_pixmap_location (a_pixmap_location: like pixmap_location)
			-- Set `pixmap_location' with `a_pixmap_location'.
		require
			a_pixmap_location_attached: a_pixmap_location /= Void
		do
			pixmap_location := a_pixmap_location.twin
		end

	extend_handler (a_tool_id: like id; a_stone_name: STRING)
			-- Extend (`a_tool_id', `a_stone_name') pair into `handlers'.
		require
			a_tool_id_attached: a_tool_id /= Void
			a_stone_name_attached: a_stone_name /= Void
		do
			handlers.force (a_tool_id, a_stone_name)
		end

invariant
	name_valid: name /= Void
	id_valid: id /= Void and then not id.is_empty
	pixmap_location_attached: pixmap_location /= Void
	handlers_attached: handlers /= Void

end

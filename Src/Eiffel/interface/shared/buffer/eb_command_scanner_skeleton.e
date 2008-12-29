note
	description: "Scanner skeleton for external command placeholder such as $file_name"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMMAND_SCANNER_SKELETON

inherit
	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as old_make
		end

feature{NONE} -- Initialization

	make (a_factory: like factory; a_buffer: YY_BUFFER)
			-- Initialize `factory' with `a_factory'.
		require
			a_factory_attached: a_factory /= Void
		do
			set_factory (a_factory)
			make_with_buffer (a_buffer)
		ensure
			factory_set: factory = a_factory
		end

feature -- Access

	factory: EB_TEXT_FRAGMENT_FACTORY
			-- Factory to create data structures representing tokens

	text_fragments: LIST [EB_TEXT_FRAGMENT]
			-- Text fragments retrieved by scanning
		do
			if text_fragments_internal = Void then
				create {LINKED_LIST [EB_TEXT_FRAGMENT]} text_fragments_internal.make
			end
			Result := text_fragments_internal
		ensure
			result_attached: Result /= Void
		end

	last_text_fragment: EB_TEXT_FRAGMENT
			-- Last scanned text fragment

feature -- Setting

	set_factory (a_factory: like factory)
			-- Set `factory' with `a_factory'.
		require
			a_factory_attached: a_factory /= Void
		do
			factory := a_factory
		ensure
			factory_set: factory = a_factory
		end

	register_text_fragment (a_text_fragment: EB_TEXT_FRAGMENT)
			-- Register `a_text_fragment' into `text_fragments'.
		require
			a_text_fragment_attached: a_text_fragment /= Void
		do
			text_fragments.extend (a_text_fragment)
		ensure
			text_fragment_registered: (text_fragments.count = old text_fragments.count + 1) and then text_fragments.last = a_text_fragment
		end

	wipe_text_fragments
			-- Wipe out `text_fragments'.
		do
			text_fragments.wipe_out
		ensure
			text_fragments_wiped: text_fragments.is_empty
		end

feature -- Constants

	T_FILE_NAME: INTEGER = 1
	T_CLASS_NAME: INTEGER = 2
	T_DIRECTORY_NAME: INTEGER = 3
	T_W_CODE: INTEGER = 4
	T_F_CODE: INTEGER = 5
	T_GROUP_DIRECTORY: INTEGER = 6
	T_LINE: INTEGER = 7

	T_CLASS_BUFFER: INTEGER = 8
	T_CLASS_BUFFER_SELECTED: INTEGER = 9
	T_FEATURE_BUFFER: INTEGER = 10
	T_TOOL_BUFFER: INTEGER = 11
	T_TOOL_BUFFER_SELECTED: INTEGER = 12
	T_PROJECT_DIRECTORY: INTEGER = 13
	T_TARGET_DIRECTORY: INTEGER = 14
	T_FILE: INTEGER = 15
	T_PATH: INTEGER = 16
	T_TARGET_NAME: INTEGER = 17
	T_GROUP_NAME: INTEGER = 18
	T_UNRECOGNIZED: INTEGER = 100

feature{NONE} -- Implementation

	text_fragments_internal: like text_fragments
			-- Implementation of `text_fragments'

	set_last_text_fragment (a_text_fragment: like last_text_fragment)
			-- Set `last_text_fragment' with `a_text_fragment'.
		do
			last_text_fragment := a_text_fragment
		ensure
			last_text_fragment_set: last_text_fragment = a_text_fragment
		end

invariant
	factory_attached: factory /= Void

end

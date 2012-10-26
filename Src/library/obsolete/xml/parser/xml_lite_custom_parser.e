note
	description : "[
			Stoppable XML parser with settings
				- carriage_return_character_ignored
				- entity_mapping

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
		]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_LITE_CUSTOM_PARSER

inherit
	XML_LITE_STOPPABLE_PARSER
		redefine
			make,
			resolve_entity,
			internal_read_character
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Instanciate Current
		do
			Precursor
			initialize_entity_mapping
			carriage_return_character_ignored := True
		end

	initialize_entity_mapping
			-- Initialize entity mapping with predefined values
			--| cf: http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
		local
			map: like entity_mapping
		do
			create map.make (5)
				-- entities in XML
			map.force ('"',  "quot")  -- 34
			map.force ('&',  "amp")   -- 38
			map.force ('%'', "apos")  -- 39
			map.force ('<',  "lt")    -- 60
			map.force ('>',  "gt")    -- 62

			entity_mapping := map
		end

feature -- Settings

	carriage_return_character_ignored: BOOLEAN
			-- Ignore "carriage return" character CR  '%R' characters
			-- occurring with dos format with CR+LF as end of line.
			-- By default: True

	entity_mapping: HASH_TABLE [CHARACTER, STRING]
			-- Entities mapping
			-- You can provide your own extended mapping with `set_entity_mapping'
			--| such as &amp; &gt; &lt; &quot; ...

feature -- Settings change

	set_carriage_return_ignored (b: BOOLEAN)
			-- Set `carriage_return_character_ignored' to `b'
		do
			carriage_return_character_ignored := b
		end

feature {NONE} -- Implementation

	resolve_entity (s: STRING)
			-- Resolve `s' as an entity
		do
			if entity_mapping.has_key (s) then
				s.wipe_out
				s.append_character (entity_mapping.found_item)
			else
				s.prepend_character ('&')
				s.append_character (';')
			end
		end

feature {NONE} -- Query

	internal_read_character (buf: like buffer): CHARACTER
		do
			buf.read_character
			Result := buf.last_character
			if carriage_return_character_ignored and Result = '%R' then
				from
				until
					Result /= '%R' or buf.end_of_input
				loop
					buf.read_character
					Result := buf.last_character
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

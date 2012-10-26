note
	description : "[
			Stoppable XML parser with custom settings
				- carriage_return_character_ignored
				- entity_mapping
		]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CUSTOM_PARSER

inherit
	XML_STOPPABLE_PARSER
		redefine
			make,
			resolved_entity,
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

	entity_mapping: HASH_TABLE [CHARACTER_32, STRING]
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

	resolved_entity (s: STRING_8): STRING_32
			-- Resolve `s' as an entity
		do
			if entity_mapping.has_key (s) then
				create Result.make (1)
				Result.append_character (entity_mapping.found_item)
			else
				create Result.make (s.count + 2)
				Result.append_character ('&')
				Result.append_string_general (s)
				Result.append_character (';')
			end
		end

feature {NONE} -- Query

	internal_read_character (buf: like buffer): like last_character
		local
			c: NATURAL_32
			cr_code: NATURAL_32
		do
			buf.read_character_code
			if carriage_return_character_ignored then
				c := buf.last_character_code
				cr_code := ('%R').natural_32_code
				if c = cr_code then
					from
					until
						c /= cr_code or buf.end_of_input
					loop
						buf.read_character_code
						c := buf.last_character_code
					end
				end
			end
			Result := c.to_character_32
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

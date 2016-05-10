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
			internal_next_character
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
			map.force ('"',  {STRING_32} "quot")  -- 34
			map.force ('&',  {STRING_32} "amp")   -- 38
			map.force ('%'', {STRING_32} "apos")  -- 39
			map.force ('<',  {STRING_32} "lt")    -- 60
			map.force ('>',  {STRING_32} "gt")    -- 62

			entity_mapping := map
		end

feature -- Settings

	carriage_return_character_ignored: BOOLEAN
			-- Ignore "carriage return" character CR  '%R' characters
			-- occurring with dos format with CR+LF as end of line.
			-- By default: True

	entity_mapping: HASH_TABLE [CHARACTER_32, STRING_32]
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

	resolved_entity (s: READABLE_STRING_32): STRING_32
			-- Resolve `s' as an entity
		do
			if entity_mapping.has_key (s.to_string_32) then
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

	internal_next_character (buf: like buffer): like last_character
			-- <Precursor>
		local
			c: NATURAL_32
			cr_code: NATURAL_32
		do
			buf.read_character_code
			if buf.end_of_input then
				end_of_input := True
				c := 0 -- '%U'
			elseif carriage_return_character_ignored then
				c := buf.last_character_code
				cr_code := carriage_return_character_code
				if c = cr_code then
					from
					until
						buf.end_of_input or c /= cr_code
					loop
						buf.read_character_code
						c := buf.last_character_code
					end
					if buf.end_of_input then
						end_of_input := buf.end_of_input
						c := 0 -- '%U'
					end
				end
			end
			Result := c.to_character_32
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

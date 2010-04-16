note
	description : "[
			Simple XML parser with settings
				- carriage_return_character_ignored
				- error_ignored
				- entity_mapping
				- allow to stop the parser

			It does not perform any strict verification, and does not handle the encoding.
			This is really a simple xml parser which might answer basic XML parsing.
		]"
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CUSTOM_PARSER

inherit
	XML_PARSER
		redefine
			make, reset, report_error,
			resolve_entity,
			next_character,
			set_checkpoint_position, unset_checkpoint_position, checkpoint_position
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

	error_ignored: BOOLEAN
			-- Ignore error?
			-- If True, do not stop parser on error (no guarantee)
			-- Default: False			

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

	set_error_ignored (b: BOOLEAN)
			-- Set `error_ignored' to `b'
		do
			error_ignored := b
		end

feature -- Status change

	request_stop
			-- Request the parser to stop
		do
			stop_requested := True
			parsing_stopped := True
		end

feature -- Parsing status

	stop_requested: BOOLEAN
			-- Requested to stop parsing

feature -- Element change

	reset
			-- Reset parser states
		do
			Precursor
			stop_requested := False
		ensure then
			stop_requested_unset: not stop_requested
		end

feature {NONE} -- Implementation

	checkpoint_position: detachable XML_POSITION
		do
			if checkpoint_position_line > 0 then
				create Result.make (buffer.name, checkpoint_position_byte_index, checkpoint_position_column, checkpoint_position_line)
			end
		end

	checkpoint_position_line: like line
	checkpoint_position_column: like column
	checkpoint_position_byte_index: like byte_index

	set_checkpoint_position
		do
			checkpoint_position_line := line
			checkpoint_position_column := column
			checkpoint_position_byte_index := byte_index
		end

	unset_checkpoint_position
		do
			checkpoint_position_line := 0
			checkpoint_position_column := 0
			checkpoint_position_byte_index := 0
		end

feature {NONE} -- Implementation: parse

	report_error (a_message: STRING)
			-- Report error with message `a_message'
		do
			Precursor (a_message)
			parsing_stopped := not error_ignored
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

	next_character: CHARACTER
			-- Return next character
			-- move index
		local
			buf: like buffer
		do
			buf := buffer
			if not buf.end_of_input then
				buf.read_character
				Result := buf.last_character
				if carriage_return_character_ignored and Result = '%R' then
					from
					until
						Result /= '%R'
					loop
						buf.read_character
						Result := buf.last_character
					end
				end
			else
				report_error ("no more character")
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

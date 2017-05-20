note
	description: "Streams that parse textual representation of values from a string."
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: source, index, from_string, is_separator

class
	V_STRING_INPUT [G]

inherit
	V_INPUT_STREAM [G]
		redefine
			copy,
			is_equal
		end

	V_DEFAULT [G]
		redefine
			copy,
			is_equal
		end

create
	make,
	make_with_separators

feature {NONE} -- Initialization

	make (src: STRING; fs: FUNCTION [STRING, G])
			-- Create a stream that reads from `src' and uses function `fs' to convert from string to `G'.
			-- (Use function `default_is_separator' to recognize separator characters).
		require
			fs_one_argument: fs.open_count = 1
		do
			source := src.twin
			from_string := fs
			is_separator := agent default_is_separator
			start
		ensure
			source_effect: source ~ src
			index_effect: index = index_satisfying_from (source, agent non_separator, 1)
			--- from_string_effect: from_string = fs
			--- is_separator_effect: is_separator = agent default_is_separator
		end

	make_with_separators (src: STRING; fs: FUNCTION [STRING, G]; is_sep: PREDICATE [CHARACTER])
			-- Create a stream that reads from `src', uses function `fs' to convert from string to `G'
			-- and function `is_sep' to recognize separator characters.
		require
			fs_one_argument: fs.open_count = 1
			is_sep_one_argument: is_sep.open_count = 1
			--- is_sep_is_total: is_sep.precondition |=| True
		do
			source := src.twin
			from_string := fs
			is_separator := is_sep
			start
		ensure
			source_effect: source ~ src
			index_effect: index = index_satisfying_from (source, agent non_separator, 1)
			--- from_string_effect: from_string = fs
			--- is_separator_effect: is_separator = is_sep			
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `source' and position as in `other'.
		note
			modify: source, index, from_string, is_separator
		do
			source := other.source.twin
			from_string := other.from_string
			is_separator := other.is_separator
			index := other.index
			item_ := other.item_
			next := other.next
		ensure then
			source_effect: source ~ other.source
			index_effect: index = other.index
			--- from_string_effect: from_string = other.from_string
			--- is_separator_effect: is_separator = other.is_separator
		end

feature -- Access

	item: G
			-- Current token.
		do
			if attached item_ as i then
				Result := i
			else
				Result := default_value
			end
		end

	source: STRING
			-- Source string remained to be read.

	index: INTEGER
			-- Position of the first character of current token in `source'.

	from_string: FUNCTION [STRING, G]
			-- Function that converts a string into a value of type `G'.			

	is_separator: PREDICATE [CHARACTER]
			-- Function that recognizes separator characters
			-- (characters to be skipped in `source').

	default_is_separator (c: CHARACTER): BOOLEAN
			-- Is `c' space or punctuation character?
		do
			Result := c.is_space
		ensure
			definition: Result = c.is_space
		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		do
			Result := not source.valid_index (index)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' read from an equal string at the same position?
		do
			if other = Current then
				Result := True
			else
				Result := source ~ other.source and index = other.index
				-- ToDo: compare is_separator and from_string
			end
		end

feature -- Cursor movement

	start
			-- Read the first token.
		note
			modify: index
		do
			next := 1
			skip_separators
			if source.valid_index (next) then
				parse_value
				skip_separators
			else
				index := source.count + 1
			end
		ensure then
			index_effect: index = index_satisfying_from (source, agent non_separator, 1)
		end

	forth
			-- Read the next token.
		note
			modify: index
		do
			if source.valid_index (next) then
				parse_value
				skip_separators
			else
				index := source.count + 1
			end
		ensure then
			index_effect: index = index_satisfying_from (source, agent non_separator, index_satisfying_from (source, is_separator, old index))
		end

feature {V_STRING_INPUT} -- Implementation

	item_: detachable G
			-- Current token.

	next: INTEGER
			-- Position of the first character of next token in `source'.

feature {NONE} -- Implementation

	skip_separators
			-- Move to the next character not in `separators'.
		do
			from
			until
				next > source.count or else not is_separator.item ([source [next]])
			loop
				next := next + 1
			end
		end

	parse_value
			-- Parse value at current position and move to the next separator.
		require
			index_in_bounds: source.valid_index (next)
		local
			s: STRING
			i: INTEGER
		do
			from
				i := next
			until
				next > source.count or else is_separator.item ([source [next]])
			loop
				next := next + 1
			end
			s := source.substring (i, next - 1)
			if not from_string.precondition ([s]) then
				index := source.count + 1
			else
				item_ := from_string.item ([s])
				index := i
			end
		end

feature -- Specification

	index_satisfying_from (s: STRING; p: PREDICATE [CHARACTER]; i: INTEGER): INTEGER
			-- Index of the first character of `s' that satisfies `p' starting from position `i';
			-- out of range, if `p' is never satisfied.	
		do
			from
				Result := i
			until
				Result > s.count or else p.item ([s [Result]])
			loop
				Result := Result + 1
			end
		end

	non_separator (c: CHARACTER): BOOLEAN
			-- Is `c' not a separator?
		do
			Result := not is_separator.item ([c])
		ensure
			Result = not is_separator.item ([c])
		end

invariant
	box_definition_empty: not source.valid_index (index) implies box.is_empty
	box_constraint_non_empty: source.valid_index (index) implies box.count = 1 and
		box.any_item ~ from_string.item ([source.substring (index, index_satisfying_from (source, is_separator, index) - 1)])
	--- is_separator_is_total: is_separator.precondition |=| True
	item_definition: not box.is_empty implies item = box.any_item
end

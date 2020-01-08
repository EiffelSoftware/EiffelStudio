note

	description:

		"Equivalence classes of integer symbols; some of them %
		%possibly belonging to none of the equivalence classes"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2019, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_SYMBOL_PARTITIONS

inherit

	LX_EQUIVALENCE_CLASSES
		redefine
			make,
			initialize,
			put,
			add
		end

create

	make

feature {NONE} -- Initialization

	make (min, max: INTEGER)
			-- Make structure to allow creation of a set of partitions
			-- for symbols within bounds `min'..`max'.
		do
			create symbols.make ((max - min + 1).min (512))
			precursor (min, max)
		end

feature -- Initialization

	initialize
			-- Prepare structure to allow creation of a
			-- set of equivalence classes for symbols
			-- within bounds `lower'..`upper'.
			-- [This feature can be called to reset structure
			-- as it was after `make' creation procedure call.]
		do
			precursor
			symbols.wipe_out
		end

feature -- Access

	symbols: DS_HASH_SET [INTEGER]
			-- Set of symbols that belong to one of the partitions

feature -- Status report

	has (symbol: INTEGER): BOOLEAN
			-- Does `symbol' belong to one of the partition?
		require
			valid_symbol: valid_symbol (symbol)
		do
			Result := symbols.has (symbol)
		end

feature -- Element change

	put (symbol: INTEGER)
			-- Create equivalence class for single `symbol'
			-- and record `symbol' as member of a partition.
		do
			symbols.force (symbol)
			precursor (symbol)
		ensure then
			has_symbol: has (symbol)
		end

	add (symbol_class: LX_SYMBOL_CLASS)
			-- Update partition set based on `symbol_class'
			-- and record `symbol_class''s symbols as members
			-- of a partition.
		local
			i, nb: INTEGER
			symbol_table: like symbols
		do
			precursor (symbol_class)
			symbol_table := symbols
			from
				i := symbol_class.lower
				nb := symbol_class.upper
			until
				i > nb
			loop
				if symbol_class.has (i) then
					symbol_table.force (i)
				end
				i := i + 1
			end
		end

invariant

	symbols_not_void: symbols /= Void

end

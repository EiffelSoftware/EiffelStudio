note

	description:

		"Classes of integer symbols, kept in increasing order"

	storable_version: "20130823"
	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_SYMBOL_CLASS

inherit

	DS_ARRAYED_LIST [INTEGER]
		rename
			sort as arrayed_sort,
			has as arrayed_has,
			put as arrayed_put
		export
			{NONE}
				arrayed_put,
				put_first,
				put_last,
				put_left,
				put_right,
				force,
				force_first,
				force_last,
				force_left,
				force_right,
				extend,
				extend_first,
				extend_last,
				extend_left,
				extend_right,
				append,
				append_first,
				append_last,
				append_left,
				append_right,
				replace,
				swap
		end

create

	make

feature -- Status report

	negated: BOOLEAN
			-- Is the symbol class negated?

	sort_needed: BOOLEAN
			-- Should the symbol class be sorted?

	valid_symbols (min, max: INTEGER): BOOLEAN
			-- Are symbols in current class within
			-- bounds `min' and `max'?
		require
			valid_bounds: min <= max
			sorted: not sort_needed
		do
			if is_empty then
				Result := True
			else
				Result := first >= min and last <= max
			end
		end

	has (symbol: INTEGER): BOOLEAN
			-- Does current class include `symbol'?
			-- (Does not take into account `negated'.)
		local
			i: INTEGER
			stop: BOOLEAN
		do
			if sort_needed then
				Result := arrayed_has (symbol)
			elseif not is_empty then
				if last = symbol then
					Result := True
				elseif last > symbol then
					from
						i := 1
					until
						Result or stop
					loop
						if item (i) = symbol then
							Result := True
						elseif item (i) > symbol then
							stop := True
						else
							i := i + 1
						end
					end
				end
			end
		ensure
			definition: Result = arrayed_has (symbol)
		end

feature -- Status setting

	set_negated (b: BOOLEAN)
			-- Set `negated' to `b'.
		do
			negated := b
		ensure
			negated_set: negated = b
		end

feature -- Element change

	put (symbol: INTEGER)
			-- Add `symbol' to symbol class.
		do
			if not has (symbol) then
				if not is_empty and then last > symbol then
					sort_needed := True
				end
				force_last (symbol)
			end
		ensure
			inserted: has (symbol)
		end

feature -- Convertion

	convert_to_equivalence (classes: LX_EQUIVALENCE_CLASSES)
			-- Convert symbol class to class made of its
			-- symbols' equivalence classes.
		require
			classes_not_void: classes /= Void
			classes_built: classes.built
			valid_symbols: classes.valid_symbol_class (Current)
		local
			i, j, nb: INTEGER
			symbol: INTEGER
		do
			nb := count
			from
				i := 1
			until
				i > nb
			loop
				symbol := item (i)
				if classes.is_representative (symbol) then
					j := j + 1
					replace (classes.equivalence_class (symbol), j)
				end
				i := i + 1
			end
			count := j
		end

feature -- Sort

	sort
			-- Sort symbols in class.
			-- Use a shell sort since the list
			-- of symbols could be large.
		do
			arrayed_sort (sorter)
			sort_needed := False
		ensure
			sorted: not sort_needed
		end

	sorter: DS_SHELL_SORTER [INTEGER]
			-- Shell sorter
		local
			a_comparator: KL_COMPARABLE_COMPARATOR [INTEGER]
		once
			create a_comparator.make
			create Result.make (a_comparator)
		ensure
			sorter_not_void: Result /= Void
		end

invariant

	sorted: not sort_needed implies sorted (sorter)

end

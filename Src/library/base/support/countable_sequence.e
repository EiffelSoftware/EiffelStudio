deferred class COUNTABLE_SEQUENCE [G]

inherit

	COUNTABLE [G]
		rename
			item as i_th
		end

	ACTIVE [G]
		export
			{NONE}
					fill, prune_all, put,
					prune, 
					wipe_out, replace, remove
		end

	LINEAR [G]
		redefine
			linear_representation
		end

feature -- Access

	i_th (i: INTEGER): G is
		deferred
		end

	index: INTEGER

	item: G is
		do
			Result := i_th (index)
		end

feature -- Status report

	after: BOOLEAN is false

	extendible: BOOLEAN is false

	prunable: BOOLEAN is false

	readable: BOOLEAN is true

	writable: BOOLEAN is false

feature -- Cursor movement

	finish is
		do
		ensure then
			failure: false
		end

	forth is
		do
			index := index + 1
		end

	start is
		do
			index := 1
		end

feature {NONE} -- Inapplicable

	extend (v: G) is
		do
		end

	linear_representation: LINEAR [G] is
		do
		end;

	prune (v: G) is
		do
		end;

	put (v: G) is
		do
		end

	remove  is
		do
		end

	replace (v: G) is 
		do
		end

	wipe_out is
		do
		end

end -- class COUNTABLE_SEQUENCE

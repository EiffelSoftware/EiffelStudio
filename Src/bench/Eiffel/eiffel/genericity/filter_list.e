class FILTER_LIST

inherit
	LINKED_LIST [GEN_TYPE_I]
		rename
			append as list_append,
			search as list_search
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
		do
			Precursor {LINKED_LIST}
			compare_objects
		end

feature -- Search

	search (v: GEN_TYPE_I) is
			-- Patch
		local
			stop: BOOLEAN
		do
			from
				start
			until
				after or else stop
			loop
				stop := item.same_as (v)
				if not stop then
					forth
				end
			end
		ensure
			object_found: (not exhausted and object_comparison) implies (v /= Void and then v.same_as (item))
		end

	clean is
			-- Clean the list of all the removed classes
		do
			from
				start
			until
				after
			loop
				if not item.is_valid then
					remove
				else
					forth
				end
			end
		end

feature -- Merging

	append (other: like Current) is
			-- Append `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			from
				other.start
			until
				other.after
			loop
				search (other.item)
				if after then
					extend (other.item)
				end;
				other.forth
			end
		end

feature

	trace is
		do
			from
				start
			until
				after
			loop
				item.trace
				forth
			end
		end

end

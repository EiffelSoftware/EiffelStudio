class FILTER_LIST

inherit

	LINKED_LIST [GEN_TYPE_I]
		rename
			append as list_append
		redefine
			search
		end

creation

	make

feature

	search (t: GEN_TYPE_I) is
			-- Patch
		local
			stop: BOOLEAN;
		do
			from
				start
			until
				after or else stop
			loop
				stop := item.same_as (t);
				if not stop then
					forth
				end;
			end;
		end;

	clean is
			-- Clean the list of all the removed classes
		do
			from
				start
			until
				after
			loop
				if not item.is_valid then
					remove;
				else
					forth
				end;
			end;
		end;

feature -- Merging

	append (other: like Current) is
			-- Append `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			from other.start until other.after loop
				search (other.item);
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
			end;
		end;

end

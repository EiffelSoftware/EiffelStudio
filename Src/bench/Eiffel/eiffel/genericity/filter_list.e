class FILTER_LIST

inherit

	LINKED_LIST [GEN_TYPE_I]
		redefine
			search_equal
		end

creation

	make

feature

	search_equal (t: GEN_TYPE_I) is
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

end

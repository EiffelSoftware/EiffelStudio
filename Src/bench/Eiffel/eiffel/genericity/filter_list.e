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
				offright or else stop
			loop
				stop := item.same_as (t);
				if not stop then
					forth
				end;
			end;
		end;

end

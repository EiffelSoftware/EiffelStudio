class GENERATOR [G, H -> READABLE_INDEXABLE [G]]

feature

	generate (creator: FUNCTION [like {TEST}.max_count, H]; max_count: like {TEST}.max_count): SPECIAL [H]
		local
			a: ARRAYED_LIST [H]
			i: like {TEST}.max_count
		do
			create a.make (10)
			from
				i := 0
			until
				i > max_count
			loop
				a.extend (creator.item (i))
				if i = 0 then
					i := 1
				else
					i := i * 2
				end
			end
			a.trim
			Result := a.area
		end

end

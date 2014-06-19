class C [G, H -> B]

feature

	item (i: INTEGER): detachable D [like {H}.item] assign put
		do
		end

	put (other: detachable D [like {H}.item]; i: INTEGER)
		do
		end

end

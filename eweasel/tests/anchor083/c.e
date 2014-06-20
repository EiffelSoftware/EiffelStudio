class C [G, H -> B]

inherit B

feature

	example: detachable D [like {H}.item]

	plus alias "+" (other: detachable D [like {H}.item]): detachable D [like {H}.item]
		do
		end

end

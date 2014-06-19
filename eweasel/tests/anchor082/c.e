class C [G, H -> B]

inherit B

feature

	plus alias "+": detachable D [like {H}.item]
	minus alias "-": detachable D [like {H}.item]

end

class C [G, H -> B]

inherit B

feature

	plus alias "+" (other: like Current): detachable D [like {H}.item]
		do
		end

end

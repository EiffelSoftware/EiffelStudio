class A [G -> B, H -> C [ANY, G]]

	
feature

	view: detachable H

	work
		local
			v
		do
			v := view
			check
				attached_view: attached v
				attached_plus: attached v.item
			then
			end
		end

end

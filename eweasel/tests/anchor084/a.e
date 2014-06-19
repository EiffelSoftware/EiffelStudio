class A [G -> B, H -> C [ANY, G]]

	
feature

	view: detachable H

	work
		do
			check
				attached_view: attached view as v
				attached_plus: attached v.item (1) as i
			then
				v.item (2) := i
			end
		end

end

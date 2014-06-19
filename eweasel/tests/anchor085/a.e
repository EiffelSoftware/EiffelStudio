class A [G -> B, H -> C [ANY, G]]

	
feature

	view: detachable H

	store
		do
			check
				attached_view: attached view as v
			then
				v.put ([Void])
			end
		end

end

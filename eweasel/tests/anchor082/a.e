class A [G -> B, H -> C [ANY, G]]

	
feature

	view: detachable H

	store: like view.store
		do
			check attached_store: attached view as l_v and then attached - l_v as l_store then
				Result := l_store
			end
		end

end

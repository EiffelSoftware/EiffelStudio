class A [G -> B, H -> C [ANY, G]]

	
feature

	view: detachable H

	store: like view.plus
		do
			check
				attached_view: attached view as l_v
				attached_minus: attached - l_v as l_minus
				attached_plus: attached + l_v as l_plus
			then
				Result := l_plus
			end
		end

end

class E [G -> B, H -> {B, C [ANY, G]}]

	
feature

	view: detachable H

	store: like view.plus
		require
			attached_view: attached view as v
			attached_plus: attached (v + v.example)
		do
			check
				attached_view: attached view as l_v
				attached_plus: attached (l_v + l_v.example) as l_plus
			then
				Result := l_plus
			end
		end

end

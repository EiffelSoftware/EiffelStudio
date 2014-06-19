class F [G -> B, H -> {B, C [ANY, G]}]

inherit
	E [G, H]
		redefine
			store
		end
	
feature

	store: like view.plus
		do
			check
				attached_view: attached view as l_v
				attached_plus: attached + l_v as l_plus
			then
				Result := l_plus
			end
		end

end

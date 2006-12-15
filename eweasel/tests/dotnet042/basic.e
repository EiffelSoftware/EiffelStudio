class BASIC [G -> SYSTEM_OBJECT, H -> IBASIC]

inherit
	ANY
		rename
			clone as any_clone
		end

feature

	clone (arg: TYPED_POINTER [H]): INTEGER_32
		do
			Result := 5
		end

end

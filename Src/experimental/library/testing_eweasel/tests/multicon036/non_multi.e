class NON_MULTI
feature
	a: A

	example: ANY
		do
			Result := a.f.is_equal (3) -- @1
	end
end


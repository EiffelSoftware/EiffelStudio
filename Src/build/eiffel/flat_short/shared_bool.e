class SHARED_BOOL

feature

	value: BOOLEAN;
			-- Boolean value

	set_value (b: BOOLEAN) is
			-- Assign `b' to `value'.
		do
			value := b
		end;

end

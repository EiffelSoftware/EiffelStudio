

class TEST2
feature

	make
		do
			valid := True
		end

	disable_valid
		do
			valid := False
		end

	Stoat: INTEGER = 4

	valid: BOOLEAN

invariant
	valid: valid
end

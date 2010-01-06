
class TEST

create
	make

feature

	make
		do
			Current.try
		end;

	try
		require
			valid: valid
		do
		end
				
	valid: BOOLEAN do Result := True end

invariant
	inv1: $valid /= default_pointer
end

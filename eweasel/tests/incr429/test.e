
$EXPANDED class TEST
		
create
	make, default_create

feature {NONE}

	make
		do
			print (f ($make) /= default_pointer); io.new_line
		end

	f (n: POINTER): POINTER
		do
			Result := n
		end

end

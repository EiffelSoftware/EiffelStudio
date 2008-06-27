class TEST
create
	make

feature

	make is
			--
		do

		end

	Frozen Idler:Procedure[Any, Tuple[]] Is 
		Once
			Result := Agent Do_Nothing
		End

end

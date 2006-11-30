class TEST

create
	make

feature 

	make is
		local
			a: A
			$DOTNET_LOCAL
		do
			create a
			$DOTNET_USE
		end
end

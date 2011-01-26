
class TEST3 [G -> ANY create default_create end]
inherit
	TEST2 [G]
feature
	y: G
		do
			create Result
			Result := create {G}.default_create
			create {G} Result.default_create
		end
end

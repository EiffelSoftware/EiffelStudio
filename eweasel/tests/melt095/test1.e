
class TEST1 [G -> STRING create make end]
inherit
	EXCEPTIONS
create
	default_create

feature
	y: G
		attribute
			create Result.make (3)
			raise ("Weasels")
			Result.append ("weasel")
		end
end

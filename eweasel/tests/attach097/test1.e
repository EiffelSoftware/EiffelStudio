
class TEST1 [G -> TEST2 create default_create end]

create
	default_create
convert
	to_generic: {G}

feature

	try
		local
			x: G
		do
			x := Current
		end

	to_generic: G
		do
			create Result
		end

end

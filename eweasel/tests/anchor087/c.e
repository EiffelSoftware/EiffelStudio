class C

inherit

	B
		redefine
			bar
		end

feature

	bar: detachable like zzz.foo

	zzz: detachable A [like Current]

end

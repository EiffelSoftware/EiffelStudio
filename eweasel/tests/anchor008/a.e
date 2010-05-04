deferred class A [G, H -> {HASHABLE, COMPARABLE rename default_create as c end} create default_create end]

feature {NONE} -- Creation

	make
		do
			create h
		end

feature -- Access

	agh: detachable A [G, H]
	h: H
	aglh: detachable A [G, like h]
	laghaglh: like agh.aglh

end

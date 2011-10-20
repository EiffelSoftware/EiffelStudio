
class TEST1 [G -> ANY rename default as weasel end create default_create end]

feature
	f
		require
			ok: create {like {G}.weasel} /= Void
		do 
		end
	
end


class TEST2 [G -> ANY rename default as weasel end create default_create end]
create
	make
feature
	make
		do
			print (create {like {G}.default})
			print (create {like {G}.weasel})
		end

end



class TEST2
inherit 
	TEST1

create
	make

invariant
	valid: (once "Stoat") /= Void
	good: (once "Ermine") /= Void
end

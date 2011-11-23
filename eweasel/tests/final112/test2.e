
class TEST2
inherit
	TEST1

create
	make
invariant
	good: not across list as c some c.item /~ once "Weasel"end
end

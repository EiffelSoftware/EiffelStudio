note description: "[
		Test of prettify command
	]"


class			TEST inherit ANY ANY ANY

feature
	f	local a:detachable separate like Current
	b: like twin.twin
c: like {ANY}.out x, y  : INTEGER
s
:attached STRING_32
do                            	s := {STRING_32} "foo"
end end 

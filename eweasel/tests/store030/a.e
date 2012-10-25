class A

create
	make

feature {NONE} -- Creation

	make
		do
			s := "NON_VOLATILE"
			i := 123123
			create ptr.make (10)
			create special.make_empty (100)
			create arrayed.make (100)
		end

feature -- Access

	ptr: MANAGED_POINTER note option: transient attribute end
	special: SPECIAL [NATURAL_8]
	arrayed: ARRAYED_LIST [STRING]
	s: STRING
	i: INTEGER

$COMMENT	vol_s: STRING note option: transient attribute end
$COMMENT	vol_i: INTEGER note option: transient attribute end

end

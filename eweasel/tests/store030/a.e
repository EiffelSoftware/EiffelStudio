class A

create
	make

feature {NONE} -- Creation

	make
		do
			s := "NON_VOLATILE"
			i := 123123
		end

feature -- Access

	s: STRING
	i: INTEGER

$COMMENT	vol_s: STRING note option: transient attribute end
$COMMENT	vol_i: INTEGER note option: transient attribute end

end

/^invariant/{
	r any.txt
	N
}
/print (o: detachable ANY)/{
	N
	N
	N
	s/\(\t\tlocal\)/\	\	note\n\t\t\texplicit\:\ contracts\n\1/
	N
	N
	N
	N
	N
	N
	N
	N
	N
	N
	N
	N
	N
	N
	s/\(\t\t\tinstance_free: class\)/\1\n\t\t\tmodify\ \(\[\]\)/
}
/default_create/{
	N
	N
	N
	N
	s/\t\tdo/\	\	note\n\t\t\tstatus\:\ creator\n\t\tdo/
}
/frozen do_nothing/{
	N
	N
	N
	N
	s/\(\t\tdo\)/\	\	note\n\t\t\texplicit\:\ contracts\,\ wrapping\n\1/
	s/\(\t\t\tinstance_free: class\)/\1\n\t\t\tmodify\ \(\[\]\)/
}
/io: STD_FILES/{
	N
	N
	N
	N
	s/\(\t\tonce\)/\	\	note\n\t\t\tstatus\:\ impure\n\t\t\texplicit\:\ contracts\n\1/
	N
	N
	s/\(\t\t\tinstance_free: class\)/\1\n\t\t\tmodify\ \(\[\]\)/
	N
	s/\(io_not_void: Result \/= Void\)/\1\n\	\	\	is_writable\:\ Result.is_fully_writable/
}

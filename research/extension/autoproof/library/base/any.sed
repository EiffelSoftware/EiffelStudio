/^invariant/{
	r any.txt
	N
}
/Handle to standard file setup/a\	\	note\n\t\t\tstatus\:\ impure\n\t\t\texplicit\:\ contracts\n\t\trequire\n\t\t\tmodify\ \(\[\]\)
/io_not_void: Result \/= Void/a\	\	\	is_writable\:\ Result.is_fully_writable
/print (o: detachable ANY)/{
	N
	N
	a\	\	note\n\t\t\texplicit\:\ contracts\n\t\trequire\n\t\t\tmodify\ \(\[\]\)
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
	s/\(\t\tdo\)/\	\	note\n\t\t\texplicit\:\ contracts\,\ wrapping\n\t\trequire\n\t\t\tmodify\ \(\[\]\)\n\1/
}
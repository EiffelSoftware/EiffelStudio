/item:/{
	N
	N
	N
	s/\(\t\t\tvalid_position: not after\)/\t\t\tclosed: closed\n\1/
}
/after:/{
	N
	N
	N
	s/\(\t\tdeferred\)/\t\trequire\n\t\t\tclosed: closed\n\1/
}
/forth/{
	N
	N
	N
	s/\(\t\t\tvalid_position: not after\)/\1\n\t\t\tsubjects_closed: across subjects as s all s.closed end/
}

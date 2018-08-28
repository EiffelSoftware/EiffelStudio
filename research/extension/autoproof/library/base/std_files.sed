n
/put_string/{
	N
	N
	N
	N
	s/\(\t\tdo\)/\t\t\tmodify (Current)\n\1/
}
/put_new_line/{
	N
	N
	N
	N
	s/\(\t\tdo\)/\t\trequire\n\t\t\tmodify (Current)\n\1/
}
/read_integer/{
	N
	N
	N
	N
	s/\(\t\tdo\)/\t\trequire\n\t\t\treads ([])\n\1/
}
/^\tread_line\(\|, [[:alnum:]_]+\)/{
	N
	N
	N
	N
	s/\(\t\tdo\)/\t\trequire\n\t\t\tmodify (Current)\n\1/
	N
	N
	s/\(\t\tensure\)/\t\t\tcreate internal_last_string_.make_from_string (last_string)\n\1\n\t\t\tinternal_last_string_ \/= Void\n\t\t\tinternal_last_string_.is_wrapped/
	s/\t\t\tinstance_free: class//
}
/note/{
	i feature -- EVE
	i
	i\	internal_last_string_: V_STRING
	i
	i\	last_string_: V_STRING
	i\	\	\	-- Last string read by `read_line'.
	i\	\	do
	i\	\	\	Result := internal_last_string_
	i\	\	ensure
	i\	\	\	Result = internal_last_string_
	i\	\	end
	i
}

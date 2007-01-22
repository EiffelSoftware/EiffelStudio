indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI[G->{COMPARABLE, NUMERIC}]

create
	default_create

feature -- do compuations

		set_g (a_g: G)
			require
				a_g_not_void: a_g /= Void
			do
				g:=a_g
			ensure
				g_set: g = a_g
			end

		g: G

		set_tuple(a_tuple: TUPLE[G])
			do
				tuple := a_tuple
			ensure
				tuple_set: tuple = a_tuple
			end


		tuple: TUPLE[g: G]

		proc_tuple: TUPLE[h: G]
			do
				Result := [g]
			ensure
				result_not_void: Result /= Void
			end

end

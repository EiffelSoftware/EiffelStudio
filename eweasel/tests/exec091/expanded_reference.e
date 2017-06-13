expanded class EXPANDED_REFERENCE

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature

	default_create
		do
			io.put_string ("create ")
			item := "foo"
		end

	item: detachable separate STRING

	show: BOOLEAN
		do
			io.put_string ("invariant")
			io.put_new_line
			Result := attached {STRING} item as value and then value.same_string ("foo")
		end

invariant

	test: show

end

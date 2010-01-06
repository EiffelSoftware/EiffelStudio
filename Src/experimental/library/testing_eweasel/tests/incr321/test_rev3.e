
class TEST

create
	default_create, make, make_from_test2

feature

	make_from_test2 (t: TEST2 [STRING])
		do
		end

	make
		local
			t: TEST2 [DOUBLE]
			v: TEST
			w: TEST
		do
			create t
			create v
			t := v
			v := t
			create {like Current} w
			t := w
			Current.try
		end
	
	try
		do
		end
	
	value (a: TEST2 [DOUBLE]): BOOLEAN
		do
			Result := True
		end

invariant
	ok: value (create {TEST})
end


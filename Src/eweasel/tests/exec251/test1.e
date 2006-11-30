deferred class
	TEST1

feature -- Access
	make
		local
			a: ARRAY [ANY]
		do
			a := << "STRING", << pid($f), pid($g) >> >>
		end

	f is
		do
		end

	g is
		deferred
		end

	pid (p: POINTER): POINTER is
			--
		do
			Result := p
		end

end

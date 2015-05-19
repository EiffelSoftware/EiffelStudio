class FLAG

feature

	is_ready: BOOLEAN

	reset
		do
			is_ready := False
		ensure
			not is_ready
		end

	set
		do
			is_ready := True
		ensure
			is_ready
		end

end
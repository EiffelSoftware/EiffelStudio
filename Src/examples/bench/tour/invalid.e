class INVALID feature

	attribute: INTEGER;

	display is
			-- Attempt (in an invalid way) to call a procedure of
			-- class PARENT.
		local
			p: PARENT
		do
			create p
			p.first_message (1)
		end

end -- class INVALID

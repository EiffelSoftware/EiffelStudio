class
	TEST

create
	make

feature

	make
		local
			x, y, z: separate TEST
		do
			x := Current
			y := Current
			z := Current

				-- One argument.
		separate x
			as a do a.do_nothing	end

				-- Two arguments.
			separate x as
			a
			,
			
			 y as b do
				a.do_nothing
				b.do_nothing
			end

				-- More than 2 arguments.
			separate x as a, y
				as b, z as c
			do
				a.do_nothing
				b.do_nothing
				c.do_nothing
			end

				-- One argument with inline comments.
			separate -- x has to be controlled
			x -- This is a comment about x.
			as -- Somewhat strange comment.
			a -- Now a can be used.
			do
				a.do_nothing
			end

			-- More than 2 arguments with inline comments.
				separate x as a, -- Cannot use uncontrolled x.
			  y -- Cannot use uncontrolled y.
			  as b -- Somewhat strange comment.
			  ,
			   z as -- Breaking comment after keyword.
				c do -- Start something.
				a.do_nothing b.do_nothing c.do_nothing
			end
		end

end

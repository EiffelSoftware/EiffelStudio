class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			proc
		end

feature {TEST} -- Access

	proc
			-- An obsolete procedure.
		obsolete "Use something else. [$(DATE)]"
		do
		end


end

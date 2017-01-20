class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			attr := Current
			proc
			Current.proc
			extn
			Current.extn
			attr.do_nothing
			Current.attr.do_nothing
		end

feature {TEST} -- Access

	proc
			-- An obsolete procedure.
		obsolete "The internal procedure should not be used."
		do
		end

	extn
			-- An obsolete procedure.
		obsolete "The external procedure should not be used."
		external "C inline"
			alias "return;"
		end

	attr: TEST
			-- An obsolete attribute.
		obsolete "The attribute should not be used."
		attribute
		end

end

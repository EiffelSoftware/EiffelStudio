class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			across (agent do end) as c loop end
			if across (agent do end) as c all True end then
			end
		end

end

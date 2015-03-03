class HISTOGRAM_MAX

feature
	max: INTEGER
	done: INTEGER

	new_max (i: INTEGER)
		do
			max := i.max (max)
			done := done + 1
		end
end


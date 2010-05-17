class
	TEST

inherit
	COMPARABLE

create
	make

feature {NONE} -- Creation

	make
		do
			if Current < Current then
				domain := Current.domain
			end
		end

feature

	domain: detachable TEST1 [CHARACTER]

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		local
			cursor, other_cursor: like domain.new_cursor
			exit: BOOLEAN
		do
			if attached domain as d and then attached other and then attached other.domain as other_domain then
				from
					cursor := d.new_cursor
					other_cursor := other_domain.new_cursor
				until
					exit or cursor.after or other_cursor.after
				loop
					if cursor.item < other_cursor.item then
						result := true
						exit := true
					elseif other_cursor.item < cursor.item then
						result := false
						exit := true
					end
				end
				if not exit then
					result := (cursor.after and not other_cursor.after)
				end
			end
		end

end

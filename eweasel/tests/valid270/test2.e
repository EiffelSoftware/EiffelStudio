
class TEST2
feature
	try
		require
			good: attached {STRING} Current as w and then w.weasel
		do
			check
				fine: attached {STRING} Current as x and then x.weasel
			end
		ensure
			ok: attached {STRING} Current as y and then y.weasel
		end

invariant
	valid: attached {STRING} Current as z and then z.weasel
end

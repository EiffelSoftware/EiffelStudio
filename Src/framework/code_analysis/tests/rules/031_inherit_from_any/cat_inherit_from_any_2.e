class
	CAT_INHERIT_FROM_ANY_2

-- Should not violate the inherit from ANY rule.

inherit
	CAT_INHERIT_FROM_ANY_1
		undefine
			out
		end
	ANY
end

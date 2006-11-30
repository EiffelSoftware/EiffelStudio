$EXPANDED_CLASS class POINT

inherit
	HASHABLE
		export {ANY}
			default_create
		end
	DISPOSABLE
	$VALUE_TYPE

feature

	dispose is
		do
		end

	hash_code: INTEGER is
		do
		end

	x, y: INTEGER

	set_x (v: like x) is
		do
			x := v
		end

end
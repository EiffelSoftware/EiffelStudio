once class A

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
		once
		end

end

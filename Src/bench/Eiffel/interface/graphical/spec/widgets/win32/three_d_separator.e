class THREE_D_SEPARATOR

inherit

	SEPARATOR
		redefine
			implementation, set_default
		end

creation
	make

feature -- Access

	--implementation: SEPARATOR_IMP
	implementation: SEPARATOR_WINDOWS -- VISIONLITE

feature -- Update

	set_default is
		do
			implementation.set_3d_separator
		end

end -- class THREE_D_SEPARATOR

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- 
		local
			control_site: CONTROL_SITE
		do
			create control_site.make
		end
		
end -- ROOT_CLASS

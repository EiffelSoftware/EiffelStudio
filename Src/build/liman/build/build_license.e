class BUILD_LICENSE

inherit

	ISE_LICENSE
		redefine 
			make
		end
	
creation

	make
	
feature -- Initialization
	
	make is
		do
			precursor
			set_application_name ("eiffelbuild")
			set_version (4)
		end
	
feature

	application_delay: INTEGER is 40;

	override_key_line: INTEGER is 5;

end

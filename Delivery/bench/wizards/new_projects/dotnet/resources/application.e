class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			Console: SYSTEM_CONSOLE
		do
			Console.WriteLine_system_string ("Hello World [Eiffel#]")
		end

end -- class APPLICATION
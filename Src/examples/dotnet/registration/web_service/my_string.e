indexing
	description: "Wrapper of base class System.String providing additional features"

class
	MY_STRING
alias
	"RegistrationService.MyString"

create
	make

feature {NONE} -- Initialization

	make (value: STRING) is
			-- Initialize string with `value'.
		local
			a_internal: STRING
		do
			create a_internal.make (value)
			internal := a_internal
		end

feature -- Access

	is_integer: BOOLEAN is
			-- Is string an integer?
		local
			i: INTEGER
		do
			from
				Result := true
			until
				i >= internal.count or not Result
			loop
				Result := internal.chars (i).isdigit (internal.chars (i))
				i := i + 1
			end
		end

	to_integer: INTEGER is
			-- Convert string to integer
		do
			Result := internal.ToInt32
		end

feature {NONE} -- Implementation

	internal: STRING
			-- Internal string

end -- class STRING
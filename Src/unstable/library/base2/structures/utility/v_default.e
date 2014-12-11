note
	description: "Provides default values for any type (to avoid catcalls in void safe mode)."
	author: "Nadia Polikarpova"

class
	V_DEFAULT [G]

feature -- Access

	default_value: G
			-- Default value of type `G'.
			-- If `G' does not have a default value (i.e. an attached reference type),
			-- an unintializaed object is created through reflection.
			-- Such an object must not be used for anything but reference comparison.
		local
			t: TYPE [G]
		do
			t := {G}
			if t.has_default then
				Result := t.default
			elseif attached default_value_cache as c then
				Result := c
			else
				check attached {G} internal.new_instance_of (t.type_id) as res then
					Result := res
					default_value_cache := res
				end
			end
		end

feature	{NONE} -- Implementation

	default_value_cache: detachable G
			-- Cache of `default_value'.

	internal: INTERNAL
			-- Used for reflection.
		once
			create Result
		end
end

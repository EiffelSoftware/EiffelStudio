class A [G]

feature -- Access

	put (v: like value) is
		do
			value := v
		ensure
			value_set: value = v
		end

	item: like value is
		do
			Result := value
		ensure
			result_set: Result = value
		end

feature -- Data

	value: G
			-- Current value

end
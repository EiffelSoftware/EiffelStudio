class A

feature

	item_do: STRING
			-- A string "item_do".
		do
			Result := "item_do"
		ensure
			is_instance_free: class
		end

	item_once: STRING
			-- A string "item_once".
		once
			Result := "item_once"
		ensure
			is_instance_free: class
		end


	put_do (value: STRING)
			-- Print `value`.
		do
			;(create {A}).io.put_string (value)
			;(create {A}).io.put_new_line
		ensure
			is_instance_free: class
		end

	put_once (value: STRING)
			-- Print `value`.
		once
			;(create {A}).io.put_string (value)
			;(create {A}).io.put_new_line
		ensure
			is_instance_free: class
		end

end
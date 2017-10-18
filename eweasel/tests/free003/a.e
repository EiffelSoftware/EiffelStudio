class A

feature

	item_do: STRING
			-- A string "item_do".
		note
			option: instance_free
		do
			Result := "item_do"
		end

	item_once: STRING
			-- A string "item_once".
		note
			option: instance_free
		once
			Result := "item_once"
		end


	put_do (value: STRING)
			-- Print `value`.
		note
			option: instance_free
		do
			;(create {A}).io.put_string (value)
			;(create {A}).io.put_new_line
		end

	put_once (value: STRING)
			-- Print `value`.
		note
			option: instance_free
		once
			;(create {A}).io.put_string (value)
			;(create {A}).io.put_new_line
		end

end
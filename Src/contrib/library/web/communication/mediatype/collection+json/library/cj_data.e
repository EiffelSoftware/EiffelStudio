note
	description: "[
				Data objects may have three possible properties:
					- name   (REQUIRED)
					- value  (OPTIONAL)
					- prompt (OPTIONAL)
			]"
	date: "$Date$"
	revision: "$Revision$"
	example: "[
		{
		  "prompt" : STRING_32,
		  "name" : STRING_32,
		  "value" : STRING_32
		  
		}
	]"

class
	CJ_DATA

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make
		do
			make_with_name (create {like name}.make_empty)
		end

	make_with_name (a_name: like name)
		do
			name := a_name
		end

feature -- Access

	name: STRING_32

	prompt: detachable STRING_32

	value: detachable STRING_32
			-- this propertie May contain
			-- one of the following data types, STRING, NUMBER, Boolean(true,false), null

feature -- Element Change

	set_name (a_name: like name)
			-- Set `name' to `a_name'.
		do
			name := a_name
		ensure
			name_set: name ~ a_name
		end

	set_prompt (a_prompt: like prompt)
			-- Set `prompt' to `a_prompt'.	
		do
			prompt := a_prompt
		ensure
			prompt_set: prompt ~ a_prompt
		end

	set_value (a_value: like value)
		do
			value := a_value
		ensure
			value_set: value ~ a_value
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

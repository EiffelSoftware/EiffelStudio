class
	EXAMPLE [G -> ANY]

feature -- Query

	whatami (a_obj: ANY) is
		do
			if {l_type: G} a_obj then
				print (l_type.generator + "%N")
			end
		end

end

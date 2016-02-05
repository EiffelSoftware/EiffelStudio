class
	CAT_OBJECT_CREATION_WITHIN_LOOP

feature {None} --Test

	object_creation_in_loop
		-- Violates the object creation in a loop code analysis rule.
		local
			l_list: LINKED_LIST[INTEGER]
			l_string: STRING_32
		do
			across l_list as p loop
				create l_list.make
			end

			from
				l_list.start
			until
				l_list.after
			loop
				create l_list.make
				create l_string.make_empty
			end
		end
end

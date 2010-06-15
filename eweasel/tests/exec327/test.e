class
	TEST

create
	make

feature

	make
		do
		ensure
			verify_post
		end


	verify_post: BOOLEAN
		do
			Result := True
			check Result then
			end
		ensure
			verify_post
		end

end

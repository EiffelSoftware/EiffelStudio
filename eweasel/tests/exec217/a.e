class A

feature

	data: ANY

	set_data (a_data: like data) is
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

end

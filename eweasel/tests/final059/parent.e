
class PARENT

feature

	length: INTEGER
		do
			Result := placeholder_length
		end

	placeholder_length: INTEGER
			-- Length of one placeholder in bytes
		external
			"C inline"
		alias
			"13"
		end


end

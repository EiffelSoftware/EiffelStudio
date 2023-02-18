note
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_CONSTANT

create

	make

feature {NONE}

	make (context: LLVM_CONTEXT; string: STRING_8)
		local
			data_elements: CONSTANT_STLVECTOR
		do
			create data_elements.make
			across
				string as character
			loop
				data_elements.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 8), character.code.to_natural_64))
			end
			data_elements.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (context, 8), 0))
			create data.make (create {ARRAY_TYPE}.make (create {INTEGER_TYPE}.make (context, 8), data_elements.count), data_elements)
		end

feature

	data: CONSTANT_ARRAY

end

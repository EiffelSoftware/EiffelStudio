class TEST4

feature

	turkey: INTEGER
		external "C inline"
			alias "[
				return 29;
			]"
		ensure
			is_clasS: class
		end
	
end

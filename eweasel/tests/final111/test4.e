
class TEST4
feature
	turkey: INTEGER
		external "C inline"
		alias "[
			return 29;
			]"
		end
	
end

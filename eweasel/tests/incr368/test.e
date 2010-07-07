
class TEST
create
	make
feature
	make
		do
			x1.try
			x2.try
			x3.try
			x4.try
			x5.try
			x6.try
			x7.try
			x8.try
			x9.try
			x10.try
		end 
    
    	x1: TEST2 [INTEGER_8]
		do
			create Result
			Result.set_value ({INTEGER_8} 1)
		end
	
    	x2: TEST2 [INTEGER_16]
		do
			create Result
			Result.set_value ({INTEGER_16} 2)
		end
	
    	x3: TEST2 [INTEGER_32]
		do
			create Result
			Result.set_value ({INTEGER_32} 3)
		end
	
    	x4: TEST2 [INTEGER_64]
		do
			create Result
			Result.set_value ({INTEGER_64} 4)
		end
	
    	x5: TEST2 [NATURAL_8]
		do
			create Result
			Result.set_value ({NATURAL_8} 5)
		end
	
    	x6: TEST2 [NATURAL_16]
		do
			create Result
			Result.set_value ({NATURAL_16} 6)
		end
	
    	x7: TEST2 [NATURAL_32]
		do
			create Result
			Result.set_value ({NATURAL_32} 7)
		end
	
    	x8: TEST2 [NATURAL_64]
		do
			create Result
			Result.set_value ({NATURAL_64} 8)
		end
	
    	x9: TEST2 [REAL_32]
		do
			create Result
			Result.set_value ({REAL_32} 1.25)
		end
	
    	x10: TEST2 [REAL_64]
		do
			create Result
			Result.set_value ({REAL_64} 2.25)
		end
	
end

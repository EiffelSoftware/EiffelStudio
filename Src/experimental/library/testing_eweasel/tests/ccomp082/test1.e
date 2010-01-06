
expanded class TEST1 [G]

feature
        weasel
                do
			if attached {TEST1 [DOUBLE]} x as a then
			   print ("Error: DOUBLE should not conform to TEST1 [DOUBLE]%N");
			end
                end

        x: G

end


class BEURK_HEXER obsolete "Beurk Beurk Beurk"

feature

	hex_to_integer (s: STRING): INTEGER is
		local
			i, k: INTEGER;
			temp: STRING;
			c: CHARACTER
		do
			temp := s.duplicate; temp.to_lower;
			if temp.count >= 2 and then temp.item (2) = 'x' then
				i := 3
			else
				i := 1
			end;
			from
			until
				i > temp.count
			loop 
				c := temp.item (i);		
				Result := Result * 16 ;
				from
					k := val_tab.lower
				until
					k > val_tab.upper or else
					val_tab.item (k) = c
				loop
					k := k + 1
				end;
				Result := Result + k - val_tab.lower;
				i:= i + 1
			end
		end;	

	val_tab: ARRAY[CHARACTER] is 
		once
			!! Result.make (0, 15);
			Result.put ('0', 0);
			Result.put ('1', 1);
			Result.put ('2', 2);
			Result.put ('3', 3);
			Result.put ('4', 4);
			Result.put ('5', 5);
			Result.put ('6', 6);
			Result.put ('7', 7);
			Result.put ('8', 8);
			Result.put ('9', 9);
			Result.put ('a', 10);
			Result.put ('b', 11);
			Result.put ('c', 12);
			Result.put ('d', 13);
			Result.put ('e', 14);
			Result.put ('f', 15);
		end;

end
			

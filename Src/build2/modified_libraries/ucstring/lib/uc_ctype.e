indexing

   description: "Unicode Database";
   original:    "1999.10.11";
   copyright:   "1999 majkel kretschmar and others, see file »forum.txt«";

class UC_CTYPE

inherit
   UC_CONSTANTS
      end
   UC_CTYPE_CATEGORIES
      end
   UC_CTYPE_BIDI
      end
   UC_CTYPE_UPPERCASE
      end
   UC_CTYPE_LOWERCASE
      end
   UC_CTYPE_TITLECASE
      end

feature 

   to_lower(ucc: UCCHAR): UCCHAR is
	 -- convert `ucc' to lower. if there is no equivalent lower 
	 -- character, return `ucc' itself.
      local
	 code: INTEGER
      do
	 code := lowercase.item(ucc.code//256+1).item(ucc.code\\256+1)
	 if code = -1 then
	    Result := ucc
	 else
	    Result.set_code(code)
	 end
      end

   to_upper(ucc: UCCHAR): UCCHAR is
	 -- convert `ucc' to upper. if there is no equivalent upper 
	 -- character, return `ucc' itself.
      local
	 code: INTEGER
      do
	 code := uppercase.item(ucc.code//256+1).item(ucc.code\\256+1)
	 if code = -1 then
	    Result := ucc
	 else
	    Result.set_code(code)
	 end
	 --! TBD
      end

   to_title(ucc: UCCHAR): UCCHAR is
	 -- convert `ucc' to title. if there is no equivalent title
	 -- character, return `ucc' itself.
      local
	 code: INTEGER
      do
	 code := titlecase.item(ucc.code//256+1).item(ucc.code\\256+1)
	 if code = -1 then
	    Result := ucc
	 else
	    Result.set_code(code)
	 end
      end

   general_category (ucc: UCCHAR): INTEGER is
	 -- return character's general category. if there is no
	 -- category, `no_category' will be returned.
      do
	 Result := category.item(ucc.code // 256+1).item(ucc.code \\ 256+1)
      end

end -- class UC_CTYPE



indexing

   library: "Eif rx"
   type: "regular expressions"
   description: "A compiler for regular expressions, wrapper for GNU rx"
   copyright: "Bruce Wielinga (1997)"
   licence: "GPL version 2, see LICENCE"


class

   REGEX_COMPILER

feature
   -- compiling regular expressions

   compile( pat: STRING) is
	 -- attempt to compile `pat' into a regular expression
      require
	 pat /= Void
      local
	 tmp_space: POINTER
	 reg_suc: INTEGER
	 a: ANY
      do
	tmp_space := bw_alloc_reg 
	a ?= pat.to_c
	reg_suc := bw_make_reg(tmp_space, $a, 
			       reg_extended , reg_icase, 0, 
			       reg_newline)
	if reg_suc = 0 then
	   -- compile succeeded
	   !!last_regex.make(tmp_space)
	   succeeded := true
	else
	   -- compile succeeded
	   succeeded := false
	   bw_free_reg_space(tmp_space) 
	end
      ensure
	 succeeded implies last_regex /= Void
      end

   succeeded: BOOLEAN
	 -- did last compile attempt succed?

   last_regex: REGEX
	 -- last compiled regex

feature
   -- compilation switches

   extended: BOOLEAN
	 -- make extended regular expressions

   set_extended is
	 -- make extended regular expressions in future
      do
	 extended := true
      ensure
	 extended
      end

   unset_extended is
	 -- don't make extended regular expressions in future
      do
	 extended := false
      ensure
	 not extended
      end

   ignore_case: BOOLEAN
	 -- make regular expressions ignore case
   
   set_ignore_case is
	 -- make regular expressions which ignore case
      do
	 ignore_case := true
      ensure
	 ignore_case 
      end

   unset_ignore_case is
	 -- regular expressions don't ignore case from now on
      do
	 ignore_case := false
      ensure
	 not ignore_case
      end

   handle_newlines: BOOLEAN 
	 -- let newline in matching string be matched by ^/$

   set_handle_newlines is
	 -- set `handle_newlines' to `True'
      do
	 handle_newlines := True
      ensure
	 handle_newlines
      end

   unset_handle_newlines is
	 -- set `handle_newlines' to false
      do
	 handle_newlines := false
      ensure
	 not handle_newlines
      end

feature {NONE}
   -- compilation switches, implimentation

   reg_ext: INTEGER is 1

   reg_ing: INTEGER is 2

   reg_nl: INTEGER is 4

   reg_extended: INTEGER is
	 -- value of REG_EXTENDED flag
      do
	 if extended then
	    Result := reg_ext
	 else
	    Result := 0
	 end
      ensure
	 Result = reg_ext or Result = 0
      end

   reg_icase: INTEGER is
	 -- value of REG_ICASE flag
      do 
	 if ignore_case then
	    Result := reg_ing
	 else
	    Result := 0
	 end
      ensure
	 Result = reg_ing or Result = 0
      end

   reg_newline: INTEGER is
	 -- value of REG_NEWLING flag
      do
	 if handle_newlines then
	    Result := reg_nl
	 else
	    Result := 0
	 end
      ensure
	 Result = reg_nl or Result = 0
      end
      


feature {NONE}
   -- c code features

  bw_alloc_reg: POINTER is
	 -- allocates sizeof(regex_t) space
      external "C (): regex_t* | %"regex_glue.h%""
      end

   bw_make_reg(reg: POINTER; pat: POINTER; fl_e: INTEGER;
	       fl_i: INTEGER; fl_n: INTEGER; fl_nl: INTEGER): INTEGER is
	 -- attempt to compile `pat' in `reg' with flags
      require
	 reg /= Default_pointer
	 pat /= Default_pointer
      external "C: (regex_t*, char*, int, int, int ,int) | %"regex_glue.h%""
      end

   bw_free_reg_space( reg: POINTER) is
	 -- frees space allocated for `reg'
      require
	 reg /= Default_pointer
      external "C (regex_t*) | %"regex_glue.h%""
      end

end


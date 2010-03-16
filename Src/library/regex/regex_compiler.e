
note

   library: "Eif rx"
   type: "regular expressions"
   description: "A compiler for regular expressions, wrapper for GNU rx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
   copyright: "Bruce Wielinga (1997)"
   licence: "GPL version 2, see LICENCE"


class

   REGEX_COMPILER

feature
   -- compiling regular expressions

   compile( pat: STRING)
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
	   create last_regex.make(tmp_space)
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

   set_extended
	 -- make extended regular expressions in future
      do
	 extended := true
      ensure
	 extended
      end

   unset_extended
	 -- don't make extended regular expressions in future
      do
	 extended := false
      ensure
	 not extended
      end

   ignore_case: BOOLEAN
	 -- make regular expressions ignore case
   
   set_ignore_case
	 -- make regular expressions which ignore case
      do
	 ignore_case := true
      ensure
	 ignore_case 
      end

   unset_ignore_case
	 -- regular expressions don't ignore case from now on
      do
	 ignore_case := false
      ensure
	 not ignore_case
      end

   handle_newlines: BOOLEAN 
	 -- let newline in matching string be matched by ^/$

   set_handle_newlines
	 -- set `handle_newlines' to `True'
      do
	 handle_newlines := True
      ensure
	 handle_newlines
      end

   unset_handle_newlines
	 -- set `handle_newlines' to false
      do
	 handle_newlines := false
      ensure
	 not handle_newlines
      end

feature {NONE}
   -- compilation switches, implimentation

   reg_ext: INTEGER = 1

   reg_ing: INTEGER = 2

   reg_nl: INTEGER = 4

   reg_extended: INTEGER
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

   reg_icase: INTEGER
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

   reg_newline: INTEGER
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

  bw_alloc_reg: POINTER
	 -- allocates sizeof(regex_t) space
      external "C (): regex_t* | %"regex_glue.h%""
      end

   bw_make_reg(reg: POINTER; pat: POINTER; fl_e: INTEGER;
	       fl_i: INTEGER; fl_n: INTEGER; fl_nl: INTEGER): INTEGER
	 -- attempt to compile `pat' in `reg' with flags
      require
	 reg /= Default_pointer
	 pat /= Default_pointer
      external "C: (regex_t*, char*, int, int, int ,int) | %"regex_glue.h%""
      end

   bw_free_reg_space( reg: POINTER)
	 -- frees space allocated for `reg'
      require
	 reg /= Default_pointer
      external "C (regex_t*) | %"regex_glue.h%""
      end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end


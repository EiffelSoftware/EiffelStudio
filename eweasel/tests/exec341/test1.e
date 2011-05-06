class
   TEST1
 
feature {ANY}
 
   foo: INTEGER_32 assign set_foo
      external
         "C inline"
      alias
         "return 5;"
      end
 
   set_foo (a_foo: INTEGER_32)
      external
         "C inline"
      alias
         "printf(%"set_foo %%d\n%", $a_foo);"
      end
 
end

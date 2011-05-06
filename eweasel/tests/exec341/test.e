class TEST

create
   make
 
feature
 
   make
      do
         {TEST}.foo := 1 --> ok
         {TEST}.set_foo (2) --> ok
 
         {TEST1}.foo := 3 --> segfault at runtime
         {TEST1}.set_foo (4) --> ok
      end
 
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

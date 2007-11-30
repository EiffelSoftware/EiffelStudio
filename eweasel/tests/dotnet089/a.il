.assembly extern mscorlib { }

.assembly A {
	.ver 0:0:0:0
	.custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = ( 01 00 01 00 00 )
}

.class public A extends [mscorlib]System.Object
{
  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    .maxstack  8
    ldarg.0
    call       instance void [mscorlib]System.Object::.ctor()
    ret
  } // end of method Test::.ctor

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor(string) cil managed
  {
    .maxstack  8
    ldarg.0
    call       instance void [mscorlib]System.Object::.ctor()
    ldarg.1
    call       void [mscorlib]System.Console::WriteLine(string)
    ret
  } // end of method Test::.ctor


}

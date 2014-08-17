.assembly extern mscorlib { }

.assembly A {
	.ver 0:0:0:0
	.custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = ( 01 00 01 00 00 )
}

.class public B extends A
{
  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    .maxstack  8
    ldarg.0
    call       instance void [A]A::.ctor()
    ret
  } // end of method Test::.ctor
}

.class private A extends [mscorlib]System.Object
{
  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    .maxstack  8
    ldarg.0
    call       instance void [mscorlib]System.Object::.ctor()
    ret
  } // end of method Test::.ctor

.method public hidebysig newslot virtual 
        instance string  ToString() cil managed
{
  // Code size       12 (0xc)
  .maxstack  8
  IL_0000:  ldarg.0
  IL_0001:  call       instance string [mscorlib]System.Object::ToString()
  IL_000b:  ret
} // end of method Object::ToString

}



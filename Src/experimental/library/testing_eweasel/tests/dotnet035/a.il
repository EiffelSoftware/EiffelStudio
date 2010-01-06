.assembly extern mscorlib { }
.assembly extern type1 { }
.assembly extern type2 { }

.assembly A {
	.ver 0:0:0:0
	.custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = ( 01 00 01 00 00 )
}

.class public A extends [mscorlib]System.Object
{
  .method public hidebysig instance class [type1]TYPE type1() cil managed
  {
    .maxstack  1
    IL_0001:  newobj     instance void [type1]TYPE::.ctor()
    IL_000a:  ret
  }

  .method public hidebysig instance class [type2]TYPE type2() cil managed
  {
    .maxstack  1
    IL_0001:  newobj     instance void [type2]TYPE::.ctor()
    IL_000a:  ret
  }

  .method public hidebysig specialname rtspecialname 
          instance void  .ctor() cil managed
  {
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void [mscorlib]System.Object::.ctor()
    IL_0006:  ret
  } // end of method Test::.ctor


}

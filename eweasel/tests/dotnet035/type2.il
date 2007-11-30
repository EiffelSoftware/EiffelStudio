.assembly extern mscorlib { }

.assembly type2 {
	.ver 0:0:0:0
	.custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = ( 01 00 01 00 00 )
}

.class public TYPE extends [mscorlib]System.Object
{
  .method public hidebysig specialname rtspecialname instance void  .ctor() cil managed
  {
    .maxstack  8
    IL_0000:  ldarg.0
    IL_0001:  call       instance void [mscorlib]System.Object::.ctor()
    IL_0006:  ret
  } // end of method Test::.ctor


}

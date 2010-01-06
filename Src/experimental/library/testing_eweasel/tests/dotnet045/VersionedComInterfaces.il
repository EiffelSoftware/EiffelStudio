.assembly extern mscorlib
{
  .publickeytoken = (B7 7A 5C 56 19 34 E0 89 )                         // .z\V.4..
  .ver 2:0:0:0
}
.assembly VersionedComInterfaces
{
  .custom instance void [mscorlib]System.Reflection.AssemblyFileVersionAttribute::.ctor(string) = ( 01 00 07 31 2E 30 2E 30 2E 30 00 00 )             // ...1.0.0.0..
  .custom instance void [mscorlib]System.Runtime.InteropServices.GuidAttribute::.ctor(string) = ( 01 00 24 34 36 30 32 66 34 36 36 2D 34 34 34 33   // ..$4602f466-4443
                                                                                                  2D 34 38 62 61 2D 39 32 36 39 2D 34 37 66 33 37   // -48ba-9269-47f37
                                                                                                  39 38 65 37 37 65 35 00 00 )                      // 98e77e5..
  
  .hash algorithm 0x00008004
  .ver 1:0:0:0
}
.module VersionedComInterfaces.dll
.imagebase 0x00400000
.file alignment 0x00001000
.stackreserve 0x00100000
.subsystem 0x0003       // WINDOWS_CUI
.corflags 0x00000001    //  ILONLY

.class interface public abstract auto ansi import VersionedComInterfaces.IVersion
{
  .custom instance void [mscorlib]System.Runtime.InteropServices.GuidAttribute::.ctor(string) = ( 01 00 24 36 45 45 33 33 31 33 42 2D 46 43 43 46   // ..$6EE3313B-FCCF
                                                                                                  2D 34 30 33 35 2D 39 44 43 32 2D 42 42 44 30 38   // -4035-9DC2-BBD08
                                                                                                  44 43 38 31 42 36 36 00 00 )                      // DC81B66..
  .method public hidebysig newslot abstract virtual 
          instance int32  Apply() cil managed
  {
  } // end of method IVersion::Apply

} // end of class VersionedComInterfaces.IVersion

.class interface public abstract auto ansi import VersionedComInterfaces.IVersion2
       implements VersionedComInterfaces.IVersion
{
  .custom instance void [mscorlib]System.Runtime.InteropServices.GuidAttribute::.ctor(string) = ( 01 00 24 46 34 45 42 37 35 46 43 2D 46 42 31 33   // ..$F4EB75FC-FB13
                                                                                                  2D 34 41 32 46 2D 42 39 34 42 2D 42 45 30 42 45   // -4A2F-B94B-BE0BE
                                                                                                  35 46 42 38 41 41 37 00 00 )                      // 5FB8AA7..
  .method public hidebysig newslot abstract virtual 
          instance void  Apply() cil managed
  {
  } // end of method IVersion2::Apply

} // end of class VersionedComInterfaces.IVersion2

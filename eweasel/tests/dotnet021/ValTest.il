.assembly extern mscorlib { }

.assembly ValTest {
	.ver 0:0:0:0
	.custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = ( 01 00 01 00 00 )
}

.class sealed public Val1 extends [mscorlib]System.ValueType
{
	.method public hidebysig specialname rtspecialname instance void .ctor ()
	{
		ldstr	"V"
		call	void [mscorlib]System.Console::Write (string)
		ret
	}
	.field public int32 x
}

.class sealed public Val2 extends [mscorlib]System.ValueType
{
	.field public int32 x
	.field public int32 y
}

.class sealed public Enum16 extends [mscorlib]System.Enum
{
	.field public int16 MyValue
	.field public static literal valuetype Enum16 nul = int16 (      0)
	.field public static literal valuetype Enum16 one = int16 (      1)
	.field public static literal valuetype Enum16 min = int16 (-0x8000)
	.field public static literal valuetype Enum16 max = int16 ( 0x7FFF)
}

.class sealed public Enum32 extends [mscorlib]System.Enum
{
	.field public int32 MyValue
	.field public static literal valuetype Enum32 nul = int32 (          0)
	.field public static literal valuetype Enum32 one = int32 (          1)
	.field public static literal valuetype Enum32 min = int32 (-0x80000000)
	.field public static literal valuetype Enum32 max = int32 ( 0x7FFFFFFF)
}

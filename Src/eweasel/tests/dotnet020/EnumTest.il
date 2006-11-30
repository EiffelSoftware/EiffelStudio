.assembly extern mscorlib { }

.assembly EnumTest {
	.ver 0:0:0:0
	.custom instance void [mscorlib]System.CLSCompliantAttribute::.ctor(bool) = ( 01 00 01 00 00 )
}

.class sealed public EnumBool extends [mscorlib]System.Enum
{
	.field public bool MyValue
	.field public static literal valuetype EnumBool nul = int8 (0)
	.field public static literal valuetype EnumBool one = int8 (1)
	.field public static literal valuetype EnumBool min = int8 (0)
	.field public static literal valuetype EnumBool max = int8 (1)
}

.class sealed public EnumChar extends [mscorlib]System.Enum
{
	.field public char MyValue
	.field public static literal valuetype EnumChar nul = char (    0)
	.field public static literal valuetype EnumChar one = char (    1)
	.field public static literal valuetype EnumChar min = char (    0)
	.field public static literal valuetype EnumChar max = char (65535)
}

.class sealed public EnumInt8 extends [mscorlib]System.Enum
{
	.field public int8 MyValue
	.field public static literal valuetype EnumInt8 nul = int8 (    0)
	.field public static literal valuetype EnumInt8 one = int8 (    1)
	.field public static literal valuetype EnumInt8 min = int8 (-0x80)
	.field public static literal valuetype EnumInt8 max = int8 ( 0x7F)
}

.class sealed public EnumInt16 extends [mscorlib]System.Enum
{
	.field public int16 MyValue
	.field public static literal valuetype EnumInt16 nul = int16 (      0)
	.field public static literal valuetype EnumInt16 one = int16 (      1)
	.field public static literal valuetype EnumInt16 min = int16 (-0x8000)
	.field public static literal valuetype EnumInt16 max = int16 ( 0x7FFF)
}

.class sealed public EnumInt32 extends [mscorlib]System.Enum
{
	.field public int32 MyValue
	.field public static literal valuetype EnumInt32 nul = int32 (          0)
	.field public static literal valuetype EnumInt32 one = int32 (          1)
	.field public static literal valuetype EnumInt32 min = int32 (-0x80000000)
	.field public static literal valuetype EnumInt32 max = int32 ( 0x7FFFFFFF)
}

.class sealed public EnumInt64 extends [mscorlib]System.Enum
{
	.field public int64 MyValue
	.field public static literal valuetype EnumInt64 nul = int64 (                  0)
	.field public static literal valuetype EnumInt64 one = int64 (                  1)
	.field public static literal valuetype EnumInt64 min = int64 (-0x8000000000000000)
	.field public static literal valuetype EnumInt64 max = int64 ( 0x7FFFFFFFFFFFFFFF)
}

.class sealed public EnumIntPtr extends [mscorlib]System.Enum
{
	.field public native int MyValue
	.field public static literal valuetype EnumIntPtr nul = int32 (          0)
	.field public static literal valuetype EnumIntPtr one = int32 (          1)
	.field public static literal valuetype EnumIntPtr min = int32 (-0x80000000)
	.field public static literal valuetype EnumIntPtr max = int32 ( 0x7FFFFFFF)
}

.class sealed public EnumUInt8 extends [mscorlib]System.Enum
{
	.field public uint8 MyValue
	.field public static literal valuetype EnumUInt8 nul = uint8 (    0)
	.field public static literal valuetype EnumUInt8 one = uint8 (    1)
	.field public static literal valuetype EnumUInt8 min = uint8 (    0)
	.field public static literal valuetype EnumUInt8 max = uint8 ( 0xFF)
}

.class sealed public EnumUInt16 extends [mscorlib]System.Enum
{
	.field public uint16 MyValue
	.field public static literal valuetype EnumUInt16 nul = uint16 (      0)
	.field public static literal valuetype EnumUInt16 one = uint16 (      1)
	.field public static literal valuetype EnumUInt16 min = uint16 (      0)
	.field public static literal valuetype EnumUInt16 max = uint16 ( 0xFFFF)
}

.class sealed public EnumUInt32 extends [mscorlib]System.Enum
{
	.field public uint32 MyValue
	.field public static literal valuetype EnumUInt32 nul = uint32 (          0)
	.field public static literal valuetype EnumUInt32 one = uint32 (          1)
	.field public static literal valuetype EnumUInt32 min = uint32 (          0)
	.field public static literal valuetype EnumUInt32 max = uint32 ( 0xFFFFFFFF)
}

.class sealed public EnumUInt64 extends [mscorlib]System.Enum
{
	.field public uint64 MyValue
	.field public static literal valuetype EnumUInt64 nul = uint64 (                  0)
	.field public static literal valuetype EnumUInt64 one = uint64 (                  1)
	.field public static literal valuetype EnumUInt64 min = uint64 (                  0)
	.field public static literal valuetype EnumUInt64 max = uint64 ( 0xFFFFFFFFFFFFFFFF)
}

.class sealed public EnumUIntPtr extends [mscorlib]System.Enum
{
	.field public native unsigned int MyValue
	.field public static literal valuetype EnumUIntPtr nul = int32 (          0)
	.field public static literal valuetype EnumUIntPtr one = int32 (          1)
	.field public static literal valuetype EnumUIntPtr min = int32 (          0)
	.field public static literal valuetype EnumUIntPtr max = int32 ( 0xFFFFFFFF)
}



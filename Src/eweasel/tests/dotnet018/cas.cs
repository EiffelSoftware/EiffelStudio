using System;

namespace cas
{
	[AttributeUsageAttribute(AttributeTargets.All, AllowMultiple=true)] 
	public class CA:Attribute
	{
		public CA() {}
		public CA (bool b) { my_boolean = b; }
		public CA (char c) { my_char = c; }
		public CA (sbyte b) { my_sbyte = b; }
		public CA (short s) { my_short = s; }
		public CA (int i) { my_int = i; }
		public CA (long l) { my_long = l; }
		public CA (byte b) { my_byte = b; }
		public CA (ushort s) { my_ushort = s; }
		public CA (uint i) { my_uint = i; }
		public CA (ulong l) { my_ulong = l; }
		public CA (float f) { my_float = f; }
		public CA (double d) { my_double = d; }
		public CA (object o) { my_object = o; }
		public CA (EnumTest t) { my_enum = t; }
		public CA (string s) { my_string = s; }
		public CA (Type t) { my_type = t; }

		public CA (bool [] b) { my_boolean_array = b; }
		public CA (char [] c) { my_char_array = c; }
		public CA (sbyte [] b) { my_sbyte_array = b; }
		public CA (short [] s) { my_short_array = s; }
		public CA (int [] i) { my_int_array = i; }
		public CA (long [] l) { my_long_array = l; }
		public CA (byte [] b) { my_byte_array = b; }
		public CA (ushort [] s) { my_ushort_array = s; }
		public CA (uint [] i) { my_uint_array = i; }
		public CA (ulong [] l) { my_ulong_array = l; }
		public CA (float [] f) { my_float_array = f; }
		public CA (double [] d) { my_double_array = d; }
		public CA (object [] o) { my_object_array = o; }
		public CA (EnumTest [] t) { my_enum_array = t; }
		public CA (string [] s) { my_string_array = s; }
		public CA (Type [] t) { my_type_array = t; }

		public bool my_boolean;
		public char my_char;
		public sbyte my_sbyte;
		public short my_short;
		public int my_int;
		public long my_long;
		public byte my_byte;
		public ushort my_ushort;
		public uint my_uint;
		public ulong my_ulong;
		public float my_float;
		public double my_double;
		public object my_object;
		public EnumTest my_enum;
		public string my_string;
		public Type my_type;

		public bool [] my_boolean_array;
		public char [] my_char_array;
		public sbyte [] my_sbyte_array;
		public short [] my_short_array;
		public int [] my_int_array;
		public long [] my_long_array;
		public byte [] my_byte_array;
		public ushort [] my_ushort_array;
		public uint [] my_uint_array;
		public ulong [] my_ulong_array;
		public float [] my_float_array;
		public double [] my_double_array;
		public object [] my_object_array;
		public EnumTest [] my_enum_array;
		public string [] my_string_array;
		public Type [] my_type_array;
	}

	public enum EnumTest {
		toto,
		titi,
		tutu
	}
}

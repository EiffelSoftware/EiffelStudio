
#ifdef _MSC_VER
#pragma warning (disable:4172) // Returning address of local or temporary
#endif

// Memory related functions
// TODO: who says 'signed char*' is one byte?
// etc

int ewg_read_integer_8 (void* a_pointer, int a_pos)
{
  return (int)((signed char*)a_pointer)[a_pos];
}

void ewg_put_integer_8 (void* a_pointer, int a_int, int a_pos)
{
  ((signed char*)a_pointer)[a_pos] = (signed char) a_int;
}

int ewg_read_integer_16 (void* a_pointer, int a_pos)
{
  return *((short*)(((char*)a_pointer) + a_pos));
}

void ewg_put_integer_16 (void* a_pointer, int a_int, int a_pos)
{
  *((short*)(((char*)a_pointer) + a_pos)) = (short) a_int;
}

int ewg_read_integer_32 (void* a_pointer, int a_pos)
{
  return *((int*)(((char*)a_pointer) + a_pos));
}

void ewg_put_integer_32 (void* a_pointer, int a_int, int a_pos)
{
  *((int*)(((char*)a_pointer) + a_pos)) = (int) a_int;
}

int ewg_read_integer (void* a_pointer, int a_pos)
{
  return *((int*)(((char*)a_pointer) + a_pos));
}

void ewg_put_integer (void* a_pointer, int a_int, int a_pos)
{
  *((int*)(((char*)a_pointer) + a_pos)) = (int) a_int;
}

double ewg_read_real (void* a_pointer, int a_pos)
{
  return *((float*)(((char*)a_pointer) + a_pos));
}

// Note: REALs are 64 bits under Visual Eiffel (just like DOUBLEs)
void ewg_put_real (void* a_pointer, double a_real, int a_pos)
{
  *((float*)(((char*)a_pointer) + a_pos)) = (float) a_real;
}


double ewg_read_double (void* a_pointer, int a_pos)
{
  return *((double*)(((char*)a_pointer) + a_pos));
}

void ewg_put_double (void* a_pointer, double a_double, int a_pos)
{
  *((double*)(((char*)a_pointer) + a_pos)) = (double) a_double;
}

void* ewg_read_pointer (void* a_pointer, int a_pos)
{
  return *(void**)((int)a_pointer + a_pos);
}

void ewg_put_pointer (void* a_pointer, void* a_value, int a_pos)
{
  *(void**)((int)a_pointer + a_pos) = a_value;
}

void* ewg_reference_of (void* a_pointer)
{
  return (void*)(&a_pointer);
}

int ewg_bitwise_integer_or (int a_value_1, int a_value_2)
{
  return (a_value_1 | a_value_2);
}

int ewg_bitwise_integer_and (int a_value_1, int a_value_2)
{
  return (a_value_1 & a_value_2);
}

int ewg_bitwise_integer_xor (int a_value_1, int a_value_2)
{
  return (a_value_1 ^ a_value_2);
}

int ewg_sizeof_real (void)
{
  return sizeof (float);
}


#include <stdio.h>
#include <stdlib.h>
#include "eif_eiffel.h"
#include "eif_garcol.h"
#include "matisse_eif.h" 

/*
 * DEBUGGING SWITCH
 * ... mindlessly simple, but it does the trick...just choose which of
 * the following two lines of code you want to keep
 */
// #define DEBUG_PRINTF(a)	 fprintf a;
#define DEBUG_PRINTF(a)	 {};


#define BUFFERSIZE 512

MtSTS Result;

char Name[256];
char Buffer[BUFFERSIZE];
void *SValue;  /* Shared variable */
MtSize Vrank;
MtType VType; 
MtBoolean DValue;

/************************/
/*	Keys management	*/
/************************/

MtSize Keys_count;
MtKey *Keys;

EIF_INTEGER c_keys_count()
{
	return(Keys_count);
}

EIF_INTEGER c_ith_key(i)
EIF_INTEGER i;
{
	EIF_MT_LOG3("c_ith_key: Keys_count = %d, Keys[%d] = %d", Keys_count, i - 1, Keys[i - 1]);
	return(Keys[i-1]);
}


static int	keys_malloced;  // TRUE if Keys malloced in this
				// file rather than by MT API call

void c_free_keys()
{
    if (Keys != NULL) {
	DEBUG_PRINTF((stderr, "c_free_keys() - Keys == 0x%lx\n", Keys))
	if (keys_malloced) {
	    free(Keys);
	    keys_malloced = FALSE;
	} else
	    MtMFree(Keys);
	Keys = NULL;
    }
    else
        DEBUG_PRINTF((stderr, "c_free_keys() - nothing to do; Keys == 0x%lx\n", Keys))
}

/*--------------------------------------------*/
EIF_REFERENCE eif_array_area (obj)
/*--------------------------------------------*/
EIF_OBJ obj;
/*
 * Starting address of area associated with Eiffel object `obj'.
 * Object `obj' owns a reference to a special object or is a special
 * object.
 * Returns Void if no special object found.
 *
 */
{
   uint32 flags;
	EIF_OBJ object;
	char *o_ptr, *o_ref;
	long refer_count;
 
	object = obj;
	flags = HEADER(object)->ov_flags;
	if (flags & EO_SPEC) {
special: 
		if (!(flags & EO_REF) && (flags & EO_COMP))
			return (object + OVERHEAD);
		else return (object);
	}

	refer_count = References(flags & EO_TYPE);
	for (
		o_ptr = object; refer_count > 0 ;
		refer_count--, o_ptr = (char *)(((char **) o_ptr) +1)
	) {
		o_ref = *(char **)o_ptr;
      if (o_ref != (char *) 0) {
			object = o_ref;		
			flags = HEADER(object)->ov_flags;
			if (flags & EO_SPEC) {
				goto special;
			}
		}
	}
	return (NULL);
}

/*--------------------------------------------*/
long eif_array_count (obj)
/*--------------------------------------------*/
EIF_OBJ obj;
/* 
 * Number of allocated cells for `obj' with obj of type
 * ARRAY or SPECIAL else returns 0.
 *
 */
{
	union overhead *zone;
	uint32 flags;
	char *o_ref, *o_ptr;
	long refer_count;
	EIF_OBJ object;

	object = obj;
 	zone = HEADER(object);
	flags = zone->ov_flags;
	if (flags & EO_SPEC) {
special:
   	o_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
   	return (*(long *) o_ref);
	}	
	else {
		refer_count = References(flags & EO_TYPE);
		for (
			o_ptr = object; refer_count > 0 ;
			refer_count--, o_ptr = (char *)(((char **) o_ptr) +1)
		) {
			o_ref = *(char **)o_ptr;
			if (o_ref != (char *) 0) {
				object = o_ref;		
				zone = HEADER(object);
				flags = zone->ov_flags;
				if (flags & EO_SPEC) {
					goto special;
				}
			}
		}
		return ((long) 0);
	}
}

/************************/
/*	MT_ATTRIBUTE	*/
/************************/


/*
 * c_get_value(EIF_INTEGER oid, EIF_INTEGER aid)
 *   oid : id of object
 *   aid : id of attribute
 * Call Mt_MGetValue to get value.
 * Use c_get_*_value to get the value from Eiffel
 */
void c_get_value(EIF_INTEGER oid, EIF_INTEGER aid)
{
    Result = Mt_MGetValue(oid,aid,&VType,&SValue,&Vrank,&DValue);
    CHECK_STS(Result)
    DEBUG_PRINTF((stderr, "MT malloc SValue() == 0x%lx\n", SValue))
}


EIF_INTEGER c_get_byte_list_elements(EIF_INTEGER oid, EIF_INTEGER aid, MtU8 * buffer, 
	EIF_INTEGER count, EIF_INTEGER offset)
{
	MtSize num_elts = count;
	
	Result = Mt_GetListElts(oid, aid, MT_U8_LIST, buffer, &num_elts, offset);
	CHECK_STS(Result);
	return num_elts;
}

/* MtMFree */
void c_free_value(oid,aid)
EIF_INTEGER oid,aid;
{
    if (SValue != NULL){
        DEBUG_PRINTF((stderr, "c_free_value() - SValue == 0x%lx\n", SValue))
	MtMFree(SValue);
	SValue = NULL;
    }
    else
        DEBUG_PRINTF((stderr, "c_free_value() - nothing to do; SValue == 0x%lx\n", SValue))

}

/* MT_U8*/
EIF_INTEGER c_get_byte_value()
{
	return (EIF_INTEGER) (* (MtU8 *) SValue);
}

/* MT_S32 */
EIF_INTEGER c_get_integer_value()
{
	return (EIF_INTEGER) (* (MtS32 *) SValue);
}

/* MT_U32 */
EIF_INTEGER c_get_unsigned_int_value()
{
	return (EIF_INTEGER) (* (MtU32 *) SValue);
}

/* MT_S16 */
EIF_INTEGER c_get_short_value()
{
	return (EIF_INTEGER) (* (MtS16 *) SValue);
}

/* MT_U16 */
EIF_INTEGER c_get_unsigned_short_value()
{
	return (EIF_INTEGER) (* (MtU16 *) SValue);
}

/* MT_DOUBLE */
EIF_DOUBLE c_get_double_value()
{
	return (EIF_DOUBLE) (* (MtDouble *) SValue);
}

/* MT_FLOAT */
EIF_REAL c_get_real_value()
{
	return (EIF_REAL) (* (MtFloat *) SValue);
}

/*
 * c_get_char_value()
 *  Return character value.
 *  You can not call this function when the value is MTNIL
 */
/* MT_CHAR */
EIF_CHARACTER c_get_char_value()
{
	EIF_CHARACTER* one_character;
	one_character = (EIF_CHARACTER*) SValue;
	return(*one_character);
}

/* MT_STRING */
EIF_POINTER c_get_string_value()
{
	return((char*)SValue);
}

/*
 * c_get_boolean_value()
 */
/* MT_BOOLEAN */
EIF_BOOLEAN c_get_boolean_value()
{
	if ( *(MtBoolean *) SValue == MT_FALSE)
		return EIF_FALSE;
	else
		return EIF_TRUE;
}

/*
 * c_get_date_year()
 *  Return 'year' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_date_year()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->year);
}

/*
 * c_get_date_month()
 *  Return 'month' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_date_month()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->month);
}

/*
 * c_get_date_day()
 *  Return 'day' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_date_day()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->day);
}

/*
 * c_get_date_comp_days()
 * Return composed days of the date.
 *  i.e., day + (month * 100) + (year * 10000)
 */
EIF_INTEGER c_get_date_comp_days()
{
	int days;
	
	days = ((MtTimestamp *) SValue)->day;
	days = days + ((((MtTimestamp *) SValue)->month) * 100);
	days = days + ((((MtTimestamp *) SValue)->year) * 10000);
	return (EIF_INTEGER) days;
}

/*
 * c_get_timestamp_hour()
 *  Return 'hour' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_timestamp_hour()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->hour);
}

/*
 * c_get_timestamp_minute()
 *  Return 'minute' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_timestamp_minute()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->minute);
}

/*
 * c_get_timestamp_second()
 *  Return 'second' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_timestamp_second()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->second);
}

/*
 * c_get_timestamp_comp_seconds
 * Returns composite timestamp seconds,
 * i.e. second + (minute * 60) + (hour * 3600)
 */
EIF_INTEGER c_get_timestamp_comp_seconds()
{
	int seconds;
	
	seconds = ((MtTimestamp *) SValue)->second;
	seconds = seconds + ((((MtTimestamp *) SValue)->minute) * 60);
	seconds = seconds + ((((MtTimestamp *) SValue)->hour) * 3600);
	return (EIF_INTEGER) seconds;
}

/*
 * c_get_timestamp_microsecs()
 *  Return 'microsecs' field of the sturcture MtTimestamp.
 */
EIF_INTEGER c_get_timestamp_microsecs()
{
	return (EIF_INTEGER)  (((MtTimestamp *) SValue)->microsecs);
}

/*
 * c_get_time_interval_days()
 *  Return 'days' field of the sturcture MtTimeInterval.
 */
EIF_INTEGER c_get_time_interval_days()
{
/*	EIF_MT_LOG1("TimeInterval->sign = %d", ((MtTimeInterval *) SValue)->sign);
	EIF_MT_LOG1("TimeInterval->hour = %d", ((MtTimeInterval *) SValue)->hours);
	EIF_MT_LOG1("TimeInterval->minute = %d", ((MtTimeInterval *) SValue)->minutes); */
	return (EIF_INTEGER)  (((MtTimeInterval *) SValue)->days * 
						(((MtTimeInterval *) SValue) -> sign));
}

/*
 * c_get_time_interval_millisecs()
 *  Return milliseconds of MtTimeInterval.
 *   (calculate it)
 */
EIF_INTEGER c_get_time_interval_millisecs()
{
	int millisec;
	MtTimeInterval * ti;
	
	ti = (MtTimeInterval *) SValue;
	millisec = ti->hours * 3600 * 1000;
	millisec = millisec + (ti->minutes * 60 * 1000);
	millisec = millisec + (ti->seconds * 1000);
	millisec = millisec + (ti->microsecs / 1000);
	millisec = millisec * (ti->sign);
	return (EIF_INTEGER) millisec;
}

/*
 * c_get_time_interval_fine_seconds()
 *  Return double precision seconds of MtTimeInterval.
 *   (calculate it)
 */
EIF_DOUBLE c_get_time_interval_fine_seconds()
{
	int int_sec;
	double seconds;
	MtTimeInterval * ti;
	
	ti = (MtTimeInterval *) SValue;
	int_sec = ti->hours * 3600;
	int_sec = int_sec + (ti->minutes * 60);
	int_sec = int_sec + ti->seconds;
	seconds = ((double) int_sec) + (ti->microsecs / (double) (1000000.0));
	seconds = seconds * (ti->sign);
	return (EIF_DOUBLE) seconds;
}

/* Type */
EIF_INTEGER c_value_type()
{
	return(VType);
}

/*
  * MT_U8_LIST
  */
EIF_CHARACTER c_ith_list_character(EIF_INTEGER i)
{
	return (EIF_CHARACTER) (* (((MtU8 *) SValue) + (i - 1)));
}

/*
  * MT_S32_LIST
  */
EIF_INTEGER c_ith_list_integer(EIF_INTEGER i)
{
	return (EIF_INTEGER) (* (((MtS32 *) SValue) + (i - 1)));
}

/*
  * MT_U32_LIST
  */
EIF_INTEGER c_ith_list_unsigned_int(EIF_INTEGER i)
{
	return (EIF_INTEGER) (* (((MtU32 *)SValue) + (i - 1)));
}


/*
 * c_ith_list_short(EIF_INTEGER i)
 *  return short
 *  MT_S16_LIST
 */
EIF_INTEGER c_ith_list_short(EIF_INTEGER i)
{
	return (EIF_INTEGER) (* (((MtS16 *)SValue) + (i - 1)));
}


/*
 * c_ith_list_unsigned_short(EIF_INTEGER i)
 *  return unsigned-short
 *  MT_U16_LIST
 */
EIF_INTEGER c_ith_list_unsigned_short(EIF_INTEGER i)
{
	return (EIF_INTEGER) (* (((MtU16 *)SValue) + (i - 1)));
}


EIF_DOUBLE c_ith_list_double(i)
EIF_INTEGER i;
{
	return (EIF_DOUBLE) (* (((MtDouble *)SValue) + (i - 1)));
}

EIF_REAL c_ith_list_real(i)
EIF_INTEGER i;
{
	return (EIF_REAL) (* (((MtFloat *)SValue) + (i - 1)));
}

EIF_POINTER c_ith_list_string(i)
	EIF_INTEGER i;
{
	char** one_string;
	one_string = (char**) ((char**)SValue+(i-1));
	return(*one_string);
}

/* Set MT_S32 */
void c_set_value_integer(oid,aid,type,value,rank)
	EIF_INTEGER oid,aid,type,value,rank;
{
	MtS32 ivalue = value;
	Result = Mt_SetValue(oid,aid,type,&ivalue,rank);
	CHECK_STS(Result);
}

/*
 * c_set_value_u8()
 *  Set value: MT_U8
 */
void c_set_value_u8(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER value)
{
	MtU8 ivalue = (MtU8) value;
	Result = Mt_SetValue(oid, aid, MT_U8, &ivalue, 0);
	CHECK_STS(Result);
}

/*
 * c_set_value_s16()
 *  Set value: MT_S16
 */
void c_set_value_s16(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER value)
{
	MtS16 ivalue = (MtS16) value;
	Result = Mt_SetValue(oid, aid, MT_S16, &ivalue, 0);
	CHECK_STS(Result);
}

/*
 * c_set_value_u16()
 *  Set value: MT_U16
 */
void c_set_value_u16(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER value)
{
	MtU16 ivalue = (MtU16) value;
	Result = Mt_SetValue(oid, aid, MT_U16, &ivalue, 0);
	CHECK_STS(Result);
}

/*
 * c_set_value_u32()
 *  Set value: MT_U32
 */
void c_set_value_u32(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER value)
{
	MtU32 ivalue = (MtU32) value;
	Result = Mt_SetValue(oid, aid, MT_U32, &ivalue, 0);
	CHECK_STS(Result);
}

/* Set MT_DOUBLE */
void c_set_value_double(oid,aid,type,value,rank)
	EIF_INTEGER oid,aid,type;
	EIF_DOUBLE value;
	EIF_INTEGER rank;
{
	MtDouble ivalue = value;
	
	EIF_MT_LOG3("c_set_value_double: oid = %d, aid =%d, type = %d ", oid, aid, type);
	EIF_MT_LOG2("c_set_value_double: double = %f, rank =%d ", ivalue, rank);
	Result = Mt_SetValue(oid,aid,type,&ivalue,rank);
	CHECK_STS(Result);
}


/* Set MT_FLOAT */
void c_set_value_real(oid, aid, type, value, rank)
	EIF_INTEGER oid, aid, type;
	//float value;
	EIF_REAL value;
	EIF_INTEGER rank;
{
	MtFloat ivalue = (MtFloat) value;

	EIF_MT_LOG3("c_set_value_real: oid = %d, aid =%d, type = %d ", oid, aid, type);
	EIF_MT_LOG2("c_set_value_real: float= %f, rank =%d ", ivalue, rank);
//	Result = Mt_SetValue(oid, aid, type, &ivalue, rank);
	Result = Mt_SetValue(oid, aid, type, &ivalue, 0);
	EIF_MT_LOG("c_set_value_real: Mt_SetValue done.");
	CHECK_STS(Result);
}

/* Set MT_CHAR */
void c_set_value_char(oid,aid,type,value,rank)
	EIF_INTEGER oid,aid,type;
	EIF_CHARACTER value;
	EIF_INTEGER rank;
{
	MtChar ivalue = (MtChar) value;
	Result = Mt_SetValue(oid,aid,type,&ivalue,rank);
	CHECK_STS(Result);
}

/* Set MT_BOOLEAN */
void c_set_value_boolean(oid, aid, value)
	EIF_INTEGER oid,aid;
	EIF_BOOLEAN value;
{
	MtBoolean ivalue;
	EIF_MT_LOG1("c_set_value_boolean: value = %d", value);
	if (value == EIF_TRUE) {
		ivalue = MT_TRUE;
		EIF_MT_LOG1("c_set_value_boolean: true ivalue = %d", ivalue);
	}else{
		ivalue = MT_FALSE;
		EIF_MT_LOG1("c_set_value_boolean: false ivalue = %d", ivalue);
	}
	Result = Mt_SetValue(oid, aid, MT_BOOLEAN, &ivalue, 0);
	CHECK_STS(Result);
}

/* Set MT_DATE */
/*
 * c_set_value_date(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER year, month, day)
 */
void c_set_value_date(EIF_INTEGER oid, EIF_INTEGER aid, 
			EIF_INTEGER year, EIF_INTEGER month, EIF_INTEGER day)
{
	MtTimestamp date;

	date.year = (MtU16) year;
	date.month = (MtU16) month;
	date.day = (MtU16) day;

	date.hour = 0;
	date.minute = 0;
	date.second = 0;
	date.microsecs = 0;
	
	Result = Mt_SetValue(oid, aid, MT_DATE, (void *) &date, 0);
	CHECK_STS(Result);
}

/* Set MT_TIMESTAMP */
void c_set_value_timestamp(EIF_INTEGER oid, EIF_INTEGER aid, 
			EIF_INTEGER year, EIF_INTEGER month, EIF_INTEGER day,
			EIF_INTEGER hour, EIF_INTEGER minute, EIF_INTEGER second,
			EIF_INTEGER microsecond)
{
	MtTimestamp time;
	
	time.year = (MtU16) year;
	time.month = (MtU16) month;
	time.day = (MtU16) day;
	time.hour = (MtU16) hour;
	time.minute = (MtU16) minute;
	time.second = (MtU16) second;
	time.microsecs = (MtU32) microsecond;

	EIF_MT_LOG3("c_set_value_timestamp: year = %d, month = %d, day = %d", year, month, day);
	EIF_MT_LOG3("c_set_value_timestamp: hour = %d, minute = %d, second = %d", hour, minute, second);
	EIF_MT_LOG1("c_set_value_timestamp: microsecs = %d", microsecond);
	
	Result = Mt_SetValue(oid, aid, MT_TIMESTAMP, (void *) &time, 0);
	CHECK_STS(Result);
}

/* Set MT_TIME_INTERVAL */
/*
 * c_set_value_time_interval( oid,  aid,  days,  fine_seconds)
 *   It is guaranteed that both 'days' and 'milliseconds' have same sign
 */		
void c_set_value_time_interval(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER days, 
			EIF_DOUBLE fine_seconds)
{
	MtTimeInterval ti;
	int hour, minute, second;
	MtU32 microsecond;
	
	if (days > 0)
		ti.sign = MT_POSITIVE;
	else {
		ti.sign = MT_NEGATIVE;
		days = days * (-1);
		fine_seconds = fine_seconds * (-1);
	}
	
	ti.days = (MtU32) days;
	second = (int) fine_seconds;
	hour = second / 3600;
	second = second - (hour * 3600);
	minute = second / 60;
	second = second - (minute * 60);
	microsecond = (int) ((fine_seconds - ((int) fine_seconds)) * 1000000);
	
	ti.hours = (MtU16) hour;
	ti.minutes = (MtU16) minute;
	ti.seconds = (MtU16) second;
	ti.microsecs = (MtU32) microsecond;
	
	Result = Mt_SetValue(oid, aid, MT_TIME_INTERVAL, (void *) &ti, 0);
	CHECK_STS(Result);
}


/* Set MT_STRING */
void c_set_value_string(oid,aid,type,value,rank)
	EIF_INTEGER oid,aid,type;
	EIF_POINTER value;
	EIF_INTEGER rank;
{
	MtString ivalue= (MtString) value;
	Result = Mt_SetValue(oid, aid, type, (void*)ivalue, 0);
	CHECK_STS(Result);
}

EIF_INTEGER c_get_attribute(attribute_name)
	char* attribute_name;
{
	MtKey aid;
	Result = MtGetAttribute(&aid,attribute_name);
	CHECK_STS(Result);
	return(aid);
}

/*
 * c_get_attribute_ignore_nosuchatt(char * attribute_name)
 *
 *  Return an oid of attribute specified by 'attribute_name'.
 *  If no attribute is found, return 0. 
 *    (Ignore MATISSE_NOSUCHATT error)
 */
EIF_INTEGER c_get_attribute_ignore_nosuchatt(char * attribute_name)
{
	MtKey aid;
	Result = MtGetAttribute(&aid,attribute_name);
	if (Result == MATISSE_NOSUCHATT)
		return 0;
	else {
		CHECK_STS(Result);
		return(aid);
	}
}

/* Mt_CheckAttribute */
void c_check_attribute(attribute_id,object_id)
	EIF_INTEGER attribute_id,object_id;
{
	Result = Mt_CheckAttribute(attribute_id,object_id);
	CHECK_STS(Result);
}

/* Mt_GetDimension */
EIF_INTEGER c_get_dimension(object_id,attribute_id,rank)
	EIF_INTEGER object_id,attribute_id,rank;
{
	MtSize odimension;
	
	EIF_MT_LOG3("c_get_dimension: oid = %d, attr oid = %d, rank = %d", object_id, attribute_id, rank);
	Result = Mt_GetDimension(object_id, attribute_id, rank, &odimension);
	if (Result == MATISSE_INVALRANKINDEX) 
		return 0;   /** This is temporary. June 26, 98 **/
	else{
	CHECK_STS(Result);
	return(odimension); }
}

void c_set_value_array_numeric(oid,aid,type,value,rank)
	EIF_INTEGER oid,aid,type;
	EIF_OBJ value;
	EIF_INTEGER rank;
{
	long u;
	void *area;

	u = eif_array_count (value);
	area = (void *) eif_array_area (value);
	Result = Mt_SetValue(oid,aid,type,(void*)area,rank,u);
	CHECK_STS(Result);
}

/*
 * c_set_value_byte_list_elements(oid, aid, type, buffer, count, offset, discard_after)
 *  oid ... OID of object
 *  aid ... OID of attribute
 *  buffer ... pointer to Eiffel object of type ARRAY[CHARACTER] or
 *  count ... count (size) of buffer
 *  offset ... offset
 */
void c_set_value_byte_list_elements(EIF_INTEGER oid, EIF_INTEGER aid, 
		EIF_INTEGER type, MtU8 * buffer, EIF_INTEGER count,
		EIF_INTEGER offset, EIF_BOOLEAN discard_after)
{
	MtBoolean a_bool;
	
	a_bool = (MtBoolean) discard_after;
	EIF_MT_LOG3("c_set_value_byte_list_elements: %d %d %d", (MtU8) buffer[0], (MtU8) buffer[1], (MtU8) buffer[2]);
	
	if (offset == 0) 
		CHECK_STS(Mt_SetValue(oid, aid, type, NULL, 0));
	
	Result = Mt_SetListElts(oid, aid, type, (MtU8 *) buffer, count, offset, a_bool);
	CHECK_STS(Result);
}

/* Set MT_S16_ARRAY */
void c_set_value_short_array(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER type, 
			EIF_OBJ value, EIF_INTEGER rank)
{
	long u;
	int * area;
	MtS16 * short_array;
	int i;
	
	u = eif_array_count (value);
	area = (int *) eif_array_area (value);
	short_array = (MtS16 *) malloc(sizeof(MtS16) * u);
	for(i = 0; i < u; i++)
		short_array[i] = (MtS16) area[i];
	Result = Mt_SetValue(oid, aid, type, (void*)short_array, rank, u);
	free(short_array);
	CHECK_STS(Result);
}

/* Set MTS_U16_ARRAY */
void c_set_value_unsigned_short_array(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER type, 
			EIF_OBJ value, EIF_INTEGER rank)
{
	long u;
	int * area;
	MtU16 * ushort_array;
	int i;
	
	u = eif_array_count (value);
	area = (int *) eif_array_area (value);
	ushort_array = (MtU16 *) malloc(sizeof(MtU16) * u);
	for(i = 0; i < u; i++)
		ushort_array[i] = (MtU16) area[i];
	Result = Mt_SetValue(oid, aid, type, (void*) ushort_array, rank, u);
	free(ushort_array);
	CHECK_STS(Result);
}

/* Set MT_NIL */
void c_set_value_void(EIF_INTEGER oid, EIF_INTEGER aid, EIF_INTEGER type, 
			EIF_OBJ value, EIF_INTEGER rank)
{
	Result = Mt_SetValue(oid, aid, type, (void *) value, rank);
	CHECK_STS(Result);
}

/*
 * c_type_value(EIF_INTEGER aid)
 *   aid : oid of MtAttribute
 *
 */
EIF_INTEGER c_type_value(EIF_INTEGER aid)
{
    MtType tv=0,stype;
    MtS32 *ltypes;

	Result = MtMGetValue(aid,"Mt Type",&stype,(void*)&ltypes,NULL,NULL);
	CHECK_STS(Result);

    if (ltypes) tv = *ltypes;
    return tv;
}

/*
 * c_get_num_of_type(EIF_INTEGER aid)
 *  aid: oid of MtAttribute
 * 
 * Get a list of all types of MtAttribute aid,
 * Return the number of types of MtAttribute aid.
 * Use c_ith_list_integer to get each type
 */
EIF_INTEGER c_get_num_and_types(EIF_INTEGER aid)
{
	MtSize num;

	CHECK_STS(MtMGetValue(aid, "Mt Type", NULL, (void*)&SValue, NULL, NULL));
	CHECK_STS(MtGetDimension(aid, "Mt Type", 0, &num));
	return num;
}

/************************/
/*	MT_CLASS	*/
/************************/


/* MtGetClass */
EIF_INTEGER c_get_class_from_name(char * name)
{
	MtKey key;
	Result = MtGetClass(&key,name);
	CHECK_STS(Result);
	return(key);
}


/*
 * c_create_object_from_cid(EIF_INTEGER class_oid)
 * class_oid: Mtkey of a class 
 *
 * Create new MATISSE object then return new oid
 * Mt_CreateObject
 */
EIF_INTEGER c_create_object_from_cid(EIF_INTEGER class_oid)
{
	MtKey new_oid;
	
	CHECK_STS(Mt_CreateObject(&new_oid, class_oid));
	return new_oid;
}


/*
 * EIF_INTEGER c_create_object(name)
 *  name ... name of class
 * Return new oid of the class.
 */
EIF_INTEGER c_create_object(name)
char* name;
{
	MtKey key;
	Result = MtCreateObject(&key,name);
	CHECK_STS(Result);
	return(key);
}

/* MtGetObjectClass */
EIF_INTEGER c_get_object_class(EIF_INTEGER object_id)
{
	MtKey cid;
	
	Result = MtGetObjectClass(&cid,object_id);
	CHECK_STS(Result);
	return(cid);
}

/* Mt_MGetAllAttributes */
void c_get_all_attributes(EIF_INTEGER class_id)
{
	Result = Mt_MGetAllAttributes(&Keys_count,&Keys,class_id);
	CHECK_STS(Result);
}

/* Mt_MGetAllRelationships */
void c_get_all_relationships(EIF_INTEGER class_id)
{
	Result = Mt_MGetAllRelationships(&Keys_count,&Keys,class_id);
	CHECK_STS(Result);
}

/* Mt_MGetAllInverseRelationships */
void c_get_all_inverse_relationships(EIF_INTEGER class_id)
{
	/*Result = Mt_MGetAllIRelationships(&Keys_count,&Keys,class_id);*/
	Result = Mt_MGetAllInverseRelationships(&Keys_count,&Keys,class_id);
	CHECK_STS(Result);
}

void c_get_all_subclasses(EIF_INTEGER class_id)
{
	Result = Mt_MGetAllSubclasses(&Keys_count,&Keys,class_id);
	CHECK_STS(Result);
}

void c_get_all_superclasses(EIF_INTEGER class_id)
{
	Result = Mt_MGetAllSuperclasses(&Keys_count,&Keys,class_id);
	CHECK_STS(Result);
}

EIF_INTEGER c_get_instances_number(EIF_INTEGER class_id)
{
	MtSize instances_number;
	
	Result = Mt_GetInstancesNumber(&instances_number,class_id);
	CHECK_STS(Result);
	return(instances_number);
}

/*
 * MtGetValue 
 *  string value for attribute 'Mt Name'
 */
EIF_POINTER c_object_mt_name(EIF_INTEGER object_id)
{
	MtType stype;
	MtSize ssize=256;
	
	Result = MtGetValue(object_id,"Mt Name",&stype,(void*)Name,NULL,&ssize,0);
	CHECK_STS(Result);
	return(Name);
}

/* Mt_CreateNumObjects */
void c_create_num_objects(EIF_INTEGER n, EIF_INTEGER oid)
{
	Keys = (MtKey*) malloc(n*sizeof(MtKey));
	DEBUG_PRINTF((stderr, "malloc() - Keys == 0x%lx\n", Keys))
	Result = Mt_CreateNumObjects(n,Keys,oid);
	CHECK_STS(Result);
	keys_malloced = TRUE;
}

/************************/
/*	MT_CLASS_STREAM	*/
/************************/

/*
 *  EIF_POINTER c_open_instances_stream(class_id) 
 * c_open_instances_stream(class_id)
 *  Result type is MtStream which is mts_int32
 *   (changed in MATISSE4.0. In MATISSE3.0 MtStream was void *)
 */
EIF_INTEGER c_open_instances_stream(EIF_INTEGER class_id)
{
	MtStream rstream;
	
	Result = Mt_OpenInstancesStream(&rstream, class_id, 0);
	CHECK_STS(Result);
	return(rstream);
}

/* Used by class MATISSE */
void c_get_oids_of_classes(void)
{
	MtStream cstream;
	MtKey key;
	MtSize i;
	
	CHECK_STS(MtGetInstancesNumber(&Keys_count, MT_CLASS));
	Keys = (MtKey*) malloc(Keys_count * sizeof(MtKey));
	keys_malloced = TRUE;
	
	CHECK_STS(MtOpenInstancesStream(&cstream, MT_CLASS, MT_MAX_PREFETCHING));
	for(i = 0; i < Keys_count; i++){
		CHECK_STS(MtNextObject(cstream, &key));
		Keys[i] = key;
	}
	CHECK_STS(MtCloseStream(cstream));
}


/************************/
/*	MT_ENTRYPOINT	*/
/************************/

/*
 * c_get_objects_from_entry_point(attribute_id,class_id,entry_point_name)
 *  class_id can be NULL
 */
void c_get_objects_from_entry_point(EIF_INTEGER attribute_id, EIF_INTEGER class_id, 
                           char * entry_point_name)
{
	Result = Mt_MGetObjectsFromEntryPoint(&Keys_count,&Keys,entry_point_name,attribute_id,class_id);
	CHECK_STS(Result);
}

/*
 * c_get_objects_from_entry_point_name(attr_name, class_name, entry_point_name)
 *  class_name can be NULL
 */
void c_get_objects_from_entry_point_name(char * attr_name, char * class_name,
                                char * ep_name)
{
	Result = MtMGetObjectsFromEntryPoint(&Keys_count, &Keys, ep_name, attr_name, class_name);
	CHECK_STS(Result);
}

/*
 * c_lock_objects_from_entry_point(lock, ep_name, attribute_id, class_id)
 */
void c_lock_objects_from_entry_point(EIF_INTEGER lock, char * ep_name, EIF_INTEGER attribute_id, 
                            EIF_INTEGER class_id)
{
	Result = Mt_LockObjectsFromEntryPoint(lock, ep_name, attribute_id, class_id);
	CHECK_STS(Result);
}

/*
 * c_lock_objects_from_entry_point_name(lock, ep_name, attr_name, class_name)
 */
void c_lock_objects_from_entry_point_name(EIF_INTEGER lock, char * ep_name, char * attr_name, 
                                 char * class_name)
{
	Result = MtLockObjectsFromEntryPoint(lock, ep_name, attr_name, class_name);
	CHECK_STS(Result);
}

/********************************/
/*	MT_ENTRYPOINT_STREAM	*/
/********************************/

/*
 *  c_open_entry_point_stream(ep_name,attribute_id,class_id)
 *   Result type is MtStream (mts_int32)
 */
/*EIF_POINTER c_open_entry_point_stream(ep_name, attribute_id, class_id)*/
EIF_INTEGER c_open_entry_point_stream(ep_name, attribute_id, class_id, nb_obj_per_call)
	char* ep_name;
	EIF_INTEGER attribute_id, class_id, nb_obj_per_call;
{
	MtStream rstream;
	
	Result = Mt_OpenEntryPointStream(&rstream, ep_name, attribute_id, class_id, nb_obj_per_call);
	CHECK_STS(Result);
	return(rstream);
}

/************************/
/*	MT_INDEX	*/
/************************/


/* MtGetIndex */
EIF_INTEGER c_get_index(char * index_name)
{
	MtKey index_key;
	Result = MtGetIndex(&index_key,index_name);
	CHECK_STS(Result);
	return(index_key);
}


/*
 * c_index_entries_count(EIF_INTEGER oid)
 *  oid:  OID of MtIndex
 * Return the number of entries of the index specified by oid
 */
EIF_INTEGER c_index_entries_count(EIF_INTEGER oid)
{
	MtSize nbOfEntries;
	
	CHECK_STS(Mt_GetIndexInfo(oid, &nbOfEntries, NULL, NULL, NULL));
	return nbOfEntries;
}


MtIndexCriteriaInfo IndexCriteriaInfo;
MtSize NumOfCriteriaClasses;
MtKey CriteriaClasses[4];

/*
 * c_load_index_info(EIF_INTEGER oid)
 *   oid:  OID of MtIndex
 * Call MtGetIndexInfo and get criteria info and save them
 * in the global variables
 */
void c_load_index_info(EIF_INTEGER oid)
{
	NumOfCriteriaClasses = 4;
	CHECK_STS(Mt_GetIndexInfo(oid, NULL, &IndexCriteriaInfo,
			&NumOfCriteriaClasses, CriteriaClasses));
}

EIF_INTEGER c_get_index_criteria_count(void)
{
	return IndexCriteriaInfo.nbOfCriteria;
}

/*
 * c_get_index_criterion_attr_oid(int i)
 *   i: positional number of criteria
 * Return an attribute oid of i-th criterion
 */
EIF_INTEGER c_get_index_criterion_attr_oid(int i)
{
	return IndexCriteriaInfo.criteria[i].attributeKey;
}

/*
 * c_get_index_criterion_type(int i)
 *   i: positional number of criterion
 * Return a type of i-th criterion
 */
EIF_INTEGER c_get_index_criterion_type(int i)
{
	return IndexCriteriaInfo.criteria[i].type;
}

/*
 * c_get_index_criterion_size(int i)
 *   i: positional number of criterion
 * Return a size of i-th criterion
 */
EIF_INTEGER c_get_index_criterion_size(int i)
{
	return IndexCriteriaInfo.criteria[i].size;
}

/*
 * c_get_index_criterion_order(int i)
 *   i: positional number of criterion
 * Return an order of i-th criterion
 */
EIF_INTEGER c_get_index_criterion_order(int i)
{
	return IndexCriteriaInfo.criteria[i].order;
}

/*
 * c_get_index_classes_count(void)
 */
EIF_INTEGER c_get_index_classes_count(void)
{
	return NumOfCriteriaClasses;
}

/*
 * c_get_index_class(int i)
 *   i: positional number of index classes
 * Return i-th index class
 */
EIF_INTEGER c_get_index_class(int i)
{
	return CriteriaClasses[i];
}

/************************/
/*	MT_INDEX_STREAM	*/
/************************/

/*
 * c_open_index_entries_stream_by_name()
 *   index_name
 *   class_name
 *   directino: MTDIRECT or MTREVERSE
 *   crit_start_array: start-values of index
 *   crit_end_array: end-values of index
 *   nb_obj_per_call: prefetching
 *
 *  Result is MtStream (mts_int32)
 *   (changed in MATISSE4.0. In MATISSE3.0 MtStream was void *)
 */
EIF_INTEGER c_open_index_entries_stream_by_name(char * index_name, char * class_name,
                                EIF_INTEGER direction, EIF_OBJ crit_start_array, 
                                EIF_OBJ crit_end_array, EIF_INTEGER nb_obj_per_call)
{
    MtStream rstream;
    void **area_start_crit, **area_end_crit;
    MtSize count_start_crit;

    count_start_crit = eif_array_count (crit_start_array);
    area_start_crit = (void **) eif_array_area (crit_start_array);
    area_end_crit = (void **) eif_array_area (crit_end_array);

    Result = MtOpenIndexEntriesStream(&rstream,index_name,class_name,direction,
			   count_start_crit,area_start_crit,area_end_crit, nb_obj_per_call);
    CHECK_STS(Result);
    return(rstream);
}


/*
 * c_open_index_entries_stream(...see below...)
 *  almost same as c_open_index_entries_stream_by_name except some argument types
 */
EIF_INTEGER c_open_index_entries_stream(EIF_INTEGER index_oid, EIF_INTEGER class_oid,
                                EIF_INTEGER direction, EIF_INTEGER criteria_count,
                                EIF_OBJ crit_start_array, EIF_OBJ crit_end_array,
                                EIF_INTEGER nb_obj_per_call)
{
	MtStream rstream;
	void **area_start_crit, **area_end_crit;

	area_start_crit = (void **) eif_array_area (crit_start_array);
	area_end_crit = (void **) eif_array_area (crit_end_array);
	EIF_MT_LOG1("c_open_index_entries_stream: start value is %s", (char *) area_start_crit[0]);
	EIF_MT_LOG1("c_open_index_entries_stream: end value is %s", (char *) area_end_crit[0]);
	Result = Mt_OpenIndexEntriesStream(&rstream, index_oid, class_oid, direction,
			   criteria_count, area_start_crit, area_end_crit, nb_obj_per_call);
	CHECK_STS(Result);
	return(rstream);
}


/************************/
/*	MT_INFO	*/
/************************/

EIF_INTEGER c_max_buffered_objects()
{
	return(MtGetConfigurationInfo(MT_MAX_BUFFERED_OBJECTS));
}

EIF_INTEGER c_max_index_criteria_number()
{
	return(MtGetConfigurationInfo(MT_MAX_INDEX_CRITERIA_NUMBER));
}

EIF_INTEGER c_max_index_key_length()
{
	return(MtGetConfigurationInfo(MT_MAX_INDEX_KEY_LENGTH));
}

/* MtGetNumDataBytesReceived */
EIF_INTEGER c_get_num_data_bytes_received()
{
	MtLargeSize total;
	
	Result = MtGetNumDataBytesReceived(&total);
	CHECK_STS(Result);
	return(total);
}

/* MtGetNumDataBytesSent */
EIF_INTEGER c_get_num_data_bytes_sent()
{
	MtLargeSize total;
	
	Result = MtGetNumDataBytesSent(&total);
	CHECK_STS(Result);
	return(total);
}


/************************/
/*	MT_MESSAGE	*/
/************************/

EIF_INTEGER c_get_message(char * selector)
{
	MtKey key;

	Result = MtGetMessage(&key,selector);
	CHECK_STS(Result);
	return(key);
}

/************************/
/*	Mt_OBJECT	*/
/************************/

/* MtIsPredefinedObject */
EIF_BOOLEAN c_is_predefined_object(EIF_INTEGER oid)
{
	MtBoolean is_predefined_msp;
	
	Result = MtIsPredefinedObject(&is_predefined_msp,oid);
	CHECK_STS(Result);
	if (is_predefined_msp == MT_TRUE)
		return EIF_TRUE;
	else
		return EIF_FALSE;
}

/* MtCheckObject */
void c_check_object(EIF_INTEGER oid)
{
	Result = MtCheckObject(oid);
	CHECK_STS(Result);
}


/*
 * c_lock_object(oid,lock)
 * oid:  MATISSE object id
 * lock: Kind of lock (write/read)
 *
 * Redefine the original c_lock_object function written by ISE.
 * MtLockObjects
 */
void c_lock_object(EIF_INTEGER oid, EIF_INTEGER lock)
{
	CHECK_STS(MtLockObjects(1, oid, lock));
}


/*
 * c_write_lock_object(oid)
 * oid:  MATISSE object id
 *
 * Set write-lock on the object
 */
void c_write_lock_object(EIF_INTEGER oid)
{
	CHECK_STS(MtLockObjects(1, oid, MT_WRITE));
}


/*
 * c_read_lock_object(oid)
 * oid:  MATISSE object id
 *
 * Set read-lock on the object
 */
void c_read_lock_object(EIF_INTEGER oid)
{
	CHECK_STS(MtLockObjects(1, oid, MT_READ));
}	


/* Mt_RemoveValue */
void c_remove_value(EIF_INTEGER oid, EIF_INTEGER aid)
{
	Result = Mt_RemoveValue(oid,aid);
	CHECK_STS(Result);
}

/*
 * void c_remove_value_by_name(oid, attr_name)
 *  oid: Object ID
 *  attr_name: name of attribute
 */
/* MtRemoveValue */
void c_remove_value_by_name(EIF_INTEGER oid, char * attr_name)
{
	Result = MtRemoveValue(oid, attr_name);
	CHECK_STS_IGNERR(Result, MATISSE_NOVALUE);
}

/* MtRemoveObject */
void c_remove_object(EIF_INTEGER oid)
{
	Result = MtRemoveObject(oid);
	CHECK_STS(Result);
}


/*
 * c_remove_successor(pred_oid, rid, succ_oid)
 *   pred_oid: oid of predecessor
 *   rid: oid of relationship
 *   succ_oid: oid of successor to be removed
 */
void c_remove_successor(EIF_INTEGER pred_oid, EIF_INTEGER rid, EIF_INTEGER succ_oid)
{
	CHECK_STS(Mt_RemoveSuccessors(pred_oid, rid, 1, succ_oid));
}

/*
 * c_remove_successor(pred_oid, rid, succ_oid)
 *   pred_oid: oid of predecessor
 *   rid: oid of relationship
 *   succ_oid: oid of successor to be removed
 *  Remove a successor. Ignoring MATISSE_NOSUCHSUCC error
 */
void c_remove_successor_ignore_nosuchsucc(EIF_INTEGER pred_oid, EIF_INTEGER rid, 
								EIF_INTEGER succ_oid)
{
	CHECK_STS_IGNERR(Mt_RemoveSuccessors(pred_oid, rid, 1, succ_oid),
					MATISSE_NOSUCHSUCC);
}					

/* Mt_RemoveAllSuccessors */
void c_remove_all_successors(oid,rid)
	EIF_INTEGER oid,rid;
{
	Result = Mt_RemoveAllSuccessors(oid,rid);
	CHECK_STS(Result);
}

/* MtObjectSize */
EIF_INTEGER c_object_size(EIF_INTEGER oid)
{
	MtSize osize;

	Result = MtObjectSize(&osize,oid);
	CHECK_STS(Result);
	return(osize);
}

/* MtPrint */
void c_print_to_file(oid,file_pointer)
	EIF_INTEGER oid;
	EIF_POINTER file_pointer;
{
	Result = MtPrint(oid,(FILE*)file_pointer);
}

/* Mt_IsInstanceOf */
EIF_BOOLEAN c_is_instance_of(oid,cid)
	EIF_INTEGER oid,cid;
{
	MtBoolean typep;

	Result = Mt_IsInstanceOf(&typep, oid, cid);
	CHECK_STS(Result);
	if (typep == MT_TRUE)
		return EIF_TRUE;
	else
		return EIF_FALSE;
}

/* Mt_MGetAddedSuccessors */
void c_get_added_successors(oid,rid)
	EIF_INTEGER oid,rid;
{
	Result = Mt_MGetAddedSuccessors(&Keys_count,&Keys,oid,rid);
	CHECK_STS(Result);
}

/* Mt_MGetRemovedSuccessors */
void c_get_removed_successors(oid,rid)
	EIF_INTEGER oid,rid;
{
	Result = Mt_MGetRemovedSuccessors(&Keys_count,&Keys,oid,rid);
	CHECK_STS(Result);
}

/* Mt_MGetSuccessors */
void c_get_successors(oid,rid)
	EIF_INTEGER oid,rid;
{
	MtSize i;

	Result = Mt_MGetSuccessors(&Keys_count,&Keys,oid,rid);
	CHECK_STS(Result);
	DEBUG_PRINTF((stderr,"Mt_MGetSuccessors; Keys=%lx Result=%lx\n",Keys, Result))

	EIF_MT_LOG( "c_get_successors");
	for(i = 0; i < Keys_count; i++){
		EIF_MT_LOG2("%d-th: %d", i, Keys[i]);
	}
}

/*
 * c_get_single_successor(EIF_INTEGER pred_oid, EIF_INTEGER rid)
 *   pred_oid: OID of predecessor
 *   rid: OID of relationship
 * Return the single successor. 
 * If the number of the successor is zero, return 0.
 * If the number of the successor is one, return the successor oid.
 * If the number of the successor is more than one, return -1.
 */
EIF_INTEGER c_get_single_successor(EIF_INTEGER pred_oid, EIF_INTEGER rid)
{
	MtSize count;
	MtKey *succ_keys;
	
	CHECK_STS(Mt_MGetSuccessors(&count, &succ_keys, pred_oid, rid));
	if (count == 0)
		return 0;
	else {
		if (count == 1)
			return succ_keys[0];
		else
			return -1;
	}
	
}

/* Mt_MGetPredecessors */
void c_get_predecessors(oid,rid)
	EIF_INTEGER oid,rid;
{
	Result = Mt_MGetPredecessors(&Keys_count,&Keys,oid,rid);
	CHECK_STS(Result);
}

/* MtFreeObjects */
void c_free_object(oid)
EIF_INTEGER oid;
{
	MtKey key;

	key = oid;
	Result = MtFreeObjects(1,&key);
	CHECK_STS(Result);
}

/* Mt_AddSuccessor MT_FIRST */
void c_add_successor_first(oid,rid,soid)
	EIF_INTEGER oid,rid,soid;
{
	Result = Mt_AddSuccessor(oid,rid,soid,MT_FIRST);
	CHECK_STS(Result);
}

/*
 * c_get_objec_class(EIF_INTEGER oid)
 *  MtGetObjectClass
 *
 * return oid of class of object oid
 */
EIF_INTEGER c_get_objec_class(EIF_INTEGER oid)
{
	MtKey a_class;

	CHECK_STS(MtGetObjectClass(&a_class, oid));
	return a_class;
}

/*
 * c_add_successor_append(EIF_INTEGER oid, EIF_INTEGER rid, EIF_INTEGER soid)
 *  Add a successor in the end of list
 *
 * Mt_AddSuccessor MT_APPEND
 */
void c_add_successor_append(EIF_INTEGER oid, EIF_INTEGER rid, EIF_INTEGER soid)
{
	Result = Mt_AddSuccessor(oid, rid, soid, MT_APPEND);
	CHECK_STS(Result);
}

/*  Mt_AddSuccessor MT_AFTER */
void c_add_successor_after(oid,rid,soid,ooid)
	EIF_INTEGER oid,rid,soid,ooid;
{
	Result = Mt_AddSuccessor(oid,rid,soid,MT_AFTER,ooid);
	CHECK_STS(Result);
}

/* MtLoadObjects */
void c_load_object(EIF_INTEGER oid)
{
	Result = MtLoadObjects(1,oid);
	CHECK_STS(Result);
}

/********************************/
/*	MT_OBJECT_ATT_STREAM	*/
/********************************/

/* MtOpenAttributesStream */
EIF_INTEGER c_open_attributes_stream(EIF_INTEGER oid)
{
	MtStream rstream;

	Result = MtOpenAttributesStream(&rstream,oid);
	CHECK_STS(Result);
	return(rstream);
}

/********************************/
/*	MT_OBJECT_IREL_STREAM	*/
/********************************/

/* MtOpenInverseRelationshipsStream */
EIF_INTEGER c_open_inverse_relationships_stream(EIF_INTEGER oid)
{
	MtStream rstream;

	Result = MtOpenInverseRelationshipsStream(&rstream,oid);
	CHECK_STS(Result);
	return(rstream);
}

/********************************/
/*	MT_OBJECT_REL_STREAM	*/
/********************************/


/* MtOpenRelationshipsStream */
EIF_INTEGER c_open_relationships_stream(EIF_INTEGER oid)
{
	MtStream rstream;
	
	Result = MtOpenRelationshipsStream(&rstream,oid);
	CHECK_STS(Result);
	return(rstream);
}

/************************/
/*	Mt_PROPERTY	*/
/************************/

/* Mt_CheckProperty */
void c_check_property(pid,oid)
	EIF_INTEGER pid,oid;
{
	Result = Mt_CheckProperty(pid,oid);
	CHECK_STS(Result);
}

/************************/
/*	Mt_RELATIONSHIP	*/
/************************/

/* MtGetRelationship */
EIF_INTEGER c_get_relationship_from_name(char * name)
{
	MtKey key;

	Result = MtGetRelationship(&key,name);
	CHECK_STS(Result);
	return(key);
}

/* Mt_CheckRelationship */
void c_check_relationship(relationship_id,object_id)
	EIF_INTEGER relationship_id,object_id;
{
	Result = Mt_CheckRelationship(relationship_id,object_id);
	CHECK_STS(Result);
}

/*
 * c_get_relationship_class_name(EIF_INTEGER rid)
 *
 *  rid: OID of relationship instance
 *  Return the name of class of 'rid'
 */
EIF_POINTER c_get_relationship_class_name(EIF_INTEGER rid)
{
	MtKey a_class;
	MtSize size = 255;
	
	CHECK_STS(MtGetObjectClass(&a_class, rid));
	CHECK_STS(MtGetValue(a_class, MT_NAME, NULL, (void*) Name, NULL, &size, NULL));
	return Name;
}


/********************************/
/*	MT_RELATIONSHIP_STREAM	*/
/********************************/

/* Mt_OpenSuccessorsStream */
EIF_INTEGER c_open_successors_stream(oid, rid)
	EIF_INTEGER oid, rid;
{
	MtStream rstream;

	Result = Mt_OpenSuccessorsStream(&rstream,oid,rid);
	CHECK_STS(Result);
	return(rstream);
}

/* MtOpenSuccessorsStream */
EIF_INTEGER c_open_successors_stream_by_name(EIF_INTEGER oid, char * rel_name)
{
	MtStream rstream;

	Result = MtOpenSuccessorsStream(&rstream, oid, rel_name);
	CHECK_STS(Result);
	return(rstream);
}


/********************************/
/*	MT_IRELATIONSHIP_STREAM	*/
/********************************/

/* Mt_OpenPredecessorsStream */
EIF_INTEGER c_open_predecessors_stream(oid,rid)
	EIF_INTEGER oid,rid;
{
	MtStream rstream;

	Result = Mt_OpenPredecessorsStream(&rstream,oid,rid);
	CHECK_STS(Result);
	return(rstream);
}


/************************/
/*	Mt_STREAM	*/
/************************/

/*
 * c_next_object(sid)
 *  sid: Matisse stream (MtStream)
 * If the status of MtNextObject() is MATISSE_ENDOFSTREAM, then
 * return -1 which indicates "End of stream".
 * Otherwise return the object id.
 *
 * Type of MtStream has changed to Integer in MATISSE 4.0
 *
 * MtNextObject
 */
EIF_INTEGER c_next_object(EIF_INTEGER sid)
{
	MtKey key;
	
	Result = MtNextObject(sid,&key);
	if (Result == MATISSE_ENDOFSTREAM){
		EIF_MT_LOG2("status = %d; oid = %d", Result, key);
		return (-1); /* End_of_stream */
	}
	else
		CHECK_STS(Result)
	return(key);
}

EIF_INTEGER c_next_property(EIF_INTEGER sid)
	/*EIF_POINTER sid;*/
	/* Type of MTStream has changed to Integer in MATISSE 4.0*/
{
	MtKey key;
	MtBoolean specified_p;

	Result = MtNextProperty(sid,&key,&specified_p);
	return(key);
}

void c_close_stream(EIF_INTEGER sid)
	/*EIF_POINTER sid;*/
	/* Type of MTStream has changed to Integer in MATISSE 4.0*/	
{
	Result = MtCloseStream(sid);
	CHECK_STS(Result);
}



/************************/
/*	MT_TIME_STREAM	*/
/************************/

/*
 * c_open_version_stream()
 *  Result type is MtStream (mts_int32)
 */
EIF_INTEGER c_open_version_stream()
{
	MtStream rstream;

	Result = MtOpenVersionStream(&rstream);
	CHECK_STS(Result);
	return(rstream);
}


void c_next_version(sid)
	/*EIF_POINTER sid;*/
	/* Type of MtStream has changed to Integer in MATISSE 4.0 */
	EIF_INTEGER sid;
{
	Result = MtNextVersion(sid, Buffer, BUFFERSIZE);
	CHECK_STS(Result);
}

/************************/
/*	MT_DB_CONTROL	*/
/************************/


/*
 * c_allocate_connection
 *
 * Call MtAllocateConnection() and return the allocated structure.
 */
EIF_INTEGER c_allocate_connection()
{
	MtConnection connection;
	
	CHECK_STS(MtAllocateConnection(&connection))
	return (EIF_INTEGER) connection;
}

/* MtFreeConnection */
void c_free_connection(EIF_INTEGER connection)
{
	CHECK_STS(MtFreeConnection((MtConnection) connection));
}

/* MtSetConnectionOption */
void c_set_connection_option(EIF_INTEGER connection, EIF_INTEGER option, 
		EIF_INTEGER new_value)
{
	CHECK_STS(MtSetConnectionOption( (MtConnection) connection, option, new_value));
}

/* MtGetConnectionOption */
EIF_INTEGER c_get_connection_option(EIF_INTEGER connection, EIF_INTEGER option)
{
	int value;
	
	CHECK_STS(MtGetConnectionOption( (MtConnection) connection, option, &value));
	return value;
}

/* MtConnectDatabase */
void c_connect_database(EIF_INTEGER connection, char * host_name, 
					char * database_name, char * user_name, char * password)
{
	EIF_MT_LOG("c_connect_database");
	Result = MtConnectDatabase((MtConnection) connection, host_name, database_name, user_name, password);
	EIF_MT_LOG("c_connect_database done.");
}

/* MtDisconnectDatabase */
void c_disconnect_database(EIF_INTEGER connection)
{
	CHECK_STS(MtDisconnectDatabase((MtConnection) connection));
}


/* MtCurrentConnection */
EIF_INTEGER c_current_connection(void)
{
	return MtCurrentConnection();
}

/* MtSetCurrentConnection */
void c_set_current_connection(EIF_INTEGER connection)
{
	CHECK_STS(MtSetCurrentConnection( (MtConnection) connection));
}

/* MtNoCurrentConnection */
/*  Deselect the current database connection.
 *  If no database connection is selected, just ignore the 
 *  MATISSE_NOCURRENTCONNECTION error
 */
void c_no_current_connection()
{
	CHECK_STS_IGNERR(MtNoCurrentConnection(), MATISSE_NOCURRENTCONNECTION);
}


/*
 * c_start_transaction(EIF_INTEGER priority)
 *   priority: a priority of transaction
 */
void c_start_transaction(EIF_INTEGER priority)
{
	Result = MtStartTransaction(priority);
	CHECK_STS(Result);
}

/* MtCommitTransaction */
void c_commit_transaction()
{
	Result = MtCommitTransaction(NULL,NULL);
	CHECK_STS(Result);
}

/* MtAbortTransaction */
void c_rollback()
{
	Result = MtAbortTransaction();
	CHECK_STS(Result);
}

/* MtStartVersionAccess */
void c_start_version_access(char * time_name)
{
	Result = MtStartVersionAccess(time_name);
	CHECK_STS(Result);
}

/* MtEndVersionAccess */
void c_end_version_access()
{
	Result = MtEndVersionAccess();
	CHECK_STS(Result);
}


/* MtGetInvalidObject */
EIF_INTEGER c_get_invalid_object()
{
	return(MtGetInvalidObject());
}

/*--------------------------------------------*/
 EIF_POINTER c_error()
/*--------------------------------------------*/
{
	return(MtError());
}

/*--------------------------------------------*/
 EIF_INTEGER c_is_ok()
/*--------------------------------------------*/
{
	return(MtSuccess(Result));
}

/*--------------------------------------------*/
 EIF_BOOLEAN c_is_check_error()
/*--------------------------------------------*/
{
	return(MtCheckErrorP(Result));
}

/*--------------------------------------------*/
 void c_perror(head)
/*--------------------------------------------*/
char* head;
{
	MtPError(head);
}

/*--------------------------------------------*/
 EIF_POINTER c_full_error()
/*--------------------------------------------*/
{
	return(MtError());
}

/*--------------------------------------------*/
 EIF_INTEGER c_failure()
/*--------------------------------------------*/
{
	return(MtFailure(Result));
}

/*--------------------------------------------*/
 EIF_INTEGER c_result()
/*--------------------------------------------*/
{
return(Result);
}

/*--------------------------------------------*/
 EIF_INTEGER c_matisse_success()
/*--------------------------------------------*/
{
MtSTS one_success = MATISSE_SUCCESS;
return(one_success);
}


/************************/
/*	MT_ATTACH	*/
/************************/

///*--------------------------------------------*/
// void clip(rp,rname,rargs)
///*--------------------------------------------*/
//EIF_POINTER rp,rname,rargs;
//{
//MtServiceDef function[1];
//function[0].name = rname;
//function[0].fct =(MtServiceFct)rp;
//Result = MtInitialize(1,function);
//}

///*--------------------------------------------*/
// void c_call_service_function(EIF_INTEGER oid, EIF_INTEGER aid, EIF_OBJ at_object)
///*--------------------------------------------*/
//{
//eif_adopt(at_object);
///*Result = Mt_CallServiceFunction(aid,oid,eif_access(at_object));*/
//eif_wean(at_object);
//}


#include "jni.h"
#include "eif_eiffel.h"

#define jprintf
#define DEVELOPER_EXCEPTION 24

char * my_thread_id () {
	char *name= (char*) malloc (8*sizeof(char));		
#ifdef EIF_THREADS
		sprintf(name,"%x", eif_thr_thread_id());
#else
		sprintf(name,"00");
#endif

	return (name);
}
	
void c_check_for_exceptions (JNIEnv *env) {
  if ((*env)->ExceptionOccurred (env) != NULL) {
	  (*env)->ExceptionDescribe (env);
	  (*env)->ExceptionClear (env);
	  /* Raise Eiffel exception */
	  eraise ("Java exception occurred", DEVELOPER_EXCEPTION);
  }
}

jint c_throw_java_exception (JNIEnv *env, jthrowable exception) {
	return (*env)->Throw (env, exception);
}

jint c_throw_custom_exception (JNIEnv *env, jclass clazz, const char *message) {
	return (*env)->ThrowNew (env, clazz, message);
}

/*----------------------------------------------------*/
/* Setting up JVM stuff.                              */
/*----------------------------------------------------*/

/* Get default parms for the JVM */
JDK1_1InitArgs *get_default_vm_args () {
  JDK1_1InitArgs *vm_args;

  vm_args = (JDK1_1InitArgs *) malloc (sizeof (JDK1_1InitArgs));
  JNI_GetDefaultJavaVMInitArgs (vm_args);
  return (vm_args);
}

/* Create and load a JVM */
jint create_jvm (JavaVM **p_vm, JNIEnv **p_env, JDK1_1InitArgs *vm_args, char *class_path) {
  jint err;
  vm_args->classpath = class_path;
  err = JNI_CreateJavaVM (p_vm, p_env, vm_args);
  return (err);
}

/* Destroy a JVM */

jint destroy_jvm (JavaVM **jvm) {
	jint err;
	err = (**jvm)->DestroyJavaVM (*jvm);
//	err = JNI_DestroyJavaVM ();
	return (err);
}

/*----------------------------------------------------*/
/* Class operations.                                  */
/*----------------------------------------------------*/

/* Find a class */
jclass jni_find_class (JNIEnv *env, const char *name) {
  jclass cls;
  cls = (*env)->FindClass (env, name);
  c_check_for_exceptions (env);
  return (cls);
}

/* Find class of an object */
jclass c_get_object_class (JNIEnv *env, jobject oid) {
  jclass result;
  result = (*env)->GetObjectClass (env, oid);
  c_check_for_exceptions (env);
  return (result);
}

/* Attach the current thread to the JVM */
jint c_attach_current_thread (JavaVM **p_vm, JNIEnv **p_env, void *args) {
	jint result;
	result = (**p_vm)->AttachCurrentThread (*p_vm, p_env, args);
	c_check_for_exceptions (*p_env);
	return (result);
}

/* Detach the current thread of the JVM */
jint c_detach_current_thread (JavaVM **jvm, JNIEnv **env) {
	jint result;
	result = (**jvm)->DetachCurrentThread(*jvm);
	c_check_for_exceptions (*env);
	return (result);
}

/*----------------------------------------------------*/
/* Calls to static methods.                           */
/*----------------------------------------------------*/

/* Find static method */
jmethodID c_get_static_method_id (JNIEnv *env, jclass cls, const char *name, const char *sig) {
	jmethodID result = (*env)->GetStaticMethodID (env, cls, name, sig);
	c_check_for_exceptions (env);
	return (result);
}

/* Call static method */
void c_call_static_void_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args) {
	(*env)->CallStaticVoidMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
}

EIF_BOOLEAN c_call_static_boolean_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jboolean b;
	b = (*env)->CallStaticBooleanMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_BOOLEAN)b;
}

EIF_CHARACTER c_call_static_char_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jchar c;
	c = (*env)->CallStaticCharMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER)c;
}

EIF_INTEGER c_call_static_short_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jshort j;
	j = (*env)->CallStaticShortMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_INTEGER)j;
}

EIF_INTEGER c_call_static_int_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jint j;
	j = (*env)->CallStaticIntMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_INTEGER)j;
}

EIF_REAL c_call_static_float_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jfloat j;
	j = (*env)->CallStaticFloatMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_REAL)j;
}

EIF_DOUBLE c_call_static_double_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jdouble j;
	j = (*env)->CallStaticDoubleMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_DOUBLE)j;
}

EIF_CHARACTER c_call_static_byte_method  (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jbyte b;

	b = (*env)->CallStaticByteMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) b;
}


EIF_OBJ c_call_static_string_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args) {
	jstring js;

	js = (*env)->CallStaticObjectMethodA (env, cls, methodID, args);

	if (js != NULL) {
		/* Now make an Eiffel string out of the result */
		const char *str = (*env)->GetStringUTFChars (env, js, 0);
		EIF_OBJ result = RTMS ((char *)str);
		(*env)->ReleaseStringUTFChars (env, js, str);
		c_check_for_exceptions (env);
		return (result);
	}
}

jobject	c_call_static_object_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args) {
	jobject jo = (*env)->CallStaticObjectMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (jo);
}

void c_call_void_method (JNIEnv *env, jobject object, jmethodID methodID, jvalue *args) {
	(*env)->CallVoidMethodA (env, object, methodID, args);
	c_check_for_exceptions (env);
}



/*----------------------------------------------------*/
/* Instance methods calls.                            */
/*----------------------------------------------------*/

/* Find a method */
jmethodID c_get_method_id (JNIEnv *env, jclass cls, const char *name, const char *sig) {
	jmethodID result = (*env)->GetMethodID (env, cls, name, sig);
	c_check_for_exceptions (env);
	return (result);
}


EIF_OBJ c_call_string_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args) {
	jstring js;
char *id = my_thread_id ();
	js = (*env)->CallObjectMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	if (js != NULL) {
		/* Now make an Eiffel string out of the result */
		const char *str = (*env)->GetStringUTFChars (env, js, 0);
		EIF_OBJ result = RTMS ((char *)str);
		(*env)->ReleaseStringUTFChars (env, js, str);
		return (result);
	}
}

EIF_BOOLEAN c_call_boolean_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jboolean b;

	char *id= my_thread_id ();

	jprintf ("before calling Java\n");

	b = (*env)->CallBooleanMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);

	jprintf ("after calling Java with returned value %s\n", b?"TRUE":"FALSE");

 	return (EIF_BOOLEAN) b;
}

EIF_CHARACTER c_call_byte_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jbyte b;
char *id = my_thread_id ();
	b = (*env)->CallByteMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) b;
}

EIF_CHARACTER c_call_char_method  (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jchar c;
char *id = my_thread_id ();
	c = (*env)->CallCharMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) c;
}


EIF_INTEGER c_call_int_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args) {
	jint i;

	char *id = my_thread_id ();

	i = (*env)->CallIntMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_INTEGER) i;
}

EIF_INTEGER c_call_short_method  (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jshort s;
char *id = my_thread_id ();
	s = (*env)->CallShortMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_INTEGER) s;
}

EIF_REAL c_call_float_method  (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jfloat f;
char *id = my_thread_id ();
	f = (*env)->CallFloatMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_REAL) f;
}

EIF_DOUBLE c_call_double_method  (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args)
{
	jdouble d;
	char *id= my_thread_id ();
	d = (*env)->CallDoubleMethodA (env, cls, methodID, args);
	c_check_for_exceptions (env);
	return (EIF_DOUBLE) d;
}

jobject	c_call_object_method (JNIEnv *env, jclass cls, jmethodID methodID, jvalue *args) {
	char *id = my_thread_id ();
	jobject jo = (*env)->CallObjectMethodA (env, cls, methodID, args);
  	c_check_for_exceptions (env);
  	return (jo);
}

/*----------------------------------------------------*/
/* Java object creation.                              */
/*----------------------------------------------------*/

/* Create a new Java object */
jobject c_new_object (JNIEnv *env, jclass cls, jmethodID method, jvalue *args) {
  jobject result = (*env)->NewObjectA (env, cls, method, args);
  c_check_for_exceptions (env);
  return (result);
}


/*----------------------------------------------------*/
/* Field access.                                      */
/*----------------------------------------------------*/


/* Get a field ID for a field in a class */
jfieldID c_get_field_id (JNIEnv *env, jclass cls, const char *name, const char *sig) {
  jfieldID result = (*env)->GetFieldID (env, cls, name, sig);
  c_check_for_exceptions (env);
  return (result);
}

jfieldID c_get_static_field_id (JNIEnv *env, jclass cls, const char *name, const char *sig) {
  jfieldID result = (*env)->GetStaticFieldID (env, cls, name, sig);
  c_check_for_exceptions (env);
  return (result);
}

/* Get the value of an integer field */
jint c_get_integer_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jint value = (*env)->GetIntField (env, oid, fid);
	c_check_for_exceptions (env);
	return (value);
}

jint c_get_static_integer_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jint value = (*env)->GetStaticIntField (env, oid, fid);
	c_check_for_exceptions (env);
	return (value);
}

EIF_OBJ c_get_string_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jstring str_oid;
	const char *str;
	EIF_OBJ result;
	str_oid = (*env)->GetObjectField (env, oid, fid);
	c_check_for_exceptions (env);
	/* Now make an Eiffel string out of the result */
	str = (*env)->GetStringUTFChars (env, str_oid, 0);
	result = RTMS ((char *)str);
	(*env)->ReleaseStringUTFChars (env, str_oid, str);
	return (result);
}

EIF_OBJ c_get_static_string_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jstring str_oid;
	const char *str;
	EIF_OBJ result;
	str_oid = (*env)->GetStaticObjectField (env, oid, fid);
	c_check_for_exceptions (env);
	/* Now make an Eiffel string out of the result */
	str = (*env)->GetStringUTFChars (env, str_oid, 0);
	result = RTMS ((char *)str);
	(*env)->ReleaseStringUTFChars (env, str_oid, str);
	return (result);
}

EIF_BOOLEAN c_get_boolean_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jboolean value = (*env)->GetBooleanField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_BOOLEAN) value;
}

EIF_BOOLEAN c_get_static_boolean_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jboolean value = (*env)->GetStaticBooleanField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_BOOLEAN) value;
}

EIF_CHARACTER c_get_char_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jchar value = (*env)->GetCharField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) value;
}

EIF_CHARACTER c_get_static_char_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jchar value = (*env)->GetStaticCharField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) value;
}


EIF_REAL c_get_float_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jfloat value = (*env)->GetFloatField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_REAL) value;
}

EIF_REAL c_get_static_float_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jfloat value = (*env)->GetStaticFloatField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_REAL) value;
}

EIF_DOUBLE c_get_double_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jdouble value = (*env)->GetDoubleField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_DOUBLE) value;
}

EIF_DOUBLE c_get_static_double_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jdouble value = (*env)->GetStaticDoubleField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_DOUBLE) value;
}

EIF_CHARACTER c_get_byte_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jbyte value = (*env)->GetByteField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) value;
}

EIF_CHARACTER c_get_static_byte_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jbyte value = (*env)->GetStaticByteField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) value;
}

EIF_INTEGER c_get_short_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jshort value = (*env)->GetByteField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_INTEGER) value;
}

EIF_INTEGER c_get_static_short_field (JNIEnv *env, jobject oid, jfieldID fid) {
	jshort value = (*env)->GetStaticByteField (env, oid, fid);
	c_check_for_exceptions (env);
	return (EIF_INTEGER) value;
}

/* Get value of an object attribute */
jobject c_get_object_field (JNIEnv *env, jobject oid, jfieldID fid) {
  jobject result;
  result = (*env)->GetObjectField (env, oid, fid);
  c_check_for_exceptions (env);
  return (result);
}

jobject c_get_static_object_field (JNIEnv *env, jobject oid, jfieldID fid) {
  jobject result = (*env)->GetStaticObjectField (env, oid, fid);
  c_check_for_exceptions (env);
  return (result);
}

/*--------------------------------------------*/
/* Setting Field 							  */
/*--------------------------------------------*/

void c_set_integer_field ( JNIEnv *env, jobject oid, jfieldID fid, jint value) {
	(*env)->SetIntField(env, oid, fid, value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_integer_field ( JNIEnv *env, jobject oid, jfieldID fid, jint value) {
	(*env)->SetStaticIntField (env, oid, fid, value);
	c_check_for_exceptions (env);
	return;
}

void c_set_string_field ( JNIEnv *env, jobject oid, jfieldID fid, char * value) {
	(*env)->SetObjectField(env, oid, fid, (*env)-> NewStringUTF (env, value));
	c_check_for_exceptions (env);
	return;
}

void c_set_static_string_field ( JNIEnv *env, jobject oid, jfieldID fid, char * value) {
	(*env)->SetStaticObjectField(env, oid, fid, (*env)-> NewStringUTF (env, value));
	c_check_for_exceptions (env);
	return;
}

void c_set_object_field ( JNIEnv *env, jobject oid, jfieldID fid, jobject value) {
	(*env)->SetObjectField(env, oid, fid, value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_object_field ( JNIEnv *env, jobject oid, jfieldID fid, jobject value) {
	(*env)->SetStaticObjectField(env, oid, fid, value);
	c_check_for_exceptions (env);
	return;
}

void c_set_boolean_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_BOOLEAN value) {
	(*env)->SetBooleanField(env, oid, fid, (jboolean) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_boolean_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_BOOLEAN value) {
	(*env)->SetStaticBooleanField(env, oid, fid, (jboolean) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_char_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_CHARACTER value) {
	(*env)->SetCharField(env, oid, fid, (jchar) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_char_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_CHARACTER value) {
	(*env)->SetStaticCharField(env, oid, fid, (jchar) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_float_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_REAL value) {
	(*env)->SetFloatField(env, oid, fid, (jfloat) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_float_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_REAL value) {
	(*env)->SetStaticFloatField(env, oid, fid, (jfloat) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_double_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_DOUBLE value) {
	(*env)->SetDoubleField(env, oid, fid, (jdouble) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_double_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_DOUBLE value) {
	(*env)->SetStaticDoubleField(env, oid, fid, (jdouble) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_byte_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_CHARACTER value) {
	(*env)->SetByteField(env, oid, fid, (jbyte) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_byte_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_CHARACTER value) {
	(*env)->SetStaticByteField(env, oid, fid, (jbyte) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_short_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_INTEGER value) {
	(*env)->SetShortField(env, oid, fid, (jshort) value);
	c_check_for_exceptions (env);
	return;
}

void c_set_static_short_field ( JNIEnv *env, jobject oid, jfieldID fid, EIF_INTEGER value) {
	(*env)->SetStaticShortField(env, oid, fid, (jshort) value);
	c_check_for_exceptions (env);
	return;
}

/*----------------------------------------------------*/
/* Argument list handling.                            */
/*----------------------------------------------------*/

/* Allocate argument list */
jvalue *c_allocate_java_args (int count) {
	return ((jvalue *)malloc (sizeof (jvalue) * count));
}

/* Free argument list */
void c_free_java_args (jvalue *args) {
	free (args);
}

void c_put_float_arg (JNIEnv *env,jvalue args[],EIF_REAL value,int pos) {
	args[pos].f = (jfloat) value;
}

void c_put_boolean_arg (JNIEnv *env,jvalue args[],EIF_BOOLEAN value,int pos) {
	args[pos].z = (jboolean) value;
}

void c_put_double_arg (JNIEnv *env,jvalue args[],EIF_DOUBLE value,int pos) {
	args[pos].d = (jdouble) value;
}

void c_put_int_arg (JNIEnv *env, jvalue args[], EIF_INTEGER value, int pos) {
	args[pos].i = (jint) value;
}

void c_put_short_arg (JNIEnv *env, jvalue args[], EIF_INTEGER value, int pos) {
	args[pos].s = (jshort) value;
}

void c_put_char_arg (JNIEnv *env, jvalue args[], EIF_CHARACTER value, int pos) {
	args[pos].c = (jchar) value;
}

void c_put_object_arg (JNIEnv *env, jvalue args[], jobject value, int pos) {
	args[pos].l = value;
}

void c_put_string_arg (JNIEnv *env, jvalue args[], const char *value, int pos) {
	/* Make Java String from C-string */
	jstring str = (*env)->NewStringUTF (env, value);
	args[pos].l = str;
}

/*----------------------------------------------------*/
/* Array access.                                      */
/*----------------------------------------------------*/

int c_get_array_length (JNIEnv *env, jarray array) {
	int result = (*env)->GetArrayLength (env, array);
	c_check_for_exceptions (env);
	return (result);
}

jarray c_new_object_array (JNIEnv *env, jsize len, jclass elementClass, jobject initElement) {
	jarray result;
	result = (*env)->NewObjectArray (env, len, elementClass, initElement);
	c_check_for_exceptions (env);
	return (result);
}

jobject	c_get_object_array_element (JNIEnv *env, jarray array, int indx) {
	jobject result;
	result = (*env)->GetObjectArrayElement (env, array, indx);
	c_check_for_exceptions (env);
	return (result);
}

void c_set_object_array_element (JNIEnv *env, jarray array, int indx, jobject value) {
	(*env)->SetObjectArrayElement (env, array, indx, value);
	c_check_for_exceptions (env);
}

jcharArray c_new_char_array (JNIEnv *env,jsize len) {
	jcharArray ja = (*env)->NewCharArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_char_array_element (JNIEnv *env, jcharArray array, int indx, jchar jc) {
	jchar *c;
	jboolean copy;

	c = (*env)->GetCharArrayElements (env, array, &copy);
	c[indx] = jc;
	(*env)->ReleaseCharArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_CHARACTER c_get_char_array_element (JNIEnv *env, jcharArray array, int indx) {
	jchar *c;
	jboolean copy;
	jchar jc;

	c = (*env)->GetCharArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseCharArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) jc;
}

jbyteArray c_new_byte_array (JNIEnv *env,jsize len) {
	jbyteArray ja = (*env)->NewByteArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_byte_array_element (JNIEnv *env, jbyteArray array, int indx, jchar jc) {
	jbyte *c;
	jboolean copy;

	c = (*env)->GetByteArrayElements (env, array, &copy);
	c[indx] = (jbyte)jc;
	(*env)->ReleaseByteArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_CHARACTER c_get_byte_array_element (JNIEnv *env, jbyteArray array, int indx) {
	jbyte *c;
	jboolean copy;
	jbyte jc;

	c = (*env)->GetByteArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseByteArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_CHARACTER) jc;
}

jintArray c_new_int_array (JNIEnv *env,jsize len) {
	jintArray ja = (*env)->NewIntArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_int_array_element (JNIEnv *env, jintArray array, int indx, jint jc) {
	jint *c;
	jboolean copy;

	c = (*env)->GetIntArrayElements (env, array, &copy);
	c[indx] = jc;
	(*env)->ReleaseIntArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_INTEGER c_get_int_array_element (JNIEnv *env, jintArray array, int indx) {
	jint *c;
	jboolean copy;
	jint jc;

	c = (*env)->GetIntArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseIntArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_INTEGER) jc;
}

jbooleanArray c_new_boolean_array (JNIEnv *env,jsize len) {
	jbooleanArray ja = (*env)->NewBooleanArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_boolean_array_element (JNIEnv *env, jbooleanArray array, int indx, jboolean jc) {
	jboolean *c;
	jboolean copy;

	c = (*env)->GetBooleanArrayElements (env, array, &copy);
	c[indx] = jc;
	(*env)->ReleaseBooleanArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_BOOLEAN c_get_boolean_array_element (JNIEnv *env, jbooleanArray array, int indx) {
	jboolean *c;
	jboolean copy;
	jboolean jc;

	c = (*env)->GetBooleanArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseBooleanArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_BOOLEAN) jc;
}

jshortArray c_new_short_array (JNIEnv *env,jsize len) {
	jshortArray ja = (*env)->NewShortArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_short_array_element (JNIEnv *env, jfloatArray array, int indx, jshort jc) {
	jshort *c;
	jboolean copy;

	c = (*env)->GetShortArrayElements (env, array, &copy);
	c[indx] = jc;
	(*env)->ReleaseShortArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_INTEGER c_get_short_array_element (JNIEnv *env, jshortArray array, int indx) {
	jshort *c;
	jboolean copy;
	jshort jc;

	c = (*env)->GetShortArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseShortArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_INTEGER) jc;
}

jfloatArray c_new_float_array (JNIEnv *env,jsize len) {
	jfloatArray ja = (*env)->NewFloatArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_float_array_element (JNIEnv *env, jfloatArray array, int indx, jfloat jc) {
	jfloat *c;
	jboolean copy;

	c = (*env)->GetFloatArrayElements (env, array, &copy);
	c[indx] = jc;
	(*env)->ReleaseFloatArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_REAL c_get_float_array_element (JNIEnv *env, jfloatArray array, int indx) {
	jfloat *c;
	jboolean copy;
	jfloat jc;

	c = (*env)->GetFloatArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseFloatArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_REAL) jc;
}

jintArray c_new_double_array (JNIEnv *env,jsize len) {
	jintArray ja = (*env)->NewDoubleArray (env,len);
	c_check_for_exceptions (env);
	return ja;
}

void c_set_double_array_element (JNIEnv *env, jdoubleArray array, int indx, jdouble jc) {
	jdouble *c;
	jboolean copy;

	c = (*env)->GetDoubleArrayElements (env, array, &copy);
	c[indx] = jc;
	(*env)->ReleaseDoubleArrayElements (env, array, c, 0);
	c_check_for_exceptions (env);
}

EIF_DOUBLE c_get_double_array_element (JNIEnv *env, jdoubleArray array, int indx) {
	jdouble *c;
	jboolean copy;
	jdouble jc;

	c = (*env)->GetDoubleArrayElements (env, array, &copy);
	jc = c[indx];
	if (copy == JNI_TRUE) (*env)->ReleaseDoubleArrayElements (env, array, c, JNI_ABORT);
	c_check_for_exceptions (env);
	return (EIF_DOUBLE) jc;
}



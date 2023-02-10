

# CIL Object Model

## Containers

### Data
The base class `CIL_DATA_CONTAINER`  contains other data_containers or code_containers  means it can contain namespaces, classes, methods, or fields.
The main assemblyref which holds everything is one of these,which means it acts as the 'unnamed' namespace.

```
	CIL_DATA_CONTAINER
		- CIL_ASSEMBLY
		- CIL_CLASS
			- CIL_ENUM
		- CIL_NAMESPACE
```

### Code

The base class `CIL_CODE_CONTAINER` contains instructions / labels.


```
	CIL_CODE_CONTAINER
		- CIL_METHOD 
```


## Values
The base class `CIL_VALUE`  represent a value., typically to be used as an operand.
Various other classes derive from this to make specific types of operand values.


```
	CIL_VALUE
		- CIL_LOCAL
		- CIL_METHOD_NAME
		- CIL_PARAM
```

## Operand
The class `CIL_OPERAND` represent an operand to an instruccion.


## Type
The class `CIL_TYPE` represent the type of a field or value

```
	CIL_TYPE
		- CIL_BOXED_TYPE
```	

## Instruction
The class `CIL_INSTRUCTION` represent a cil instruction.



## Property
The class `CIL_PROPERTY` represent classic properties, extensions are not supported.

## Attributes
The class `CIL_CUSTOM_ATTRIBUTE_CONTAINER` hold custom attributes. Used to retrive
attributes from .Net assemblyes. Generation is not supported.

## Metadata

The class `DNL_TABLE` tepresent tables that can appear in a PE file.

The cluster `table` holds the tables and indexes used to register the metadata about the assembly.

The class `PE_INDEX_BASE` is the base class for indexing, it defines the tag type 	
tag type (which indicates which table the index belongs with) and an index value.

The class `PE_TABLE_ENTRY_BASE` represent the base class for the metadata tables.


## PE_LIB
This is the main to instantiate
The creation procedure creates a working assembly, you put all your code and data into that. 
Using `PE_LIB` you can dump to either .IL, .EXE, or .DLL format.

This library create an object model representing the assembly elements. (Classes, Types, Methods, Instructions, etc).
When the library dump it traverse the AST and generate .IL, .EXE or .DLL.
This library does not support by default to retrieve the metadata about the assembly in the current defined object modl.




## Metadata API
The Metadata API Provides methods to create, modify, and save metadata about the assembly in the currently defined scope.

The main class `CIL_METADATA_EMIT` represent a set of in-memory metadata tables and creates a unique module version identifier (GUID) for the metadata. The class has the ability to add entries to the metadata tables and define the assembly information in the metadata.

This API is work in progress.



### Process to add a new feature is:
Look at the MD_EMIT class and copy the signature of the feature we want to write,
since we can use the same MD_ classes (I'm just adding a prefix CIL_MD) because in I think one class requires a very specific implementation for windows, so, for now, I've decided to duplicate them. At the moment the new CD_MD_METADATA_EMIT has at the moment the same interface as the MD_EMIT.
2.  Check PE_LIB (PE_WRITER class and the related classes used to populate the related classes)
3.  Check ECMA metadata tables and use the provided token to get the required data. (ECMA standard section II.22 Metadata logical format : tables)







